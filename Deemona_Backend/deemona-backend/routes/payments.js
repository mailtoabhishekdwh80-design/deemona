// routes/payments.js  — Complete Payment Gateway Routes (MySQL)
'use strict';
const router  = require('express').Router();
const { body, param } = require('express-validator');
const pool    = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, toInt } = require('../middleware');
const PaymentService = require('../services/payment');
const EmailService   = require('../services/email');

// POST /api/payments/initiate
router.post('/initiate', authenticate,
  [body('orderID').isInt({min:1}), body('gateway').optional().isIn(['razorpay','stripe'])], validate,
  wrap(async (req,res) => {
    const { orderID, gateway } = req.body;
    const [[o]] = await pool.execute(
      `SELECT o.OrderID,o.TotalAmount,o.Currency,o.PaymentMethod,o.Status,
              p.PaymentID,p.PaymentStatus,p.GatewayOrderID,
              c.Email,c.FirstName,c.LastName,c.PhoneNumber
       FROM Orders o
       INNER JOIN Payments  p ON p.OrderID   =o.OrderID
       INNER JOIN Customers c ON c.CustomerID=o.CustomerID
       WHERE o.OrderID=? AND o.CustomerID=?`, [toInt(orderID), req.user.id]
    );
    if (!o) return fail(res, 'Order not found', 404);
    if (!['pending','on_hold'].includes(o.Status)) return fail(res, `Order is already ${o.Status}`, 400);
    if (o.PaymentStatus==='completed') return fail(res, 'Payment already completed', 400);
    if (o.PaymentMethod==='cod') return ok(res, { gateway:'cod', message:'Cash on delivery — no payment gateway needed' });
    if (o.GatewayOrderID) return ok(res, { reused:true, gatewayOrderID:o.GatewayOrderID, keyID:process.env.RAZORPAY_KEY_ID, amount:o.TotalAmount, currency:o.Currency||'INR' });

    const useGateway = gateway || PaymentService.detectGateway(o.Currency||'INR', o.PaymentMethod);
    let gatewayData;
    if (useGateway==='razorpay') {
      gatewayData = await PaymentService.razorpay_createOrder({ amount:o.TotalAmount, currency:o.Currency||'INR', orderID:o.OrderID, customerID:req.user.id });
      gatewayData.prefill = { name:`${o.FirstName} ${o.LastName}`, email:o.Email, contact:o.PhoneNumber||'' };
    } else {
      gatewayData = await PaymentService.stripe_createPaymentIntent({ amount:o.TotalAmount, currency:(o.Currency||'INR').toLowerCase(), orderID:o.OrderID, customerID:req.user.id });
    }

    await pool.execute(
      "UPDATE Payments SET GatewayOrderID=?,PaymentGateway=?,PaymentStatus='initiated',UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus='pending'",
      [gatewayData.gatewayOrderID||gatewayData.paymentIntentID, useGateway, toInt(orderID)]
    );
    await pool.execute(
      'INSERT INTO PaymentAttempts(PaymentID,OrderID,GatewayOrderID,PaymentMethod,Status,Amount,IPAddress,UserAgent) VALUES(?,?,?,?,?,?,?,?)',
      [o.PaymentID,toInt(orderID),gatewayData.gatewayOrderID||gatewayData.paymentIntentID||null,o.PaymentMethod,'initiated',o.TotalAmount,req.ip||null,req.headers['user-agent']?.slice(0,200)||null]
    );
    ok(res, gatewayData);
  })
);

