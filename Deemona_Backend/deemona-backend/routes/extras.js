// routes/extras.js  — Reviews + Wishlist + Discounts + Affiliates + Suppliers + Search + Admin (MySQL)
'use strict';
const router = require('express').Router();
const { body, param } = require('express-validator');
const pool   = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, toInt } = require('../middleware');

// ══ REVIEWS ════════════════════════════════════════════════

router.get('/products/:id/reviews', [param('id').isInt()], validate, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { sort='helpful', minRating } = req.query;
  const where = ["r.ProductID=? AND r.ModerationStatus='approved'"]; const params=[toInt(req.params.id)];
  if (minRating) { where.push('r.Rating>=?'); params.push(parseInt(minRating)); }
  const sortMap = { helpful:'r.HelpfulVotes DESC', newest:'r.ReviewDate DESC', highest:'r.Rating DESC', lowest:'r.Rating ASC' };
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Reviews r WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT r.ReviewID,r.Rating,r.Title,r.Comment,r.ReviewDate,r.VerifiedPurchase,r.HelpfulVotes,r.Reply,r.ReplyDate,
            CONCAT(c.FirstName,' ',LEFT(c.LastName,1),'.') AS ReviewerName,
            IF(r.HelpfulVotes>=10,1,0) AS IsTopReview
     FROM Reviews r INNER JOIN Customers c ON c.CustomerID=r.CustomerID
     WHERE ${where.join(' AND ')} ORDER BY ${sortMap[sort]||'r.HelpfulVotes DESC'} LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  const [dist] = await pool.execute("SELECT Rating,COUNT(*) AS Count FROM Reviews WHERE ProductID=? AND ModerationStatus='approved' GROUP BY Rating", [toInt(req.params.id)]);
  const distribution={5:0,4:0,3:0,2:0,1:0}; dist.forEach(d=>{distribution[d.Rating]=d.Count;});
  ok(res, { reviews:rows, distribution, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

router.post('/products/:id/reviews', authenticate,
  [param('id').isInt(), body('rating').isInt({min:1,max:5}), body('comment').optional().isLength({max:2000}), body('title').optional().isLength({max:200})], validate,
  wrap(async (req,res) => {
    const { rating, title, comment } = req.body;
    const spamWords = ['http','www.','free money','click here','buy now'];
    const text = ((comment||'')+(title||'')).toLowerCase();
    if (spamWords.some(k=>text.includes(k))) return fail(res, 'Review contains disallowed content', 400);
    const [[ex]] = await pool.execute('SELECT 1 FROM Reviews WHERE ProductID=? AND CustomerID=?', [toInt(req.params.id), req.user.id]);
    if (ex) return fail(res, 'You already reviewed this product', 409);
    const [[vp]] = await pool.execute("SELECT 1 FROM OrderItems oi INNER JOIN Orders o ON o.OrderID=oi.OrderID WHERE o.CustomerID=? AND oi.ProductID=? AND o.Status='delivered'", [req.user.id, toInt(req.params.id)]);
    const isVerified = !!vp;
    let moderationStatus = isVerified && rating>=4 ? 'approved' : (!isVerified && rating===1 ? 'flagged' : 'pending');
    const [result] = await pool.execute(
      'INSERT INTO Reviews(ProductID,CustomerID,Rating,Title,Comment,VerifiedPurchase,ModerationStatus) VALUES(?,?,?,?,?,?,?)',
      [toInt(req.params.id),req.user.id,rating,title||null,comment||null,isVerified?1:0,moderationStatus]
    );
    // Update product average
    await pool.execute("UPDATE Products SET AverageRating=(SELECT AVG(Rating*1.0) FROM Reviews WHERE ProductID=? AND ModerationStatus='approved'),ReviewsCount=(SELECT COUNT(*) FROM Reviews WHERE ProductID=? AND ModerationStatus='approved'),UpdatedAt=NOW() WHERE ProductID=?", [toInt(req.params.id),toInt(req.params.id),toInt(req.params.id)]);
    // Award review points
    if (moderationStatus==='approved') await pool.execute('UPDATE Customers SET LoyaltyPoints=LoyaltyPoints+50 WHERE CustomerID=?', [req.user.id]);
    ok(res, { reviewID:result.insertId, moderationStatus, pointsAwarded:moderationStatus==='approved'?50:0, message:'Review submitted' }, 201);
  })
);

router.patch('/reviews/:id/helpful', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [[ex]] = await pool.execute('SELECT 1 FROM ReviewHelpfulVotes WHERE ReviewID=? AND CustomerID=?', [toInt(req.params.id), req.user.id]);
    if (ex) return fail(res, 'Already voted', 409);
    await pool.execute('INSERT INTO ReviewHelpfulVotes(ReviewID,CustomerID) VALUES(?,?)', [toInt(req.params.id),req.user.id]);
    await pool.execute('UPDATE Reviews SET HelpfulVotes=HelpfulVotes+1 WHERE ReviewID=?', [toInt(req.params.id)]);
    ok(res, { message:'Marked as helpful' });
  })
);

router.patch('/admin/reviews/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { moderationStatus, reply } = req.body;
    await pool.execute('UPDATE Reviews SET ModerationStatus=IFNULL(?,ModerationStatus),Reply=IFNULL(?,Reply),ReplyDate=IF(? IS NOT NULL,NOW(),ReplyDate),UpdatedAt=NOW() WHERE ReviewID=?',
      [moderationStatus||null, reply||null, reply||null, toInt(req.params.id)]);
    if (moderationStatus==='approved') {
      const [[r]] = await pool.execute('SELECT ProductID FROM Reviews WHERE ReviewID=?', [toInt(req.params.id)]);
      if (r) await pool.execute("UPDATE Products SET AverageRating=(SELECT AVG(Rating*1.0) FROM Reviews WHERE ProductID=? AND ModerationStatus='approved'),ReviewsCount=(SELECT COUNT(*) FROM Reviews WHERE ProductID=? AND ModerationStatus='approved') WHERE ProductID=?", [r.ProductID,r.ProductID,r.ProductID]);
    }
    ok(res, { message:'Review updated' });
  })
);

