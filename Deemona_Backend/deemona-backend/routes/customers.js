// routes/customers.js  (MySQL)
'use strict';
const router = require('express').Router();
const bcrypt = require('bcryptjs');
const { body, param } = require('express-validator');
const pool   = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, selfOrAdmin, toInt } = require('../middleware');

// GET /api/customers
router.get('/', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { search, status, tier, city, sortBy='registered', sortDir='desc' } = req.query;
  const where = ['1=1']; const params = [];

  if (search) { where.push('(c.FirstName LIKE ? OR c.LastName LIKE ? OR c.Email LIKE ? OR c.PhoneNumber LIKE ?)'); const q=`%${search}%`; params.push(q,q,q,q); }
  if (status) { where.push('c.AccountStatus=?'); params.push(status); }
  if (tier)   { where.push('c.LoyaltyTier=?');   params.push(tier); }
  if (city)   { where.push('c.City LIKE ?');      params.push(`%${city}%`); }

  const sortMap = { registered:'c.RegistrationDate', name:'c.FirstName', points:'c.LoyaltyPoints', lastlogin:'c.LastLogin', email:'c.Email' };
  const orderBy = `${sortMap[sortBy]||'c.RegistrationDate'} ${sortDir==='asc'?'ASC':'DESC'}`;

  // Total count
  const [countRows] = await pool.execute(
    `SELECT COUNT(*) AS total FROM Customers c WHERE ${where.join(' AND ')}`, params
  );
  const total = countRows[0].total;

  const [rows] = await pool.execute(
    `SELECT c.CustomerID,c.FirstName,c.LastName,c.Email,c.PhoneNumber,
            c.City,c.State,c.LoyaltyPoints,c.LoyaltyTier,c.AccountStatus,c.RegistrationDate,c.LastLogin,
            COUNT(DISTINCT o.OrderID) AS OrderCount,
            IFNULL(SUM(o.TotalAmount),0) AS LifetimeValue
     FROM Customers c
     LEFT JOIN Orders o ON o.CustomerID=c.CustomerID AND o.Status NOT IN ('cancelled','refunded')
     WHERE ${where.join(' AND ')}
     GROUP BY c.CustomerID ORDER BY ${orderBy}
     LIMIT ${Number(limit)} OFFSET ${Number(offset)}`, params
  );
  ok(res, { customers:rows, pagination:{ total, page, limit, pages:Math.ceil(total/limit) } });
}));

// GET /api/customers/:id
router.get('/:id', authenticate, selfOrAdmin('id'), [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const id = toInt(req.params.id);
    const [[profile], [stats], [recent], [wishCount]] = await Promise.all([
      pool.execute(`SELECT CustomerID,FirstName,LastName,Email,PhoneNumber,Address,City,State,PostalCode,Country,
                          LoyaltyPoints,LoyaltyTier,PreferredPaymentMethod,RegistrationDate,LastLogin,AccountStatus
                   FROM Customers WHERE CustomerID=?`, [id]),
      pool.execute(`SELECT COUNT(*) AS TotalOrders, IFNULL(SUM(TotalAmount),0) AS LifetimeValue,
                          IFNULL(AVG(TotalAmount),0) AS AvgOrderValue,
                          SUM(Status='delivered') AS Delivered,SUM(Status='cancelled') AS Cancelled
                   FROM Orders WHERE CustomerID=?`, [id]),
      pool.execute('SELECT OrderID,OrderDate,TotalAmount,Status FROM Orders WHERE CustomerID=? ORDER BY OrderDate DESC LIMIT 5', [id]),
      pool.execute('SELECT COUNT(*) AS Cnt FROM Wishlist WHERE CustomerID=?', [id]),
    ]);
    if (!profile.length) return fail(res, 'Customer not found', 404);
    ok(res, { ...profile[0], stats:stats[0], recentOrders:recent, wishlistCount:wishCount[0].Cnt });
  })
);

// POST /api/customers
router.post('/', authenticate, adminOnly,
  [body('firstName').notEmpty(), body('lastName').notEmpty(), body('email').isEmail().normalizeEmail()], validate,
  wrap(async (req,res) => {
    const { firstName, lastName, email, phone, address, city, state, postalCode, accountStatus='active' } = req.body;
    const [ex] = await pool.execute('SELECT 1 FROM Customers WHERE Email=?', [email]);
    if (ex.length) return fail(res, 'Email already registered', 409);
    const hash = await bcrypt.hash('TempPass'+Date.now(), 12);
    const [result] = await pool.execute(
      'INSERT INTO Customers(FirstName,LastName,Email,PhoneNumber,Address,City,State,PostalCode,AccountStatus,PasswordHash) VALUES(?,?,?,?,?,?,?,?,?,?)',
      [firstName,lastName,email,phone||null,address||null,city||null,state||null,postalCode||null,accountStatus,hash]
    );
    ok(res, { customerID:result.insertId, message:'Customer created.' }, 201);
  })
);