// POST /api/payments/verify
router.post('/verify', authenticate,
  [body('orderID').isInt({min:1}), body('gateway').isIn(['razorpay','stripe']),
   body('gatewayOrderID').if(body('gateway').equals('razorpay')).notEmpty(),
   body('gatewayPaymentID').if(body('gateway').equals('razorpay')).notEmpty(),
   body('signature').if(body('gateway').equals('razorpay')).notEmpty(),
   body('paymentIntentID').if(body('gateway').equals('stripe')).notEmpty()], validate,
  wrap(async (req,res) => {
    const { orderID, gateway, gatewayOrderID, gatewayPaymentID, signature, paymentIntentID } = req.body;
    const [[o]] = await pool.execute(
      `SELECT o.OrderID,o.TotalAmount,o.CustomerID,o.Status,
              p.PaymentID,p.PaymentStatus,p.GatewayOrderID,p.Amount,p.Currency,
              c.Email,c.FirstName
       FROM Orders o
       INNER JOIN Payments  p ON p.OrderID   =o.OrderID
       INNER JOIN Customers c ON c.CustomerID=o.CustomerID
       WHERE o.OrderID=? AND o.CustomerID=?`, [toInt(orderID), req.user.id]
    );
    if (!o) return fail(res, 'Order not found', 404);
    if (o.PaymentStatus==='completed') return ok(res, { alreadyConfirmed:true, message:'Payment was already verified' });

    let verified=false, gatewayResponse=null;
    if (gateway==='razorpay') {
      verified = PaymentService.razorpay_verifySignature({ gatewayOrderID, gatewayPaymentID, signature });
      if (!verified) return fail(res, 'Payment signature verification failed', 400);
      try {
        gatewayResponse = await PaymentService.razorpay_fetchPayment(gatewayPaymentID);
        const gwAmt = gatewayResponse.amount / 100;
        if (Math.abs(gwAmt - o.Amount) > 1) {
          await _recordFailedAttempt(o, gatewayPaymentID, 'amount_mismatch', `Gateway: ₹${gwAmt} vs DB: ₹${o.Amount}`);
          return fail(res, 'Payment amount mismatch — contact support', 400);
        }
      } catch(e) { console.warn('[PAYMENT] Could not fetch details:', e.message); }
    } else {
      const pi = await PaymentService.stripe_fetchPaymentIntent(paymentIntentID);
      verified = pi.status==='succeeded';
      gatewayResponse = pi;
      if (!verified) return fail(res, `Payment not succeeded — Stripe status: ${pi.status}`, 400);
    }

    const conn = await pool.getConnection();
    await conn.beginTransaction();
    try {
      const now = new Date();
      await conn.execute(
        `UPDATE Payments SET PaymentStatus='completed',GatewayPaymentID=?,TransactionReference=?,
         GatewayResponse=?,PaymentDate=?,CapturedAt=?,UpdatedAt=? WHERE PaymentID=?`,
        [gateway==='razorpay'?gatewayPaymentID:paymentIntentID, gateway==='razorpay'?gatewayPaymentID:paymentIntentID,
         JSON.stringify(gatewayResponse||{}), now, now, now, o.PaymentID]
      );
      await conn.execute("UPDATE Orders SET Status='confirmed',UpdatedAt=NOW() WHERE OrderID=? AND Status IN ('pending','on_hold')", [toInt(orderID)]);
      await conn.execute(
        'INSERT INTO PaymentAttempts(PaymentID,OrderID,GatewayOrderID,GatewayPaymentID,Status,Amount,IPAddress) VALUES(?,?,?,?,?,?,?)',
        [o.PaymentID,toInt(orderID),gateway==='razorpay'?gatewayOrderID:paymentIntentID,gateway==='razorpay'?gatewayPaymentID:paymentIntentID,'completed',o.Amount,req.ip||null]
      );
      await conn.commit();

      // Send confirmation email (non-blocking)
      const [[orderDetails]] = await pool.execute('SELECT * FROM Orders WHERE OrderID=?', [toInt(orderID)]);
      const [items] = await pool.execute('SELECT oi.*,p.Name AS ProductName FROM OrderItems oi JOIN Products p ON p.ProductID=oi.ProductID WHERE oi.OrderID=?', [toInt(orderID)]);
      EmailService.sendOrderConfirmation(orderDetails, { Email:o.Email, FirstName:o.FirstName }, items).catch(console.error);

      ok(res, { message:'Payment verified and order confirmed', orderID:toInt(orderID), paymentID:o.PaymentID, transactionReference:gateway==='razorpay'?gatewayPaymentID:paymentIntentID });
    } catch(e) { await conn.rollback(); throw e; } finally { conn.release(); }
  })
);