router.delete('/admin/reviews/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM Reviews WHERE ReviewID=?', [toInt(req.params.id)]);
    ok(res, { message:'Review deleted' });
  })
);

router.get('/admin/reviews', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status } = req.query;
  const where=['1=1']; const params=[];
  if (status) { where.push('r.ModerationStatus=?'); params.push(status); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Reviews r WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT r.*,p.Name AS ProductName,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName
     FROM Reviews r INNER JOIN Products p ON p.ProductID=r.ProductID INNER JOIN Customers c ON c.CustomerID=r.CustomerID
     WHERE ${where.join(' AND ')} ORDER BY r.ReviewDate DESC LIMIT ? OFFSET ?`, [...params,limit,offset]
  );
  ok(res, { reviews:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

// ══ WISHLIST ════════════════════════════════════════════════

router.get('/wishlist', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT w.WishlistID,p.ProductID,p.Name,p.Price,p.MRP,p.Brand,p.AverageRating,p.StockQuantity,p.ImageURLs,c.CategoryName
     FROM Wishlist w INNER JOIN Products p ON p.ProductID=w.ProductID LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE w.CustomerID=? AND p.IsActive=1 ORDER BY w.AddedAt DESC`, [req.user.id]
  );
  ok(res, rows);
}));

router.post('/wishlist/:productId', authenticate, [param('productId').isInt()], validate,
  wrap(async (req,res) => {
    const [[ex]] = await pool.execute('SELECT 1 FROM Wishlist WHERE CustomerID=? AND ProductID=?', [req.user.id, toInt(req.params.productId)]);
    if (ex) return fail(res, 'Already in wishlist', 409);
    const [[p]] = await pool.execute('SELECT 1 FROM Products WHERE ProductID=? AND IsActive=1', [toInt(req.params.productId)]);
    if (!p) return fail(res, 'Product not found', 404);
    await pool.execute('INSERT INTO Wishlist(CustomerID,ProductID) VALUES(?,?)', [req.user.id, toInt(req.params.productId)]);
    ok(res, { message:'Added to wishlist' }, 201);
  })
);

router.delete('/wishlist/:productId', authenticate, [param('productId').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM Wishlist WHERE CustomerID=? AND ProductID=?', [req.user.id, toInt(req.params.productId)]);
    ok(res, { message:'Removed from wishlist' });
  })
);

router.delete('/wishlist', authenticate, wrap(async (req,res) => {
  await pool.execute('DELETE FROM Wishlist WHERE CustomerID=?', [req.user.id]);
  ok(res, { message:'Wishlist cleared' });
}));

