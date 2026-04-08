// routes/missing.js  — Missing Routes (MySQL)
'use strict';
const router  = require('express').Router();
const crypto  = require('crypto');
const bcrypt  = require('bcryptjs');
const { body, param, query } = require('express-validator');
const pool    = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, toInt } = require('../middleware');

// ── Addresses ──────────────────────────────────────────────

router.get('/addresses', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute('SELECT * FROM CustomerAddresses WHERE CustomerID=? ORDER BY IsDefault DESC,CreatedAt DESC', [req.user.id]);
  ok(res, rows);
}));

router.post('/addresses',
  [body('fullName').notEmpty().trim(), body('phone').notEmpty(), body('line1').notEmpty(),
   body('city').notEmpty(), body('state').notEmpty(), body('pinCode').notEmpty(),
   body('addressType').optional().isIn(['home','work','other'])], validate,
  wrap(async (req,res) => {
    const { fullName,phone,line1,line2,city,state,pinCode,country='India',addressType='home',isDefault=false } = req.body;
    if (isDefault) await pool.execute('UPDATE CustomerAddresses SET IsDefault=0 WHERE CustomerID=?', [req.user.id]);
    const [[countRow]] = await pool.execute('SELECT COUNT(*) AS Cnt FROM CustomerAddresses WHERE CustomerID=?', [req.user.id]);
    const setDefault = isDefault || countRow.Cnt===0;
    const [result] = await pool.execute(
      'INSERT INTO CustomerAddresses(CustomerID,FullName,Phone,Line1,Line2,City,State,PinCode,Country,AddressType,IsDefault) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      [req.user.id,fullName,phone,line1,line2||null,city,state,pinCode,country,addressType,setDefault?1:0]
    );
    ok(res, { addressID:result.insertId, message:'Address saved' }, 201);
  })
);

router.put('/addresses/:id', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { fullName,phone,line1,line2,city,state,pinCode,addressType,isDefault } = req.body;
    const [[own]] = await pool.execute('SELECT 1 FROM CustomerAddresses WHERE AddressID=? AND CustomerID=?', [toInt(req.params.id), req.user.id]);
    if (!own) return fail(res, 'Address not found', 404);
    if (isDefault) await pool.execute('UPDATE CustomerAddresses SET IsDefault=0 WHERE CustomerID=?', [req.user.id]);
    await pool.execute(
      'UPDATE CustomerAddresses SET FullName=IFNULL(?,FullName),Phone=IFNULL(?,Phone),Line1=IFNULL(?,Line1),Line2=IFNULL(?,Line2),City=IFNULL(?,City),State=IFNULL(?,State),PinCode=IFNULL(?,PinCode),AddressType=IFNULL(?,AddressType),IsDefault=IFNULL(?,IsDefault) WHERE AddressID=?',
      [fullName||null,phone||null,line1||null,line2||null,city||null,state||null,pinCode||null,addressType||null,isDefault!=null?isDefault:null,toInt(req.params.id)]
    );
    ok(res, { message:'Address updated' });
  })
);

router.delete('/addresses/:id', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [[addr]] = await pool.execute('SELECT IsDefault FROM CustomerAddresses WHERE AddressID=? AND CustomerID=?', [toInt(req.params.id), req.user.id]);
    if (!addr) return fail(res, 'Address not found', 404);
    await pool.execute('DELETE FROM CustomerAddresses WHERE AddressID=?', [toInt(req.params.id)]);
    if (addr.IsDefault) await pool.execute('UPDATE CustomerAddresses SET IsDefault=1 WHERE CustomerID=? LIMIT 1', [req.user.id]);
    ok(res, { message:'Address deleted' });
  })
);

router.patch('/addresses/:id/default', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [[own]] = await pool.execute('SELECT 1 FROM CustomerAddresses WHERE AddressID=? AND CustomerID=?', [toInt(req.params.id), req.user.id]);
    if (!own) return fail(res, 'Address not found', 404);
    await pool.execute('UPDATE CustomerAddresses SET IsDefault=0 WHERE CustomerID=?', [req.user.id]);
    await pool.execute('UPDATE CustomerAddresses SET IsDefault=1 WHERE AddressID=?', [toInt(req.params.id)]);
    ok(res, { message:'Default address updated' });
  })
);