async function _recordFailedAttempt(o, gatewayPaymentID, code, reason) {
  try {
    await pool.execute('INSERT INTO PaymentAttempts(PaymentID,OrderID,GatewayPaymentID,Status,Amount,FailureCode,FailureReason) VALUES(?,?,?,?,?,?,?)',
      [o.PaymentID,o.OrderID,gatewayPaymentID||null,'failed',o.Amount,code,reason]);
  } catch {}
}

// POST /api/payments/webhook
router.post('/webhook', wrap(async (req,res) => {
  const rzpSig  = req.headers['x-razorpay-signature'];
  const strpSig = req.headers['stripe-signature'];
  if (rzpSig) {
    if (!PaymentService.razorpay_verifyWebhook(req.body, rzpSig)) return res.status(400).json({ error:'Invalid signature' });
    await handleRazorpayWebhook(JSON.parse(req.body.toString()));
    return res.status(200).json({ received:true });
  }
  if (strpSig) {
    let event;
    try { event = PaymentService.stripe_verifyWebhook(req.body, strpSig); } catch(e) { return res.status(400).json({ error:e.message }); }
    await handleStripeWebhook(event);
    return res.status(200).json({ received:true });
  }
  res.status(400).json({ error:'Unknown webhook source' });
}));

async function handleRazorpayWebhook(event) {
  const entity = event.payload?.payment?.entity || event.payload?.order?.entity || {};
  const orderEntity = event.payload?.order?.entity;
  switch (event.event) {
    case 'payment.authorized': {
      const oid = entity.notes?.deemonaOrderID; if (!oid) break;
      await pool.execute("UPDATE Payments SET GatewayPaymentID=?,AuthorizedAt=NOW(),PaymentStatus='initiated',UpdatedAt=NOW() WHERE GatewayOrderID=? AND PaymentStatus='initiated'", [entity.id, entity.order_id]);
      break;
    }
    case 'payment.captured':
    case 'order.paid': {
      const oid = entity.notes?.deemonaOrderID || orderEntity?.notes?.deemonaOrderID; if (!oid) break;
      const [[ex]] = await pool.execute("SELECT 1 FROM Orders WHERE OrderID=? AND Status='confirmed'", [parseInt(oid)]);
      if (ex) break;
      await pool.execute("UPDATE Payments SET PaymentStatus='completed',GatewayPaymentID=?,TransactionReference=?,GatewayResponse=?,PaymentDate=NOW(),CapturedAt=NOW(),UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus IN ('pending','initiated')", [entity.id, entity.id, JSON.stringify(entity), parseInt(oid)]);
      await pool.execute("UPDATE Orders SET Status='confirmed',UpdatedAt=NOW() WHERE OrderID=? AND Status IN ('pending','on_hold')", [parseInt(oid)]);
      break;
    }
    case 'payment.failed': {
      const oid = entity.notes?.deemonaOrderID; if (!oid) break;
      await pool.execute("UPDATE Payments SET PaymentStatus='failed',FailureCode=?,FailureReason=?,GatewayResponse=?,UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus IN ('pending','initiated')",
        [entity.error_code||'UNKNOWN', entity.error_description||entity.error_reason||'', JSON.stringify(entity), parseInt(oid)]);
      break;
    }
    case 'refund.created': {
      const refund = event.payload?.refund?.entity; if (!refund) break;
      const status = refund.amount===refund.payment?.amount ? 'refunded' : 'partially_refunded';
      await pool.execute("UPDATE Payments SET PaymentStatus=?,RefundReference=?,RefundAmount=?,RefundDate=NOW(),UpdatedAt=NOW() WHERE GatewayPaymentID=?",
        [status, refund.id, refund.amount/100, refund.payment_id]);
      break;
    }
    case 'payment_link.paid': {
      const pl = event.payload?.payment_link?.entity; if (!pl) break;
      const oid = pl.reference_id?.replace('order_',''); if (!oid) break;
      await pool.execute("UPDATE PaymentLinks SET Status='paid',PaidAt=NOW() WHERE GatewayLinkID=?", [pl.id]);
      await pool.execute("UPDATE Payments SET PaymentStatus='completed',PaymentDate=NOW(),UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus IN ('pending','initiated')", [parseInt(oid)]);
      await pool.execute("UPDATE Orders SET Status='confirmed',UpdatedAt=NOW() WHERE OrderID=? AND Status='pending'", [parseInt(oid)]);
      break;
    }
  }
}