router.post('/wishlist/:productId/move-to-cart', authenticate, [param('productId').isInt()], validate,
  wrap(async (req,res) => {
    const pid = toInt(req.params.productId);
    const [[p]] = await pool.execute('SELECT Price,StockQuantity FROM Products WHERE ProductID=? AND IsActive=1', [pid]);
    if (!p) return fail(res, 'Product not found', 404);
    if (p.StockQuantity < 1) return fail(res, 'Product out of stock', 400);
    let [cart] = await pool.execute('SELECT CartID FROM Carts WHERE CustomerID=?', [req.user.id]);
    if (!cart.length) { const [r] = await pool.execute('INSERT INTO Carts(CustomerID) VALUES(?)', [req.user.id]); cart=[{CartID:r.insertId}]; }
    const cartID = cart[0].CartID;
    const [[existing]] = await pool.execute('SELECT CartItemID,Quantity FROM CartItems WHERE CartID=? AND ProductID=?', [cartID, pid]);
    if (existing) await pool.execute('UPDATE CartItems SET Quantity=Quantity+1,UpdatedAt=NOW() WHERE CartItemID=?', [existing.CartItemID]);
    else await pool.execute('INSERT INTO CartItems(CartID,ProductID,Quantity,Price) VALUES(?,?,1,?)', [cartID, pid, p.Price]);
    await pool.execute('DELETE FROM Wishlist WHERE CustomerID=? AND ProductID=?', [req.user.id, pid]);
    ok(res, { message:'Moved to cart' });
  })
);

// ══ DISCOUNTS ══════════════════════════════════════════════

router.get('/discounts/active', wrap(async (req,res) => {
  const [rows] = await pool.execute("SELECT DiscountID,Code,Description,DiscountType,DiscountPercentage,DiscountAmount,MinOrderValue,MaxDiscountAmount,StartDate,EndDate FROM Discounts WHERE ActiveStatus=1 AND NOW() BETWEEN StartDate AND EndDate AND ShowPublicly=1 ORDER BY DiscountPercentage DESC");
  ok(res, rows);
}));

router.post('/discounts/validate', authenticate,
  [body('code').notEmpty().trim(), body('orderAmount').isFloat({min:0})], validate,
  wrap(async (req,res) => {
    const { code, orderAmount } = req.body;
    const [[d]] = await pool.execute("SELECT * FROM Discounts WHERE Code=? AND ActiveStatus=1 AND NOW() BETWEEN StartDate AND EndDate AND (UsageLimit IS NULL OR UsageCount<UsageLimit)", [code.toUpperCase()]);
    if (!d) return fail(res, 'Invalid or expired coupon code', 400);
    if (orderAmount < d.MinOrderValue) return fail(res, `Minimum order ₹${d.MinOrderValue} required`, 400);
    const savings = d.DiscountType==='percentage'
      ? Math.min(Math.round(orderAmount*d.DiscountPercentage/100), d.MaxDiscountAmount||Infinity)
      : (d.DiscountAmount||0);
    ok(res, { discountID:d.DiscountID, code:d.Code, description:d.Description, savings:Math.min(savings,orderAmount*0.5), discountAmount:Math.min(savings,orderAmount*0.5) });
  })
);

