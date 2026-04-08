// services/jobs.js  — Scheduled Cron Jobs (MySQL)
'use strict';
const cron  = require('node-cron');
const pool  = require('../config/db');
const email = require('./email');

// ── 1. Auto-cancel unpaid orders after 30 min ─────────────
cron.schedule('*/5 * * * *', async () => {
  try {
    const [rows] = await pool.execute(
      `SELECT o.OrderID,o.CustomerID,o.TotalAmount,c.Email,c.FirstName
       FROM Orders o INNER JOIN Customers c ON c.CustomerID=o.CustomerID
       INNER JOIN Payments p ON p.OrderID=o.OrderID
       WHERE o.Status='pending' AND p.PaymentMethod!='cod'
         AND p.PaymentStatus='pending' AND o.OrderDate < DATE_SUB(NOW(),INTERVAL 30 MINUTE)`
    );
    for (const order of rows) {
      await pool.execute("UPDATE Orders SET Status='cancelled',UpdatedAt=NOW() WHERE OrderID=?", [order.OrderID]);
      await pool.execute("INSERT INTO OrderStatusHistory(OrderID,FromStatus,ToStatus,ChangedBy,Note,ChangedAt) VALUES(?,'pending','cancelled','system','Auto-cancelled: payment timeout',NOW())", [order.OrderID]);
      // Restore stock
      const [items] = await pool.execute('SELECT ProductID,Quantity FROM OrderItems WHERE OrderID=?', [order.OrderID]);
      for (const item of items)
        await pool.execute('UPDATE Products SET StockQuantity=StockQuantity+? WHERE ProductID=?', [item.Quantity, item.ProductID]);
      email.sendOrderCancelled({ OrderID:order.OrderID, TotalAmount:order.TotalAmount }, { Email:order.Email, FirstName:order.FirstName }, 'Payment timeout').catch(()=>{});
    }
    if (rows.length > 0) console.log(`[CRON] Auto-cancelled ${rows.length} unpaid orders`);
  } catch(e) { console.error('[CRON] auto-cancel error:', e.message); }
});

// ── 2. Abandoned cart emails (6h) ─────────────────────────
cron.schedule('0 */6 * * *', async () => {
  try {
    const [rows] = await pool.execute(
      `SELECT c.CartID,c.CustomerID,cu.Email,cu.FirstName,COUNT(ci.CartItemID) AS ItemCount
       FROM Carts c INNER JOIN Customers cu ON cu.CustomerID=c.CustomerID
       INNER JOIN CartItems ci ON ci.CartID=c.CartID
       WHERE c.UpdatedAt < DATE_SUB(NOW(),INTERVAL 6 HOUR) AND c.AbandonedEmailSent IS NULL
       GROUP BY c.CartID HAVING ItemCount>0`
    );
    for (const cart of rows) {
      await email.sendAbandonedCart({ Email:cart.Email, FirstName:cart.FirstName }, []).catch(()=>{});
      await pool.execute('UPDATE Carts SET AbandonedEmailSent=NOW() WHERE CartID=?', [cart.CartID]);
    }
    if (rows.length > 0) console.log(`[CRON] Sent ${rows.length} abandoned cart emails`);
  } catch(e) { console.error('[CRON] abandoned cart error:', e.message); }
});

// ── 3. Low stock alerts (8AM daily) ───────────────────────
cron.schedule('0 8 * * *', async () => {
  try {
    const [rows] = await pool.execute(
      `SELECT p.ProductID,p.Name,p.SKU,p.StockQuantity,p.ReorderLevel,c.CategoryName
       FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
       WHERE p.IsActive=1 AND p.StockQuantity<=p.ReorderLevel ORDER BY p.StockQuantity ASC`
    );
    if (rows.length > 0) {
      await email.sendLowStockAlert(rows).catch(()=>{});
      console.log(`[CRON] Low stock alert: ${rows.length} products`);
    }
  } catch(e) { console.error('[CRON] low stock error:', e.message); }
});

// ── 4. Birthday loyalty points (9AM daily) ────────────────
cron.schedule('0 9 * * *', async () => {
  try {
    const today = new Date(); const m=today.getMonth()+1; const d=today.getDate();
    const [rows] = await pool.execute(
      `SELECT CustomerID,FirstName,Email FROM Customers
       WHERE AccountStatus='active' AND DateOfBirth IS NOT NULL
         AND MONTH(DateOfBirth)=? AND DAY(DateOfBirth)=?
         AND (BirthdayPointsLastGiven IS NULL OR YEAR(BirthdayPointsLastGiven)<YEAR(NOW()))`,
      [m, d]
    );
    for (const c of rows) {
      await pool.execute('UPDATE Customers SET LoyaltyPoints=LoyaltyPoints+250,BirthdayPointsLastGiven=CURDATE() WHERE CustomerID=?', [c.CustomerID]);
    }
    if (rows.length > 0) console.log(`[CRON] Birthday points awarded to ${rows.length} customers`);
  } catch(e) { console.error('[CRON] birthday error:', e.message); }
});

// ── 5. Loyalty tier sync (2AM daily) ──────────────────────
cron.schedule('0 2 * * *', async () => {
  try {
    await pool.execute(`
      UPDATE Customers c
      LEFT JOIN (
        SELECT CustomerID,SUM(TotalAmount) AS Total
        FROM Orders WHERE Status NOT IN ('cancelled','refunded')
        GROUP BY CustomerID
      ) s ON s.CustomerID=c.CustomerID
      SET c.LoyaltyTier=CASE
        WHEN IFNULL(s.Total,0)>=100000 THEN 'Platinum'
        WHEN IFNULL(s.Total,0)>=50000  THEN 'Gold'
        WHEN IFNULL(s.Total,0)>=10000  THEN 'Silver'
        ELSE 'Bronze'
      END
      WHERE c.AccountStatus='active'
    `);
    console.log('[CRON] Loyalty tiers synced');
  } catch(e) { console.error('[CRON] tier sync error:', e.message); }
});

// ── 6. Token denylist cleanup (3AM daily) ─────────────────
cron.schedule('0 3 * * *', async () => {
  try {
    const [r1] = await pool.execute('DELETE FROM TokenDenylist WHERE ExpiresAt < NOW()');
    const [r2] = await pool.execute('DELETE FROM RefreshTokens WHERE ExpiresAt < NOW() OR IsRevoked=1');
    console.log(`[CRON] Cleaned ${r1.affectedRows} denied tokens, ${r2.affectedRows} refresh tokens`);
  } catch(e) { console.error('[CRON] token cleanup error:', e.message); }
});

// ── 7. SLA breach check (10AM daily) ──────────────────────
cron.schedule('0 10 * * *', async () => {
  try {
    const [rows] = await pool.execute(
      `SELECT s.ShippingID,o.OrderID,o.TotalAmount,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,DATEDIFF(NOW(),s.EstimatedDeliveryDate) AS DaysOverdue
       FROM Shipping s INNER JOIN Orders o ON o.OrderID=s.OrderID INNER JOIN Customers c ON c.CustomerID=o.CustomerID
       WHERE s.ShippingStatus NOT IN ('delivered','returned') AND s.EstimatedDeliveryDate < NOW()`
    );
    if (rows.length > 0) console.log(`[CRON] SLA breaches: ${rows.length} orders overdue`);
  } catch(e) { console.error('[CRON] SLA check error:', e.message); }
});

const start = () => console.log('✅  Cron jobs started (7 schedules active)');
module.exports = { start };