async function handleStripeWebhook(event) {
  switch (event.type) {
    case 'payment_intent.succeeded': {
      const pi = event.data.object; const oid = pi.metadata?.deemonaOrderID; if (!oid) break;
      const [[ex]] = await pool.execute("SELECT 1 FROM Orders WHERE OrderID=? AND Status='confirmed'", [parseInt(oid)]);
      if (ex) break;
      await pool.execute("UPDATE Payments SET PaymentStatus='completed',GatewayPaymentID=?,TransactionReference=?,GatewayResponse=?,PaymentDate=NOW(),CapturedAt=NOW(),UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus IN ('pending','initiated')",
        [pi.id, pi.latest_charge||pi.id, JSON.stringify({id:pi.id,status:pi.status}), parseInt(oid)]);
      await pool.execute("UPDATE Orders SET Status='confirmed',UpdatedAt=NOW() WHERE OrderID=? AND Status='pending'", [parseInt(oid)]);
      break;
    }
    case 'payment_intent.payment_failed': {
      const pi = event.data.object; const oid = pi.metadata?.deemonaOrderID; if (!oid) break;
      const err = pi.last_payment_error;
      await pool.execute("UPDATE Payments SET PaymentStatus='failed',FailureCode=?,FailureReason=?,UpdatedAt=NOW() WHERE OrderID=? AND PaymentStatus IN ('pending','initiated')",
        [err?.decline_code||err?.code||'UNKNOWN', err?.message||'Payment failed', parseInt(oid)]);
      break;
    }
    case 'charge.refunded': {
      const charge = event.data.object; const pi = charge.payment_intent; if (!pi) break;
      await pool.execute("UPDATE Payments SET PaymentStatus=?,RefundAmount=?,RefundDate=NOW(),UpdatedAt=NOW() WHERE GatewayPaymentID=?",
        [charge.refunded?'refunded':'partially_refunded', charge.amount_refunded/100, pi]);
      break;
    }
  }
}

// POST /api/payments/link
router.post('/link', authenticate, [body('orderID').isInt({min:1})], validate,
  wrap(async (req,res) => {
    const { orderID, expiryMinutes=60 } = req.body;
    const [[o]] = await pool.execute(
      `SELECT o.OrderID,o.TotalAmount,o.Currency,o.Status,c.Email,c.FirstName,c.LastName,c.PhoneNumber
       FROM Orders o INNER JOIN Customers c ON c.CustomerID=o.CustomerID
       WHERE o.OrderID=? AND o.CustomerID=? AND o.Status IN ('pending','on_hold')`, [toInt(orderID), req.user.id]
    );
    if (!o) return fail(res, 'Order not found or not payable', 404);
    const link = await PaymentService.razorpay_createPaymentLink({ amount:o.TotalAmount, currency:o.Currency||'INR', orderID:o.OrderID, customer:{ name:`${o.FirstName} ${o.LastName}`, email:o.Email, phone:o.PhoneNumber }, expiryMinutes });
    await pool.execute('INSERT INTO PaymentLinks(OrderID,CustomerID,GatewayLinkID,ShortURL,Amount,ExpiresAt) VALUES(?,?,?,?,?,?)',
      [o.OrderID, req.user.id, link.gatewayLinkID, link.shortURL, o.TotalAmount, link.expiresAt]);
    ok(res, { shortURL:link.shortURL, expiresAt:link.expiresAt });
  })
);