router.get('/admin/discounts', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const [[countRow]] = await pool.execute('SELECT COUNT(*) AS total FROM Discounts');
  const [rows] = await pool.execute('SELECT * FROM Discounts ORDER BY CreatedAt DESC LIMIT ? OFFSET ?', [limit,offset]);
  ok(res, { discounts:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

router.get('/discounts/:id', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [[d]] = await pool.execute('SELECT * FROM Discounts WHERE DiscountID=?', [toInt(req.params.id)]);
    if (!d) return fail(res, 'Discount not found', 404);
    ok(res, d);
  })
);

router.post('/admin/discounts', authenticate, adminOnly,
  [body('code').notEmpty().trim().toUpperCase(), body('discountType').isIn(['percentage','fixed']),
   body('startDate').isISO8601(), body('endDate').isISO8601()], validate,
  wrap(async (req,res) => {
    const { code,description,discountType,discountPercentage,discountAmount,minOrderValue,maxDiscountAmount,usageLimit,startDate,endDate,activeStatus,showPublicly } = req.body;
    const [[ex]] = await pool.execute('SELECT 1 FROM Discounts WHERE Code=?', [code.toUpperCase()]);
    if (ex) return fail(res, 'Coupon code already exists', 409);
    const [result] = await pool.execute(
      'INSERT INTO Discounts(Code,Description,DiscountType,DiscountPercentage,DiscountAmount,MinOrderValue,MaxDiscountAmount,UsageLimit,StartDate,EndDate,ActiveStatus,ShowPublicly) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
      [code.toUpperCase(),description||null,discountType,discountPercentage||null,discountAmount||null,minOrderValue||0,maxDiscountAmount||null,usageLimit||null,startDate,endDate,activeStatus!==false?1:0,showPublicly?1:0]
    );
    ok(res, { discountID:result.insertId, message:'Discount created' }, 201);
  })
);

router.put('/admin/discounts/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { description,discountPercentage,discountAmount,minOrderValue,maxDiscountAmount,usageLimit,startDate,endDate,activeStatus,showPublicly } = req.body;
    await pool.execute(
      'UPDATE Discounts SET Description=IFNULL(?,Description),DiscountPercentage=IFNULL(?,DiscountPercentage),DiscountAmount=IFNULL(?,DiscountAmount),MinOrderValue=IFNULL(?,MinOrderValue),MaxDiscountAmount=IFNULL(?,MaxDiscountAmount),UsageLimit=IFNULL(?,UsageLimit),StartDate=IFNULL(?,StartDate),EndDate=IFNULL(?,EndDate),ActiveStatus=IFNULL(?,ActiveStatus),ShowPublicly=IFNULL(?,ShowPublicly),UpdatedAt=NOW() WHERE DiscountID=?',
      [description||null,discountPercentage||null,discountAmount||null,minOrderValue||null,maxDiscountAmount||null,usageLimit||null,startDate||null,endDate||null,activeStatus!=null?activeStatus:null,showPublicly!=null?showPublicly:null,toInt(req.params.id)]
    );
    ok(res, { message:'Discount updated' });
  })
);

router.delete('/admin/discounts/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM Discounts WHERE DiscountID=?', [toInt(req.params.id)]);
    ok(res, { message:'Discount deleted' });
  })
);

// ══ AFFILIATES ═════════════════════════════════════════════

router.get('/affiliates', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const [[countRow]] = await pool.execute('SELECT COUNT(*) AS total FROM Affiliates');
  const [rows] = await pool.execute('SELECT a.*,COUNT(ac.ConversionID) AS Conversions,IFNULL(SUM(ac.CommissionEarned),0) AS TotalEarned FROM Affiliates a LEFT JOIN AffiliateConversions ac ON ac.AffiliateID=a.AffiliateID GROUP BY a.AffiliateID ORDER BY a.CreatedAt DESC LIMIT ? OFFSET ?', [limit,offset]);
  ok(res, { affiliates:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

router.get('/affiliates/:id', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [[a]] = await pool.execute('SELECT * FROM Affiliates WHERE AffiliateID=?', [toInt(req.params.id)]);
    if (!a) return fail(res, 'Affiliate not found', 404);
    ok(res, a);
  })
);

router.post('/affiliates/track', wrap(async (req,res) => {
  const { referralCode, orderID } = req.body;
  if (!referralCode) return fail(res, 'Referral code required', 400);
  const [[aff]] = await pool.execute("SELECT AffiliateID,CommissionRate FROM Affiliates WHERE ReferralCode=? AND Status='active'", [referralCode]);
  if (!aff) return fail(res, 'Invalid referral code', 404);
  const [[order]] = await pool.execute('SELECT TotalAmount FROM Orders WHERE OrderID=?', [parseInt(orderID)]);
  if (!order) return fail(res, 'Order not found', 404);
  const commission = Math.round(order.TotalAmount*(aff.CommissionRate/100)*100)/100;
  await pool.execute('INSERT INTO AffiliateConversions(AffiliateID,OrderID,CommissionEarned) VALUES(?,?,?) ON DUPLICATE KEY UPDATE CommissionEarned=VALUES(CommissionEarned)', [aff.AffiliateID, parseInt(orderID), commission]);
  await pool.execute('UPDATE Affiliates SET TotalEarnings=TotalEarnings+?,TotalClicks=TotalClicks+1 WHERE AffiliateID=?', [commission, aff.AffiliateID]);
  ok(res, { message:'Conversion tracked', commission });
}));

router.delete('/affiliates/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM Affiliates WHERE AffiliateID=?', [toInt(req.params.id)]);
    ok(res, { message:'Affiliate deleted' });
  })
);