// ── Invoice ─────────────────────────────────────────────────

router.get('/orders/:id/invoice', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const isAdmin = ['admin','super_admin','manager'].includes(req.user.role);
    const customerCheck = isAdmin ? [] : [req.user.id];
    const whereClause = isAdmin ? 'o.OrderID=?' : 'o.OrderID=? AND o.CustomerID=?';
    const orderParams = isAdmin ? [toInt(req.params.id)] : [toInt(req.params.id), req.user.id];
    const [[order], [items], [pay], [ship]] = await Promise.all([
      pool.execute(`SELECT o.*,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,c.Email,c.PhoneNumber FROM Orders o INNER JOIN Customers c ON c.CustomerID=o.CustomerID WHERE ${whereClause}`, orderParams),
      pool.execute(`SELECT oi.ProductID,oi.Quantity,oi.UnitPrice,oi.MRP,p.Name AS ProductName,p.SKU,p.Brand,oi.Quantity*oi.UnitPrice AS LineTotal,CASE WHEN cat.CategoryName IN ('Books') THEN 0 WHEN cat.CategoryName IN ('Food & Grocery') THEN 0.05 ELSE 0.18 END AS GSTRate FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID LEFT JOIN Categories cat ON cat.CategoryID=p.CategoryID WHERE oi.OrderID=?`, [toInt(req.params.id)]),
      pool.execute('SELECT PaymentMethod,PaymentStatus,TransactionReference,PaymentDate FROM Payments WHERE OrderID=?', [toInt(req.params.id)]),
      pool.execute('SELECT Carrier,TrackingNumber,ShippingStatus FROM Shipping WHERE OrderID=?', [toInt(req.params.id)]),
    ]);
    if (!order) return fail(res, 'Order not found', 404);
    const addr = (() => { try { return JSON.parse(order.ShippingAddress); } catch { return { raw:order.ShippingAddress }; } })();
    const invoice = {
      invoiceNumber: `INV-${order.OrderID}-${new Date(order.OrderDate).getFullYear()}`,
      invoiceDate: order.OrderDate, orderID: order.OrderID,
      seller: { name:'Deemona Commerce Pvt. Ltd.', address:'Registered Office, Mumbai, Maharashtra 400001', gstin:'27ABCDE1234F1Z5', email:'billing@deemona.com' },
      buyer: { name:order.CustomerName, email:order.Email, phone:order.PhoneNumber, address:addr },
      items: items.map(i => ({ ...i, cgstAmount:Math.round(i.LineTotal*i.GSTRate/2*100)/100, sgstAmount:Math.round(i.LineTotal*i.GSTRate/2*100)/100, totalWithGST:Math.round(i.LineTotal*(1+i.GSTRate)*100)/100 })),
      totals: { subTotal:order.SubTotal, taxAmount:order.TaxAmount, shippingAmount:order.ShippingAmount, discountAmount:order.DiscountAmount, totalAmount:order.TotalAmount },
      payment:pay[0]||null, shipping:ship[0]||null,
    };
    ok(res, invoice);
  })
);

// ── Order Items ─────────────────────────────────────────────

router.get('/orders/:id/items', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const isAdmin = ['admin','super_admin','manager'].includes(req.user.role);
    const where = isAdmin ? 'oi.OrderID=?' : 'oi.OrderID=? AND o.CustomerID=?';
    const params = isAdmin ? [toInt(req.params.id)] : [toInt(req.params.id), req.user.id];
    const [rows] = await pool.execute(
      `SELECT oi.*,p.Name AS ProductName,p.Brand,p.SKU,p.ImageURLs,
              CASE WHEN p.MRP>0 THEN ROUND((p.MRP-oi.UnitPrice)*100.0/p.MRP,0) ELSE 0 END AS DiscountPct
       FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID INNER JOIN Orders o ON o.OrderID=oi.OrderID
       WHERE ${where}`, params
    );
    ok(res, rows);
  })
);