// PUT /api/customers/:id
router.put('/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { firstName, lastName, phone, address, city, state, postalCode, loyaltyPoints } = req.body;
    await pool.execute(
      `UPDATE Customers SET
         FirstName     = IFNULL(?,FirstName), LastName   = IFNULL(?,LastName),
         PhoneNumber   = IFNULL(?,PhoneNumber), Address  = IFNULL(?,Address),
         City          = IFNULL(?,City), State            = IFNULL(?,State),
         PostalCode    = IFNULL(?,PostalCode),
         LoyaltyPoints = IFNULL(?,LoyaltyPoints), UpdatedAt = NOW()
       WHERE CustomerID=?`,
      [firstName||null,lastName||null,phone||null,address||null,city||null,state||null,postalCode||null,loyaltyPoints!=null?parseInt(loyaltyPoints):null,toInt(req.params.id)]
    );
    ok(res, { message:'Customer updated' });
  })
);

// PATCH /api/customers/:id/status
router.patch('/:id/status', authenticate, adminOnly,
  [param('id').isInt(), body('status').isIn(['active','inactive','suspended','deleted'])], validate,
  wrap(async (req,res) => {
    await pool.execute('UPDATE Customers SET AccountStatus=?,UpdatedAt=NOW() WHERE CustomerID=?', [req.body.status, toInt(req.params.id)]);
    ok(res, { message:`Status updated to '${req.body.status}'` });
  })
);

// PATCH /api/customers/:id/loyalty
router.patch('/:id/loyalty', authenticate, adminOnly,
  [param('id').isInt(), body('adjustment').isInt(), body('reason').notEmpty()], validate,
  wrap(async (req,res) => {
    const { adjustment, reason } = req.body;
    const id = toInt(req.params.id);
    const [rows] = await pool.execute('SELECT LoyaltyPoints FROM Customers WHERE CustomerID=?', [id]);
    const newPts = Math.max(0, (rows[0]?.LoyaltyPoints||0) + adjustment);
    await pool.execute('UPDATE Customers SET LoyaltyPoints=? WHERE CustomerID=?', [newPts, id]);
    await pool.execute('INSERT INTO LoyaltyAdjustments(CustomerID,Adjustment,Reason,AdjustedBy,AdjustedAt) VALUES(?,?,?,?,NOW())', [id, adjustment, reason, String(req.user.id)]);
    ok(res, { previousPoints:rows[0]?.LoyaltyPoints, newPoints:newPts, adjustment });
  })
);

// DELETE /api/customers/:id
router.delete('/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute("UPDATE Customers SET AccountStatus='deleted',UpdatedAt=NOW() WHERE CustomerID=?", [toInt(req.params.id)]);
    ok(res, { message:'Customer account deactivated' });
  })
);

// GET /api/customers/:id/orders
router.get('/:id/orders', authenticate, selfOrAdmin('id'), [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { page, limit, offset } = paginate(req.query);
    const id = toInt(req.params.id);
    const [[countRow]] = await pool.execute('SELECT COUNT(*) AS total FROM Orders WHERE CustomerID=?', [id]);
    const [rows] = await pool.execute(
      `SELECT o.OrderID,o.OrderDate,o.TotalAmount,o.Status,o.PaymentMethod,o.CouponCode,o.DeliveryDateEstimate,
              COUNT(oi.OrderItemID) AS ItemCount
       FROM Orders o LEFT JOIN OrderItems oi ON oi.OrderID=o.OrderID
       WHERE o.CustomerID=? GROUP BY o.OrderID ORDER BY o.OrderDate DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
      []

    );
    ok(res, { orders:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
  })
);

// GET /api/customers/:id/reviews
router.get('/:id/reviews', authenticate, selfOrAdmin('id'), [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute(
      `SELECT r.ReviewID,r.ProductID,p.Name AS ProductName,r.Rating,r.Title,r.Comment,r.ReviewDate,r.VerifiedPurchase,r.ModerationStatus
       FROM Reviews r INNER JOIN Products p ON p.ProductID=r.ProductID
       WHERE r.CustomerID=? ORDER BY r.ReviewDate DESC`, [toInt(req.params.id)]
    );
    ok(res, rows);
  })
);

module.exports = router;