// ══ SUPPLIERS ══════════════════════════════════════════════

router.get('/suppliers', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const [[countRow]] = await pool.execute('SELECT COUNT(*) AS total FROM Suppliers');
  const [rows] = await pool.execute('SELECT * FROM Suppliers ORDER BY CompanyName ASC LIMIT ? OFFSET ?', [limit,offset]);
  ok(res, { suppliers:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

router.delete('/suppliers/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM Suppliers WHERE SupplierID=?', [toInt(req.params.id)]);
    ok(res, { message:'Supplier deleted' });
  })
);

// ══ SEARCH ═════════════════════════════════════════════════

router.get('/search/autocomplete', wrap(async (req,res) => {
  const { q } = req.query;
  if (!q || q.length<2) return ok(res, []);
  const [rows] = await pool.execute(
    "SELECT ProductID,Name,Price,Brand,ImageURLs FROM Products WHERE IsActive=1 AND (Name LIKE ? OR Brand LIKE ? OR Tags LIKE ?) AND (ShowPublicly=1 OR ShowPublicly IS NULL) ORDER BY ViewsCount DESC LIMIT 8",
    [`%${q}%`,`%${q}%`,`%${q}%`]
  );
  ok(res, rows);
}));

router.get('/search', wrap(async (req,res) => {
  const { q, page, limit, offset } = { ...paginate(req.query), q:req.query.q };
  const { category, minPrice, maxPrice, sort='relevance' } = req.query;
  if (!q?.trim()) return fail(res, 'Search query required', 400);
  const searchTerm = `%${q.trim()}%`;
  const where = ['p.IsActive=1','(p.ShowPublicly=1 OR p.ShowPublicly IS NULL)','(p.Name LIKE ? OR p.Description LIKE ? OR p.Brand LIKE ? OR p.Tags LIKE ? OR c.CategoryName LIKE ?)'];
  const params = [searchTerm,searchTerm,searchTerm,searchTerm,searchTerm];
  if (category) { where.push('c.CategoryName=?'); params.push(category); }
  if (minPrice) { where.push('p.Price>=?'); params.push(parseFloat(minPrice)); }
  if (maxPrice) { where.push('p.Price<=?'); params.push(parseFloat(maxPrice)); }
  const sortMap = { price_asc:'p.Price ASC', price_desc:'p.Price DESC', rating:'p.AverageRating DESC', newest:'p.CreatedAt DESC', relevance:'p.IsFeatured DESC,p.ViewsCount DESC' };
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT p.ProductID,p.Name,p.Price,p.MRP,p.Brand,p.AverageRating,p.ReviewsCount,p.StockQuantity,p.IsFeatured,p.ImageURLs,c.CategoryName,
            CASE WHEN p.MRP>0 THEN ROUND((p.MRP-p.Price)*100.0/p.MRP,0) ELSE 0 END AS DiscountPct
     FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE ${where.join(' AND ')} ORDER BY ${sortMap[sort]||'p.IsFeatured DESC'} LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { query:q, products:rows, pagination:{total:countRow.total,page,limit,pages:Math.ceil(countRow.total/limit)} });
}));

// ══ ADMIN DASHBOARD + ANALYTICS ═══════════════════════════