router.patch('/admin/order-items/:itemId/fulfillment', authenticate, adminOnly,
  [param('itemId').isInt(), body('fulfillmentStatus').isIn(['pending','processing','picked','packed','shipped','delivered','returned','cancelled'])], validate,
  wrap(async (req,res) => {
    const { fulfillmentStatus, note } = req.body;
    const [[current]] = await pool.execute('SELECT OrderItemID,FulfillmentStatus,OrderID FROM OrderItems WHERE OrderItemID=?', [toInt(req.params.itemId)]);
    if (!current) return fail(res, 'Order item not found', 404);
    await pool.execute('UPDATE OrderItems SET FulfillmentStatus=? WHERE OrderItemID=?', [fulfillmentStatus, toInt(req.params.itemId)]);
    if (note) await pool.execute("INSERT INTO OrderStatusHistory(OrderID,FromStatus,ToStatus,ChangedBy,Note,ChangedAt) VALUES(?,?,?,?,?,NOW())", [current.OrderID,current.FulfillmentStatus,fulfillmentStatus,String(req.user.id),`Item ${toInt(req.params.itemId)}: ${note}`]);
    ok(res, { message:`Item fulfillment updated to '${fulfillmentStatus}'` });
  })
);

// ── Reports ─────────────────────────────────────────────────

router.get('/admin/reports/sales', authenticate, adminOnly,
  [query('from').optional().isISO8601(), query('to').optional().isISO8601(), query('groupBy').optional().isIn(['day','week','month'])], validate,
  wrap(async (req,res) => {
    const { groupBy='day' } = req.query;
    const s = new Date(req.query.from || Date.now()-30*86400000);
    const e = new Date(req.query.to   || Date.now());
    const dateFmt = { day:"DATE(OrderDate)", week:"YEARWEEK(OrderDate)", month:"DATE_FORMAT(OrderDate,'%Y-%m')" }[groupBy];
    const [revenue,topProducts,topCategories,paymentBreakdown,returns] = await Promise.all([
      pool.execute(`SELECT ${dateFmt} AS Period,COUNT(*) AS Orders,IFNULL(SUM(CASE WHEN Status NOT IN('cancelled','refunded') THEN TotalAmount ELSE 0 END),0) AS Revenue,IFNULL(AVG(CASE WHEN Status NOT IN('cancelled','refunded') THEN TotalAmount END),0) AS AOV,SUM(Status='cancelled') AS Cancelled,COUNT(DISTINCT CustomerID) AS UniqueCustomers FROM Orders WHERE OrderDate BETWEEN ? AND ? GROUP BY Period ORDER BY Period`, [s,e]),
      pool.execute(`SELECT p.ProductID,p.Name,p.SKU,SUM(oi.Quantity) AS UnitsSold,SUM(oi.Quantity*oi.UnitPrice) AS Revenue FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID INNER JOIN Orders o ON o.OrderID=oi.OrderID WHERE o.Status NOT IN('cancelled','refunded') AND o.OrderDate BETWEEN ? AND ? GROUP BY p.ProductID ORDER BY Revenue DESC LIMIT 10`, [s,e]),
      pool.execute(`SELECT c.CategoryName,SUM(oi.Quantity*oi.UnitPrice) AS Revenue,SUM(oi.Quantity) AS UnitsSold FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID INNER JOIN Categories c ON c.CategoryID=p.CategoryID INNER JOIN Orders o ON o.OrderID=oi.OrderID WHERE o.Status NOT IN('cancelled','refunded') AND o.OrderDate BETWEEN ? AND ? GROUP BY c.CategoryID ORDER BY Revenue DESC`, [s,e]),
      pool.execute(`SELECT p.PaymentMethod,COUNT(*) AS Transactions,SUM(p.Amount) AS TotalAmount FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID WHERE p.PaymentStatus='completed' AND o.OrderDate BETWEEN ? AND ? GROUP BY p.PaymentMethod ORDER BY TotalAmount DESC`, [s,e]),
      pool.execute(`SELECT COUNT(*) AS TotalOrders,SUM(Status='returned') AS Returns,SUM(Status='cancelled') AS Cancellations,ROUND(SUM(Status='returned')*100.0/NULLIF(COUNT(*),0),2) AS ReturnRate FROM Orders WHERE OrderDate BETWEEN ? AND ?`, [s,e]),
    ]);
    ok(res, { period:{from:s,to:e,groupBy}, revenueByPeriod:revenue[0], topProducts:topProducts[0], topCategories:topCategories[0], paymentBreakdown:paymentBreakdown[0], returnsAndCancellations:returns[0][0] });
  })
);

