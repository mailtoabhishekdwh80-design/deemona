// routes/commerce.js  — Cart + Orders + Shipping (MySQL)
'use strict';
const router = require('express').Router();
const { body, param } = require('express-validator');
const pool   = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, toInt } = require('../middleware');

// ══ CART ════════════════════════════════════════════════════

router.get('/cart', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT ci.CartItemID,ci.ProductID,ci.Quantity,p.Name AS ProductName,p.Price,p.MRP,p.StockQuantity,
            p.Brand,p.ImageURLs,c.CartID
     FROM CartItems ci
     INNER JOIN Carts   c ON c.CartID=ci.CartID
     INNER JOIN Products p ON p.ProductID=ci.ProductID
     WHERE c.CustomerID=? AND p.IsActive=1 ORDER BY ci.AddedAt DESC`,
    [req.user.id]
  );
  const subtotal = rows.reduce((s,i) => s + i.Price*i.Quantity, 0);
  const shipping = subtotal >= 499 ? 0 : 49;
  ok(res, { items:rows, summary:{ subtotal:Math.round(subtotal*100)/100, shipping, total:Math.round((subtotal+shipping)*100)/100, count:rows.reduce((s,i)=>s+i.Quantity,0) } });
}));

router.post('/cart', authenticate,
  [body('productID').isInt(), body('quantity').isInt({min:1})], validate,
  wrap(async (req,res) => {
    const { productID, quantity } = req.body;
    const [prod] = await pool.execute('SELECT ProductID,StockQuantity,Price FROM Products WHERE ProductID=? AND IsActive=1', [productID]);
    if (!prod.length) return fail(res, 'Product not found or inactive', 404);
    if (prod[0].StockQuantity < quantity) return fail(res, `Only ${prod[0].StockQuantity} in stock`, 400);

    // Get or create cart
    let [cart] = await pool.execute('SELECT CartID FROM Carts WHERE CustomerID=?', [req.user.id]);
    if (!cart.length) {
      const [result] = await pool.execute('INSERT INTO Carts(CustomerID) VALUES(?)', [req.user.id]);
      cart = [{ CartID: result.insertId }];
    }
    const cartID = cart[0].CartID;

    // Check if item already in cart
    const [existing] = await pool.execute('SELECT CartItemID,Quantity FROM CartItems WHERE CartID=? AND ProductID=?', [cartID, productID]);
    if (existing.length) {
      const newQty = existing[0].Quantity + quantity;
      if (newQty > prod[0].StockQuantity) return fail(res, `Only ${prod[0].StockQuantity} in stock`, 400);
      await pool.execute('UPDATE CartItems SET Quantity=?,UpdatedAt=NOW() WHERE CartItemID=?', [newQty, existing[0].CartItemID]);
    } else {
      await pool.execute('INSERT INTO CartItems(CartID,ProductID,Quantity,Price) VALUES(?,?,?,?)', [cartID, productID, quantity, prod[0].Price]);
    }
    await pool.execute('UPDATE Carts SET UpdatedAt=NOW() WHERE CartID=?', [cartID]);
    ok(res, { message:'Item added to cart' });
  })
);

router.put('/cart/:itemId', authenticate, [param('itemId').isInt(), body('quantity').isInt({min:0})], validate,
  wrap(async (req,res) => {
    const { quantity } = req.body;
    const itemId = toInt(req.params.itemId);
    if (quantity === 0) {
      await pool.execute('DELETE FROM CartItems WHERE CartItemID=? AND CartID=(SELECT CartID FROM Carts WHERE CustomerID=?)', [itemId, req.user.id]);
      return ok(res, { message:'Item removed' });
    }
    const [ci] = await pool.execute(
      'SELECT ci.CartItemID,ci.ProductID FROM CartItems ci INNER JOIN Carts c ON c.CartID=ci.CartID WHERE ci.CartItemID=? AND c.CustomerID=?',
      [itemId, req.user.id]
    );
    if (!ci.length) return fail(res, 'Cart item not found', 404);
    const [prod] = await pool.execute('SELECT StockQuantity FROM Products WHERE ProductID=?', [ci[0].ProductID]);
    if (quantity > prod[0].StockQuantity) return fail(res, 'Exceeds available stock', 400);
    await pool.execute('UPDATE CartItems SET Quantity=?,UpdatedAt=NOW() WHERE CartItemID=?', [quantity, itemId]);
    ok(res, { message:'Quantity updated' });
  })
);

router.delete('/cart/:itemId', authenticate, [param('itemId').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('DELETE FROM CartItems WHERE CartItemID=? AND CartID=(SELECT CartID FROM Carts WHERE CustomerID=?)', [toInt(req.params.itemId), req.user.id]);
    ok(res, { message:'Item removed' });
  })
);

router.delete('/cart', authenticate, wrap(async (req,res) => {
  await pool.execute('DELETE ci FROM CartItems ci INNER JOIN Carts c ON c.CartID=ci.CartID WHERE c.CustomerID=?', [req.user.id]);
  ok(res, { message:'Cart cleared' });
}));

router.post('/cart/validate', authenticate, wrap(async (req,res) => {
  const [items] = await pool.execute(
    `SELECT ci.CartItemID,ci.ProductID,ci.Quantity,p.StockQuantity,p.IsActive,p.Name
     FROM CartItems ci INNER JOIN Carts c ON c.CartID=ci.CartID INNER JOIN Products p ON p.ProductID=ci.ProductID
     WHERE c.CustomerID=?`, [req.user.id]
  );
  const issues = items.filter(i => !i.IsActive || i.Quantity > i.StockQuantity)
    .map(i => ({ productID:i.ProductID, name:i.Name, issue: !i.IsActive ? 'Product no longer available' : `Only ${i.StockQuantity} left in stock` }));
  ok(res, { valid:issues.length===0, issues });
}));

// ══ ORDERS ══════════════════════════════════════════════════

router.get('/orders', authenticate, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status } = req.query;
  const where = ['o.CustomerID=?']; const params = [req.user.id];
  if (status) { where.push('o.Status=?'); params.push(status); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Orders o WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT o.*, COUNT(oi.OrderItemID) AS ItemCount,
            (SELECT p.ImageURLs FROM OrderItems oi2 JOIN Products p ON p.ProductID=oi2.ProductID WHERE oi2.OrderID=o.OrderID LIMIT 1) AS FirstImageURLs,
            (SELECT p.Name FROM OrderItems oi2 JOIN Products p ON p.ProductID=oi2.ProductID WHERE oi2.OrderID=o.OrderID LIMIT 1) AS FirstProductName
     FROM Orders o LEFT JOIN OrderItems oi ON oi.OrderID=o.OrderID
     WHERE ${where.join(' AND ')} GROUP BY o.OrderID ORDER BY o.OrderDate DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { orders:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

router.get('/orders/:id', authenticate, [param('id').isInt()], validate, wrap(async (req,res) => {
  const isAdmin = ['admin','super_admin','manager','support'].includes(req.user.role);
  const customerCheck = isAdmin ? '' : 'AND o.CustomerID=?';
  const checkParams   = isAdmin ? [toInt(req.params.id)] : [toInt(req.params.id), req.user.id];
  const [orderRows, items, shipping, payment, history] = await Promise.all([
    pool.execute(`SELECT o.*,CONCAT(cu.FirstName,' ',cu.LastName) AS CustomerName,cu.Email FROM Orders o INNER JOIN Customers cu ON cu.CustomerID=o.CustomerID WHERE o.OrderID=? ${customerCheck}`, checkParams),
    pool.execute(`SELECT oi.*,p.Name AS ProductName,p.Brand,p.ImageURLs,p.SKU,oi.Quantity*oi.UnitPrice AS LineTotal FROM OrderItems oi INNER JOIN Products p ON p.ProductID=oi.ProductID WHERE oi.OrderID=?`, [toInt(req.params.id)]),
    pool.execute('SELECT * FROM Shipping WHERE OrderID=?', [toInt(req.params.id)]),
    pool.execute('SELECT PaymentID,Amount,PaymentMethod,PaymentStatus,PaymentDate,TransactionReference,Currency FROM Payments WHERE OrderID=?', [toInt(req.params.id)]),
    pool.execute('SELECT * FROM OrderStatusHistory WHERE OrderID=? ORDER BY ChangedAt ASC', [toInt(req.params.id)]),
  ]);
  if (!orderRows[0].length) return fail(res, 'Order not found', 404);
  ok(res, { order:orderRows[0][0], items:items[0], shipping:shipping[0][0]||null, payment:payment[0][0]||null, history:history[0] });
}));

// POST /api/orders  — place order (MySQL transaction)
router.post('/orders', authenticate,
  [body('items').isArray({min:1}), body('items.*.productID').isInt(), body('items.*.quantity').isInt({min:1}),
   body('shippingAddress').notEmpty(), body('paymentMethod').isIn(['upi','credit_card','debit_card','net_banking','wallet','cod','emi','gift_card'])], validate,
  wrap(async (req,res) => {
    const { items, shippingAddress, billingAddress, paymentMethod, couponCode, pointsToRedeem=0, shippingOption='standard' } = req.body;

    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
      // 1. Validate & enrich items
      let subTotal = 0;
      const enriched = [];
      const GST_RATES = { 'Books':0, 'Food & Grocery':0.05 };

      for (const item of items) {
        const [[p]] = await conn.execute(
          `SELECT p.ProductID,p.Name,p.Price,p.MRP,p.StockQuantity,c.CategoryName
           FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
           WHERE p.ProductID=? AND p.IsActive=1 FOR UPDATE`,
          [item.productID]
        );
        if (!p) throw new Error(`Product ${item.productID} not found or inactive`);
        if (p.StockQuantity < item.quantity) throw new Error(`Insufficient stock for "${p.Name}" — only ${p.StockQuantity} available`);
        const gstRate = GST_RATES[p.CategoryName] ?? 0.18;
        enriched.push({ ...p, quantity:item.quantity, gstRate });
        subTotal += p.Price * item.quantity;
      }

      // 2. Coupon
      let discountAmt=0, discountID=null;
      if (couponCode) {
        const [[cp]] = await conn.execute(
          `SELECT * FROM Discounts WHERE Code=? AND ActiveStatus=1 AND NOW() BETWEEN StartDate AND EndDate
           AND (UsageLimit IS NULL OR UsageCount < UsageLimit)`,
          [couponCode.toUpperCase()]
        );
        if (!cp) throw new Error(`Coupon '${couponCode}' is invalid or expired`);
        if (subTotal < cp.MinOrderValue) throw new Error(`Coupon requires minimum order ₹${cp.MinOrderValue}`);
        discountID  = cp.DiscountID;
        discountAmt = cp.DiscountType==='percentage'
          ? Math.min(Math.round(subTotal*cp.DiscountPercentage/100), cp.MaxDiscountAmount||Infinity)
          : (cp.DiscountAmount||0);
        discountAmt = Math.min(discountAmt, subTotal*0.5);
      }

      // 3. Points redemption
      let pointsDiscount=0, pointsDeducted=0;
      if (pointsToRedeem>0) {
        const [[pts]] = await conn.execute('SELECT LoyaltyPoints FROM Customers WHERE CustomerID=?', [req.user.id]);
        const available  = pts?.LoyaltyPoints||0;
        const maxByOrder = Math.floor(subTotal*0.2/0.1);
        pointsDeducted   = Math.min(pointsToRedeem, available, maxByOrder);
        pointsDiscount   = Math.round(pointsDeducted*0.1*100)/100;
      }

      // 4. Shipping & tax
      const shippingCosts = { standard:subTotal>=499?0:49, express:99, same_day:199 };
      const shippingAmt   = shippingCosts[shippingOption]||49;
      const taxAmt        = Math.round(enriched.reduce((s,i) => s+(i.Price*i.quantity*i.gstRate),0)*100)/100;
      const total         = Math.max(0, subTotal+taxAmt+shippingAmt-discountAmt-pointsDiscount);

      // 5. Delivery date estimate
      const addr = typeof shippingAddress==='string' ? JSON.parse(shippingAddress) : shippingAddress;
      const METRO = ['mumbai','delhi','bangalore','bengaluru','hyderabad','chennai','kolkata','pune'];
      const isMetro  = METRO.some(m => (addr.city||'').toLowerCase().includes(m));
      const isRemote = String(addr.pinCode||'').startsWith('8')||String(addr.pinCode||'').startsWith('9');
      const delivDays = isRemote?7:isMetro?3:5;
      const delivDate = new Date(); delivDate.setDate(delivDate.getDate()+delivDays);
      if (delivDate.getDay()===0) delivDate.setDate(delivDate.getDate()+1);

      // 6. Insert order
      const [orderResult] = await conn.execute(
        `INSERT INTO Orders(CustomerID,SubTotal,TaxAmount,ShippingAmount,DiscountAmount,TotalAmount,
                            PaymentMethod,ShippingAddress,BillingAddress,CouponCode,DiscountID,DeliveryDateEstimate)
         VALUES(?,?,?,?,?,?,?,?,?,?,?,?)`,
        [req.user.id,subTotal,taxAmt,shippingAmt,discountAmt+pointsDiscount,total,paymentMethod,
         JSON.stringify(shippingAddress),JSON.stringify(billingAddress||shippingAddress),
         couponCode?.toUpperCase()||null,discountID,delivDate]
      );
      const orderID = orderResult.insertId;

      // 7. Insert line items + deduct stock
      for (const item of enriched) {
        await conn.execute('INSERT INTO OrderItems(OrderID,ProductID,Quantity,UnitPrice,MRP) VALUES(?,?,?,?,?)', [orderID,item.ProductID,item.quantity,item.Price,item.MRP]);
        await conn.execute('UPDATE Products SET StockQuantity=StockQuantity-?,UpdatedAt=NOW() WHERE ProductID=?', [item.quantity,item.ProductID]);
      }

      // 8. Shipping record
      await conn.execute("INSERT INTO Shipping(OrderID,ShippingStatus,EstimatedDeliveryDate) VALUES(?,'pending',?)", [orderID,delivDate]);

      // 9. Payment record
      await conn.execute("INSERT INTO Payments(OrderID,Amount,PaymentMethod,PaymentStatus) VALUES(?,?,?,'pending')", [orderID,total,paymentMethod]);

      // 10. Loyalty points
      const pointsEarned = Math.floor(total/100);
      await conn.execute('UPDATE Customers SET LoyaltyPoints=LoyaltyPoints+? WHERE CustomerID=?', [pointsEarned-pointsDeducted, req.user.id]);

      // 11. Coupon usage
      if (discountID) await conn.execute('UPDATE Discounts SET UsageCount=UsageCount+1 WHERE DiscountID=?', [discountID]);

      // 12. Clear cart
      await conn.execute('DELETE ci FROM CartItems ci INNER JOIN Carts c ON c.CartID=ci.CartID WHERE c.CustomerID=?', [req.user.id]);

      // 13. Status history
      await conn.execute("INSERT INTO OrderStatusHistory(OrderID,FromStatus,ToStatus,ChangedBy,Note,ChangedAt) VALUES(?,NULL,'pending','system','Order placed',NOW())", [orderID]);

      await conn.commit();
      ok(res, { orderID, totalAmount:total, subTotal, taxAmount:taxAmt, shippingAmount:shippingAmt, discountAmount:discountAmt, pointsDiscount, pointsEarned, estimatedDelivery:delivDate, message:'Order placed successfully!' }, 201);
    } catch(e) {
      await conn.rollback();
      throw e;
    } finally {
      conn.release();
    }
  })
);

// PATCH /api/orders/:id/cancel
router.patch('/orders/:id/cancel', authenticate, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { reason } = req.body;
    const orderId = toInt(req.params.id);
    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
      const [[order]] = await conn.execute("SELECT Status,TotalAmount FROM Orders WHERE OrderID=? AND CustomerID=? AND Status IN('pending','confirmed')", [orderId, req.user.id]);
      if (!order) { await conn.rollback(); conn.release(); return fail(res, 'Order cannot be cancelled', 400); }

      await conn.execute("UPDATE Orders SET Status='cancelled',Notes=CONCAT(IFNULL(Notes,''),' | Cancelled: ',?),UpdatedAt=NOW() WHERE OrderID=?", [reason||'Customer request', orderId]);
      await conn.execute("UPDATE OrderItems SET FulfillmentStatus='cancelled' WHERE OrderID=?", [orderId]);

      const [items] = await conn.execute('SELECT ProductID,Quantity FROM OrderItems WHERE OrderID=?', [orderId]);
      for (const item of items)
        await conn.execute('UPDATE Products SET StockQuantity=StockQuantity+? WHERE ProductID=?', [item.Quantity, item.ProductID]);

      await conn.execute("INSERT INTO OrderStatusHistory(OrderID,FromStatus,ToStatus,ChangedBy,Note,ChangedAt) VALUES(?,?,?,'customer',?,NOW())", [orderId, order.Status, 'cancelled', reason||'Customer request']);
      await conn.commit();
      ok(res, { message:'Order cancelled and stock restored' });
    } catch(e) { await conn.rollback(); throw e; } finally { conn.release(); }
  })
);

// GET /api/admin/orders
router.get('/admin/orders', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status, customerID, from, to, paymentMethod } = req.query;
  const where = ['1=1']; const params = [];
  if (status)        { where.push('o.Status=?');        params.push(status); }
  if (customerID)    { where.push('o.CustomerID=?');    params.push(parseInt(customerID)); }
  if (from)          { where.push('o.OrderDate>=?');    params.push(from); }
  if (to)            { where.push('o.OrderDate<=?');    params.push(to); }
  if (paymentMethod) { where.push('o.PaymentMethod=?'); params.push(paymentMethod); }

  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Orders o WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT o.*,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,c.Email,COUNT(oi.OrderItemID) AS ItemCount
     FROM Orders o INNER JOIN Customers c ON c.CustomerID=o.CustomerID LEFT JOIN OrderItems oi ON oi.OrderID=o.OrderID
     WHERE ${where.join(' AND ')} GROUP BY o.OrderID ORDER BY o.OrderDate DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { orders:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

// PATCH /api/admin/orders/:id/status
router.patch('/admin/orders/:id/status', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { status, note, trackingNumber, carrier } = req.body;
    const orderId = toInt(req.params.id);
    const [[order]] = await pool.execute('SELECT Status FROM Orders WHERE OrderID=?', [orderId]);
    if (!order) return fail(res, 'Order not found', 404);
    await pool.execute('UPDATE Orders SET Status=?,UpdatedAt=NOW() WHERE OrderID=?', [status, orderId]);
    await pool.execute("INSERT INTO OrderStatusHistory(OrderID,FromStatus,ToStatus,ChangedBy,Note,ChangedAt) VALUES(?,?,?,?,?,NOW())", [orderId, order.Status, status, String(req.user.id), note||null]);
    if (trackingNumber) await pool.execute('UPDATE Shipping SET TrackingNumber=?,Carrier=IFNULL(?,Carrier),ShippingStatus=? WHERE OrderID=?', [trackingNumber, carrier||null, status==='shipped'?'shipped':'processing', orderId]);
    ok(res, { message:`Order status updated to '${status}'` });
  })
);

// ══ SHIPPING ════════════════════════════════════════════════

router.get('/shipping', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status, carrier } = req.query;
  const where = ['1=1']; const params = [];
  if (status)  { where.push('s.ShippingStatus=?'); params.push(status); }
  if (carrier) { where.push('s.Carrier LIKE ?');   params.push(`%${carrier}%`); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Shipping s WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT s.*,o.TotalAmount,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName
     FROM Shipping s INNER JOIN Orders o ON o.OrderID=s.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID
     WHERE ${where.join(' AND ')} ORDER BY s.ShippedAt DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { shipping:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

router.get('/shipping/track/:orderId', authenticate, [param('orderId').isInt()], validate,
  wrap(async (req,res) => {
    const [[s]] = await pool.execute('SELECT s.*,o.CustomerID FROM Shipping s INNER JOIN Orders o ON o.OrderID=s.OrderID WHERE s.OrderID=?', [toInt(req.params.orderId)]);
    if (!s) return fail(res, 'Shipping not found', 404);
    ok(res, s);
  })
);

router.patch('/admin/shipping/:id/attempt', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { note } = req.body;
    await pool.execute('UPDATE Shipping SET DeliveryAttempts=IFNULL(DeliveryAttempts,0)+1,DeliveryNotes=CONCAT(IFNULL(DeliveryNotes,"")," | ",?) WHERE ShippingID=?', [note||'Attempted', toInt(req.params.id)]);
    ok(res, { message:'Delivery attempt recorded' });
  })
);

router.get('/admin/shipping/sla-breaches', authenticate, adminOnly, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT s.*,o.OrderDate,o.TotalAmount,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,DATEDIFF(NOW(),s.EstimatedDeliveryDate) AS DaysOverdue
     FROM Shipping s INNER JOIN Orders o ON o.OrderID=s.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID
     WHERE s.ShippingStatus NOT IN ('delivered','returned') AND s.EstimatedDeliveryDate < NOW()
     ORDER BY DaysOverdue DESC`
  );
  ok(res, rows);
}));