router.get('/admin/dashboard', authenticate, adminOnly, wrap(async (req,res) => {
  const [summary,ordersByStatus,topProducts,revenueByCategory] = await Promise.all([
    pool.execute(`SELECT
      (SELECT COUNT(*) FROM Customers WHERE AccountStatus='active') AS TotalCustomers,
      (SELECT COUNT(*) FROM Orders) AS TotalOrders,
      (SELECT IFNULL(SUM(TotalAmount),0) FROM Orders WHERE Status NOT IN ('cancelled','refunded')) AS TotalRevenue,
      (SELECT COUNT(*) FROM Orders WHERE Status='pending') AS PendingOrders,
      (SELECT IFNULL(AVG(TotalAmount),0) FROM Orders WHERE Status NOT IN ('cancelled','refunded')) AS AvgOrderValue,
      (SELECT COUNT(*) FROM Products WHERE StockQuantity<=ReorderLevel AND IsActive=1) AS LowStockItems,
      (SELECT IFNULL(AVG(AverageRating),0) FROM Products WHERE IsActive=1 AND ReviewsCount>0) AS AvgRating`),
    pool.execute('SELECT Status,COUNT(*) AS Count FROM Orders GROUP BY Status'),
    pool.execute(`SELECT p.ProductID,p.Name,p.Price,c.CategoryName,SUM(oi.Quantity) AS TotalSold,SUM(oi.Quantity*oi.UnitPrice) AS Revenue
                  FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
                  INNER JOIN Orders o ON o.OrderID=oi.OrderID WHERE o.Status NOT IN ('cancelled','refunded')
                  GROUP BY p.ProductID ORDER BY Revenue DESC LIMIT 10`),
    pool.execute(`SELECT c.CategoryName,SUM(oi.Quantity*oi.UnitPrice) AS Revenue
                  FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID INNER JOIN Categories c ON c.CategoryID=p.CategoryID
                  INNER JOIN Orders o ON o.OrderID=oi.OrderID WHERE o.Status NOT IN ('cancelled','refunded')
                  GROUP BY c.CategoryID ORDER BY Revenue DESC`),
  ]);
  const statusMap = {};
  ordersByStatus[0].forEach(r => { statusMap[r.Status]=r.Count; });
  ok(res, { summary:summary[0][0], ordersByStatus:statusMap, topProducts:topProducts[0], revenueByCategory:revenueByCategory[0] });
}));

router.get('/admin/analytics/revenue', authenticate, adminOnly, wrap(async (req,res) => {
  const days = parseInt(req.query.days||30);
  const [daily,byMethod,refundRate] = await Promise.all([
    pool.execute(`SELECT DATE(OrderDate) AS Date,COUNT(*) AS Orders,IFNULL(SUM(TotalAmount),0) AS Revenue FROM Orders WHERE Status NOT IN ('cancelled','refunded') AND OrderDate>=DATE_SUB(NOW(),INTERVAL ? DAY) GROUP BY DATE(OrderDate) ORDER BY Date ASC`, [days]),
    pool.execute(`SELECT PaymentMethod,COUNT(*) AS Orders,IFNULL(SUM(TotalAmount),0) AS Revenue FROM Orders WHERE Status NOT IN ('cancelled','refunded') AND OrderDate>=DATE_SUB(NOW(),INTERVAL ? DAY) GROUP BY PaymentMethod ORDER BY Revenue DESC`, [days]),
    pool.execute(`SELECT ROUND(COUNT(CASE WHEN Status IN ('returned','refunded') THEN 1 END)*100.0/NULLIF(COUNT(*),0),2) AS RefundRate FROM Orders WHERE OrderDate>=DATE_SUB(NOW(),INTERVAL ? DAY)`, [days]),
  ]);
  ok(res, { daily:daily[0], byMethod:byMethod[0], refundRate:refundRate[0][0]?.RefundRate||0, period:days });
}));

router.get('/admin/analytics/customers', authenticate, adminOnly, wrap(async (req,res) => {
  const [acquisition,retention,tiers] = await Promise.all([
    pool.execute("SELECT DATE_FORMAT(RegistrationDate,'%Y-%m') AS Month,COUNT(*) AS NewCustomers FROM Customers GROUP BY DATE_FORMAT(RegistrationDate,'%Y-%m') ORDER BY Month DESC LIMIT 12"),
    pool.execute(`SELECT
      (SELECT COUNT(DISTINCT CustomerID) FROM Orders WHERE OrderDate>=DATE_SUB(NOW(),INTERVAL 30 DAY)) AS ActiveLast30Days,
      (SELECT COUNT(*) FROM Customers WHERE AccountStatus='active') AS TotalActive,
      (SELECT ROUND(AVG(order_count),2) FROM (SELECT CustomerID,COUNT(*) AS order_count FROM Orders GROUP BY CustomerID) t) AS AvgOrdersPerCustomer`),
    pool.execute('SELECT LoyaltyTier,COUNT(*) AS Count FROM Customers WHERE AccountStatus=\'active\' GROUP BY LoyaltyTier'),
  ]);
  ok(res, { acquisition:acquisition[0], retention:retention[0][0], tierDistribution:tiers[0] });
}));

module.exports = router;