router.get('/admin/reports/inventory', authenticate, adminOnly, wrap(async (req,res) => {
  const [summary,slowMoving,fastMoving,outOfStock] = await Promise.all([
    pool.execute(`SELECT COUNT(*) AS TotalSKUs,SUM(StockQuantity) AS TotalUnits,IFNULL(SUM(StockQuantity*IFNULL(CostPrice,Price)),0) AS StockValue,SUM(StockQuantity=0) AS OutOfStock,SUM(StockQuantity<=ReorderLevel AND StockQuantity>0) AS LowStock FROM Products WHERE IsActive=1`),
    pool.execute(`SELECT p.ProductID,p.Name,p.SKU,p.StockQuantity,IFNULL(SUM(oi.Quantity),0) AS UnitsSold30Days FROM Products p LEFT JOIN OrderItems oi ON oi.ProductID=p.ProductID LEFT JOIN Orders o ON o.OrderID=oi.OrderID AND o.OrderDate>=DATE_SUB(NOW(),INTERVAL 30 DAY) AND o.Status NOT IN('cancelled') WHERE p.IsActive=1 AND p.StockQuantity>0 GROUP BY p.ProductID ORDER BY UnitsSold30Days ASC,p.StockQuantity DESC LIMIT 10`),
    pool.execute(`SELECT p.ProductID,p.Name,p.SKU,p.StockQuantity,SUM(oi.Quantity) AS UnitsSold30Days FROM Products p INNER JOIN OrderItems oi ON oi.ProductID=p.ProductID INNER JOIN Orders o ON o.OrderID=oi.OrderID AND o.OrderDate>=DATE_SUB(NOW(),INTERVAL 30 DAY) AND o.Status NOT IN('cancelled') WHERE p.IsActive=1 GROUP BY p.ProductID ORDER BY UnitsSold30Days DESC LIMIT 10`),
    pool.execute(`SELECT p.ProductID,p.Name,p.SKU,p.ReorderLevel,s.CompanyName AS SupplierName FROM Products p LEFT JOIN Suppliers s ON s.SupplierID=p.SupplierID WHERE p.StockQuantity=0 AND p.IsActive=1 ORDER BY p.Name`),
  ]);
  ok(res, { summary:summary[0][0], slowMoving:slowMoving[0], fastMoving:fastMoving[0], outOfStock:outOfStock[0] });
}));