// GET /api/payments  (admin)
router.get('/', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status, gateway, method, from, to } = req.query;
  const where = ['1=1']; const params = [];
  if (status)  { where.push('p.PaymentStatus=?');  params.push(status); }
  if (gateway) { where.push('p.PaymentGateway=?'); params.push(gateway); }
  if (method)  { where.push('p.PaymentMethod=?');  params.push(method); }
  if (from)    { where.push('p.CreatedAt>=?');     params.push(new Date(from)); }
  if (to)      { where.push('p.CreatedAt<=?');     params.push(new Date(to)); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT p.PaymentID,p.OrderID,p.Amount,p.Currency,p.PaymentMethod,p.PaymentStatus,p.PaymentGateway,
            p.GatewayOrderID,p.GatewayPaymentID,p.TransactionReference,p.PaymentDate,
            p.RefundAmount,p.RefundDate,p.FailureCode,p.FailureReason,p.CreatedAt,
            CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,c.Email,o.Status AS OrderStatus
     FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID
     WHERE ${where.join(' AND ')} ORDER BY p.CreatedAt DESC LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { payments:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

// GET /api/payments/:id
router.get('/:id', authenticate, [param('id').isInt()], validate, wrap(async (req,res) => {
  const [[p]] = await pool.execute(
    `SELECT p.*,o.Status AS OrderStatus,o.CustomerID,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName
     FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID
     WHERE p.PaymentID=?`, [toInt(req.params.id)]
  );
  if (!p) return fail(res, 'Payment not found', 404);
  if (req.user.role==='customer' && p.CustomerID!==req.user.id) return fail(res, 'Access denied', 403);
  const [attempts] = await pool.execute('SELECT AttemptedAt,Status,FailureCode,FailureReason FROM PaymentAttempts WHERE PaymentID=? ORDER BY AttemptedAt DESC', [toInt(req.params.id)]);
  ok(res, { ...p, attempts });
}));

// POST /api/payments/:id/refund
router.post('/:id/refund', authenticate, adminOnly,
  [param('id').isInt(), body('amount').optional().isFloat({min:0.01}),
   body('reason').optional().isIn(['customer_request','duplicate','fraudulent','order_cancellation']),
   body('speed').optional().isIn(['normal','optimum'])], validate,
  wrap(async (req,res) => {
    const { amount, reason='customer_request', speed='normal' } = req.body;
    const [[pay]] = await pool.execute('SELECT p.*,o.OrderID,o.CustomerID,o.Status AS OrderStatus FROM Payments p INNER JOIN Orders o ON o.OrderID=p.OrderID WHERE p.PaymentID=?', [toInt(req.params.id)]);
    if (!pay) return fail(res, 'Payment not found', 404);
    if (pay.PaymentStatus!=='completed') return fail(res, `Cannot refund — status is '${pay.PaymentStatus}'`);
    const refundAmt = amount || pay.Amount;
    if (refundAmt > pay.Amount) return fail(res, `Refund ₹${refundAmt} exceeds payment ₹${pay.Amount}`);

    let refundRef;
    if (pay.PaymentGateway==='razorpay' && pay.GatewayPaymentID) {
      const r = await PaymentService.razorpay_refund(pay.GatewayPaymentID, refundAmt, { reason, speed }); refundRef = r.id;
    } else if (pay.PaymentGateway==='stripe' && pay.GatewayPaymentID) {
      const r = await PaymentService.stripe_refund(pay.GatewayPaymentID, refundAmt, { reason }); refundRef = r.id;
    } else { refundRef = `MANUAL_${Date.now()}`; }

    const isPartial = refundAmt < pay.Amount;
    await pool.execute('UPDATE Payments SET PaymentStatus=?,RefundReference=?,RefundAmount=?,RefundDate=NOW(),UpdatedAt=NOW() WHERE PaymentID=?',
      [isPartial?'partially_refunded':'refunded', refundRef, refundAmt, toInt(req.params.id)]);
    await pool.execute("UPDATE Orders SET RefundStatus='processing',UpdatedAt=NOW() WHERE OrderID=?", [pay.OrderID]);
    ok(res, { refundReference:refundRef, amount:refundAmt, isPartial, estimatedDays:speed==='optimum'?1:5, message:`Refund of ₹${refundAmt} initiated.` });
  })
);

// PATCH /api/payments/:id/status
router.patch('/:id/status', authenticate, adminOnly,
  [param('id').isInt(), body('status').isIn(['pending','initiated','completed','failed','refunded','partially_refunded','cancelled'])], validate,
  wrap(async (req,res) => {
    const { status, transactionReference, gatewayResponse } = req.body;
    await pool.execute(
      'UPDATE Payments SET PaymentStatus=?,TransactionReference=IFNULL(?,TransactionReference),GatewayResponse=IFNULL(?,GatewayResponse),PaymentDate=IF(?="completed",NOW(),PaymentDate),UpdatedAt=NOW() WHERE PaymentID=?',
      [status, transactionReference||null, gatewayResponse?JSON.stringify(gatewayResponse):null, status, toInt(req.params.id)]
    );
    if (status==='completed') {
      const [[p]] = await pool.execute('SELECT OrderID FROM Payments WHERE PaymentID=?', [toInt(req.params.id)]);
      if (p) await pool.execute("UPDATE Orders SET Status='confirmed',UpdatedAt=NOW() WHERE OrderID=? AND Status='pending'", [p.OrderID]);
    }
    ok(res, { message:`Payment status updated to '${status}'` });
  })
);

// GET /api/payments/:id/attempts
router.get('/:id/attempts', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute('SELECT AttemptID,GatewayOrderID,GatewayPaymentID,PaymentMethod,Status,Amount,Currency,FailureCode,FailureReason,IPAddress,AttemptedAt FROM PaymentAttempts WHERE PaymentID=? ORDER BY AttemptedAt DESC', [toInt(req.params.id)]);
    ok(res, rows);
  })
);