// Basic payment CRUD (gateway handled by payments.js)
router.get('/payments', authenticate, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const isAdmin = ['admin','super_admin','manager'].includes(req.user.role);
  const where = isAdmin ? '1=1' : 'p.OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID=?)';
  const params = isAdmin ? [limit, offset] : [req.user.id, limit, offset];
  const [rows] = await pool.execute(`SELECT p.*,o.CustomerID FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID WHERE ${where} ORDER BY p.PaymentDate DESC LIMIT ? OFFSET ?`, params);
  ok(res, rows);
}));

router.get('/payments/:id', authenticate, [param('id').isInt()], validate, wrap(async (req,res) => {
  const [[p]] = await pool.execute('SELECT p.*,o.CustomerID FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID WHERE p.PaymentID=?', [toInt(req.params.id)]);
  if (!p) return fail(res, 'Payment not found', 404);
  ok(res, p);
}));

router.patch('/payments/:id/status', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { status, transactionReference, gatewayResponse } = req.body;
    await pool.execute('UPDATE Payments SET PaymentStatus=?,TransactionReference=IFNULL(?,TransactionReference) WHERE PaymentID=?', [status, transactionReference||null, toInt(req.params.id)]);
    ok(res, { message:'Payment status updated' });
  })
);

module.exports = router;