router.get('/admin/reports/customers', authenticate, adminOnly, wrap(async (req,res) => {
  const [summary,tiers,topCustomers,churn] = await Promise.all([
    pool.execute(`SELECT COUNT(*) AS Total,SUM(AccountStatus='active') AS Active,SUM(AccountStatus='suspended') AS Suspended,SUM(RegistrationDate>=DATE_SUB(NOW(),INTERVAL 30 DAY)) AS NewLast30Days,AVG(LoyaltyPoints) AS AvgLoyaltyPoints FROM Customers`),
    pool.execute("SELECT LoyaltyTier,COUNT(*) AS CustomerCount,AVG(LoyaltyPoints) AS AvgPoints FROM Customers WHERE AccountStatus='active' GROUP BY LoyaltyTier ORDER BY CustomerCount DESC"),
    pool.execute(`SELECT c.CustomerID,CONCAT(c.FirstName,' ',c.LastName) AS Name,c.Email,c.LoyaltyTier,c.LoyaltyPoints,COUNT(DISTINCT o.OrderID) AS Orders,IFNULL(SUM(o.TotalAmount),0) AS LifetimeValue FROM Customers c LEFT JOIN Orders o ON o.CustomerID=c.CustomerID AND o.Status NOT IN('cancelled','refunded') GROUP BY c.CustomerID ORDER BY LifetimeValue DESC LIMIT 10`),
    pool.execute(`SELECT COUNT(*) AS ChurnedCustomers FROM Customers c WHERE c.AccountStatus='active' AND NOT EXISTS (SELECT 1 FROM Orders o WHERE o.CustomerID=c.CustomerID AND o.OrderDate>=DATE_SUB(NOW(),INTERVAL 90 DAY)) AND EXISTS (SELECT 1 FROM Orders o2 WHERE o2.CustomerID=c.CustomerID)`),
  ]);
  ok(res, { summary:summary[0][0], tierBreakdown:tiers[0], topCustomers:topCustomers[0], churn:churn[0][0] });
}));

// ── Bulk product import ────────────────────────────────────

router.post('/admin/products/bulk', authenticate, adminOnly,
  [body('products').isArray({min:1,max:100})], validate,
  wrap(async (req,res) => {
    const { products } = req.body;
    const results = { created:[], skipped:[], errors:[] };
    for (const p of products) {
      try {
        if (!p.name||!p.sku||!p.price) { results.skipped.push({ sku:p.sku||'unknown', reason:'Missing name, sku, or price' }); continue; }
        const [[ex]] = await pool.execute('SELECT 1 FROM Products WHERE SKU=?', [p.sku]);
        if (ex) { results.skipped.push({ sku:p.sku, reason:'SKU already exists' }); continue; }
        const [result] = await pool.execute(
          'INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,Price,MRP,StockQuantity,ReorderLevel,Tags,IsFeatured) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
          [p.name,p.description||null,p.sku,p.brand||null,p.categoryID||null,parseFloat(p.price),parseFloat(p.mrp||p.price),parseInt(p.stockQuantity||0),parseInt(p.reorderLevel||10),p.tags||null,p.isFeatured?1:0]
        );
        results.created.push({ sku:p.sku, productID:result.insertId });
      } catch(e) { results.errors.push({ sku:p.sku||'unknown', error:e.message }); }
    }
    ok(res, { summary:{ total:products.length, created:results.created.length, skipped:results.skipped.length, errors:results.errors.length }, ...results }, 207);
  })
);

// ── Admin customers alias ──────────────────────────────────

router.get('/admin/customers', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { search, status, tier } = req.query;
  const where=['1=1']; const params=[];
  if (search) { where.push('(c.FirstName LIKE ? OR c.LastName LIKE ? OR c.Email LIKE ?)'); const q=`%${search}%`; params.push(q,q,q); }
  if (status) { where.push('c.AccountStatus=?'); params.push(status); }
  if (tier)   { where.push('c.LoyaltyTier=?');   params.push(tier); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Customers c WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT c.CustomerID,CONCAT(c.FirstName,' ',c.LastName) AS Name,c.Email,c.PhoneNumber,c.City,c.LoyaltyPoints,c.LoyaltyTier,c.AccountStatus,c.RegistrationDate,c.LastLogin,COUNT(DISTINCT o.OrderID) AS OrderCount,IFNULL(SUM(o.TotalAmount),0) AS LifetimeValue
     FROM Customers c LEFT JOIN Orders o ON o.CustomerID=c.CustomerID AND o.Status NOT IN('cancelled','refunded')
     WHERE ${where.join(' AND ')} GROUP BY c.CustomerID ORDER BY LifetimeValue DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
     
    params
  );
  ok(res, { customers:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

module.exports = router;