// GET /api/payments/admin/stats
router.get('/admin/stats', authenticate, adminOnly, wrap(async (req,res) => {
  const s = new Date(req.query.from || Date.now()-30*86400000);
  const e = new Date(req.query.to   || Date.now());
  const [volume, methodBreakdown, failureReasons, refundStats] = await Promise.all([
    pool.execute(`SELECT COUNT(*) AS TotalAttempts, SUM(PaymentStatus='completed') AS Successful, SUM(PaymentStatus='failed') AS Failed,
                  IFNULL(SUM(CASE WHEN PaymentStatus='completed' THEN Amount ELSE 0 END),0) AS TotalVolume,
                  IFNULL(SUM(CASE WHEN PaymentStatus='refunded' THEN RefundAmount ELSE 0 END),0) AS TotalRefunded,
                  ROUND(SUM(PaymentStatus='completed')*100.0/NULLIF(COUNT(*),0),2) AS SuccessRate
                  FROM Payments WHERE CreatedAt BETWEEN ? AND ?`, [s,e]),
    pool.execute(`SELECT PaymentMethod,COUNT(*) AS Attempts,SUM(PaymentStatus='completed') AS Successful,
                  IFNULL(SUM(CASE WHEN PaymentStatus='completed' THEN Amount END),0) AS Volume
                  FROM Payments WHERE CreatedAt BETWEEN ? AND ? GROUP BY PaymentMethod ORDER BY Volume DESC`, [s,e]),
    pool.execute(`SELECT FailureCode,FailureReason,COUNT(*) AS Occurrences FROM Payments
                  WHERE PaymentStatus='failed' AND FailureCode IS NOT NULL AND CreatedAt BETWEEN ? AND ?
                  GROUP BY FailureCode,FailureReason ORDER BY Occurrences DESC LIMIT 10`, [s,e]),
    pool.execute(`SELECT COUNT(CASE WHEN RefundAmount IS NOT NULL THEN 1 END) AS RefundCount,
                  IFNULL(SUM(RefundAmount),0) AS RefundVolume FROM Payments WHERE CreatedAt BETWEEN ? AND ?`, [s,e]),
  ]);
  ok(res, { period:{from:s,to:e}, volume:volume[0][0], methodBreakdown:methodBreakdown[0], failureReasons:failureReasons[0], refundStats:refundStats[0][0] });
}));

module.exports = router;
module.exports.handleRazorpayWebhook = handleRazorpayWebhook;
module.exports.handleStripeWebhook   = handleStripeWebhook;
