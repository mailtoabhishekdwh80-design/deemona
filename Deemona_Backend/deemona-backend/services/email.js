// services/email.js  — Complete Email Service
// Nodemailer + HTML templates for every event
'use strict';
const nodemailer = require('nodemailer');

// ── Transport ──────────────────────────────────────────────
const createTransport = () => {
  if (process.env.NODE_ENV === 'test') {
    return { sendMail: async () => ({ messageId: 'test' }) };
  }
  return nodemailer.createTransport({
    host:   process.env.SMTP_HOST || 'smtp.gmail.com',
    port:   parseInt(process.env.SMTP_PORT || '587'),
    secure: process.env.SMTP_SECURE === 'true',
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });
};

let transporter;
const getTransport = () => {
  if (!transporter) transporter = createTransport();
  return transporter;
};

// ── Base template ──────────────────────────────────────────
const base = (title, bodyHTML) => `
<!DOCTYPE html><html><head>
<meta charset="UTF-8"/><meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>${title}</title>
<style>
  body{margin:0;padding:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:#f5f5f5}
  .wrap{max-width:600px;margin:40px auto;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.08)}
  .header{background:#0f172a;padding:28px 32px;text-align:center}
  .header h1{color:#f59e0b;margin:0;font-size:22px;letter-spacing:-.01em}
  .header p{color:rgba(255,255,255,.5);margin:4px 0 0;font-size:13px}
  .body{padding:32px}
  .body h2{color:#111827;margin:0 0 8px;font-size:18px}
  .body p{color:#374151;font-size:14px;line-height:1.65;margin:0 0 16px}
  .btn{display:inline-block;background:#f59e0b;color:#0f172a!important;padding:12px 28px;border-radius:6px;font-weight:700;font-size:14px;text-decoration:none;margin:8px 0}
  .divider{border:none;border-top:1px solid #e5e7eb;margin:24px 0}
  .table{width:100%;border-collapse:collapse;font-size:13px}
  .table th{background:#f9fafb;padding:8px 12px;text-align:left;color:#6b7280;font-weight:600;border-bottom:2px solid #e5e7eb}
  .table td{padding:10px 12px;border-bottom:1px solid #f3f4f6;color:#374151}
  .total-row td{font-weight:700;background:#f9fafb;font-size:14px}
  .badge{display:inline-block;padding:3px 10px;border-radius:100px;font-size:11px;font-weight:700}
  .badge-green{background:#d1fae5;color:#065f46}
  .badge-blue{background:#dbeafe;color:#1e3a8a}
  .badge-orange{background:#fef3c7;color:#78350f}
  .footer{background:#f9fafb;padding:20px 32px;text-align:center;font-size:12px;color:#9ca3af}
  .footer a{color:#6b7280}
</style>
</head>
<body><div class="wrap">
<div class="header"><h1>Deemona</h1><p>Discover · Dream · Deliver</p></div>
<div class="body">${bodyHTML}</div>
<hr class="divider"/>
<div class="footer">
  <p>© ${new Date().getFullYear()} Deemona Commerce Pvt. Ltd. · Mumbai, India</p>
  <p><a href="{{APP_URL}}/unsubscribe">Unsubscribe</a> · <a href="{{APP_URL}}/privacy">Privacy Policy</a></p>
</div>
</div></body></html>
`.replace(/\{\{APP_URL\}\}/g, process.env.APP_URL || 'https://deemona.com');

// ── Send helper ────────────────────────────────────────────
const send = async ({ to, subject, html }) => {
  if (!process.env.SMTP_USER && process.env.NODE_ENV !== 'test') {
    console.log(`[EMAIL SKIP] No SMTP config — would send "${subject}" to ${to}`);
    return;
  }
  const t = getTransport();
  const info = await t.sendMail({
    from:    `"Deemona" <${process.env.EMAIL_FROM || process.env.SMTP_USER}>`,
    to, subject, html,
  });
  console.log(`[EMAIL] Sent "${subject}" to ${to} → ${info.messageId}`);
  return info;
};

// ══════════════════════════════════════════════════════════
//  EMAIL TEMPLATES
// ══════════════════════════════════════════════════════════

const EmailService = {

  // ── Welcome email ──────────────────────────────────────
  async sendWelcome(customer) {
    await send({
      to:      customer.Email,
      subject: '🎉 Welcome to Deemona — 100 bonus points inside!',
      html: base('Welcome to Deemona', `
        <h2>Welcome, ${customer.FirstName}! 👋</h2>
        <p>Your account is ready. We've added <strong>100 loyalty points</strong> to your account as a welcome gift.</p>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/shop" class="btn">Start Shopping</a>
        <hr class="divider"/>
        <p style="font-size:12px;color:#9ca3af">Your account email: ${customer.Email}</p>
      `),
    });
  },

  // ── Order confirmation ─────────────────────────────────
  async sendOrderConfirmation(order, customer, items) {
    const rows = items.map(i => `
      <tr>
        <td>${i.ProductName}</td>
        <td style="text-align:center">${i.Quantity}</td>
        <td style="text-align:right">₹${i.UnitPrice.toLocaleString('en-IN')}</td>
        <td style="text-align:right">₹${(i.Quantity*i.UnitPrice).toLocaleString('en-IN')}</td>
      </tr>`).join('');

    await send({
      to:      customer.Email,
      subject: `✅ Order Confirmed — #${order.OrderID} | ₹${order.TotalAmount?.toLocaleString('en-IN')}`,
      html: base('Order Confirmed', `
        <h2>Your order is confirmed! 🎉</h2>
        <p>Hi ${customer.FirstName}, we've received your order and it's being processed.</p>
        <p>
          <strong>Order #${order.OrderID}</strong> &nbsp;
          <span class="badge badge-green">Confirmed</span>
        </p>
        <table class="table">
          <thead><tr><th>Product</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead>
          <tbody>${rows}</tbody>
          <tr class="total-row"><td colspan="3">Subtotal</td><td style="text-align:right">₹${order.SubTotal?.toLocaleString('en-IN')}</td></tr>
          <tr><td colspan="3" style="font-size:12px;color:#9ca3af">GST</td><td style="text-align:right;font-size:12px;color:#9ca3af">₹${order.TaxAmount?.toLocaleString('en-IN')}</td></tr>
          <tr><td colspan="3" style="font-size:12px;color:#9ca3af">Shipping</td><td style="text-align:right;font-size:12px;color:#9ca3af">${order.ShippingAmount === 0 ? '🆓 Free' : '₹' + order.ShippingAmount}</td></tr>
          ${order.DiscountAmount > 0 ? `<tr><td colspan="3" style="color:#059669">Discount</td><td style="text-align:right;color:#059669">−₹${order.DiscountAmount?.toLocaleString('en-IN')}</td></tr>` : ''}
          <tr class="total-row"><td colspan="3">Total</td><td style="text-align:right">₹${order.TotalAmount?.toLocaleString('en-IN')}</td></tr>
        </table>
        <br/>
        <p>Estimated delivery: <strong>${new Date(order.DeliveryDateEstimate).toLocaleDateString('en-IN', { weekday:'long', day:'numeric', month:'long' })}</strong></p>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/orders/${order.OrderID}" class="btn">Track Your Order</a>
        ${order.LoyaltyPointsEarned ? `<p style="font-size:12px;color:#059669">🎯 You earned <strong>${order.LoyaltyPointsEarned} loyalty points</strong> on this order!</p>` : ''}
      `),
    });
  },

  // ── Shipment dispatched ────────────────────────────────
  async sendShipmentDispatched(order, customer, shipping) {
    await send({
      to:      customer.Email,
      subject: `🚚 Your Order #${order.OrderID} Has Been Shipped!`,
      html: base('Order Shipped', `
        <h2>Your order is on its way! 📦</h2>
        <p>Hi ${customer.FirstName}, great news — your order has been dispatched.</p>
        <p>
          <strong>Carrier:</strong> ${shipping.Carrier} &nbsp;
          <span class="badge badge-blue">In Transit</span>
        </p>
        <p><strong>Tracking Number:</strong> ${shipping.TrackingNumber}</p>
        ${shipping.TrackingURL ? `<a href="${shipping.TrackingURL}" class="btn">Track Shipment</a>` : ''}
        <p style="font-size:13px;color:#6b7280">Estimated delivery: ${new Date(order.DeliveryDateEstimate).toLocaleDateString('en-IN', { weekday:'long', day:'numeric', month:'long' })}</p>
      `),
    });
  },

  // ── Delivered ──────────────────────────────────────────
  async sendDeliveryConfirmation(order, customer) {
    await send({
      to:      customer.Email,
      subject: `✅ Delivered! Order #${order.OrderID} — How was your experience?`,
      html: base('Order Delivered', `
        <h2>Your order has been delivered! 🎉</h2>
        <p>Hi ${customer.FirstName}, we hope you love your purchase.</p>
        <p>You have <strong>10 days</strong> from today to initiate a return if needed.</p>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/orders/${order.OrderID}/review" class="btn">Leave a Review</a>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/orders/${order.OrderID}/return" style="display:inline-block;margin-left:10px;color:#6b7280;font-size:13px">Request Return</a>
        <hr class="divider"/>
        <p style="font-size:12px;color:#9ca3af">Review earns you 50 loyalty points!</p>
      `),
    });
  },

  // ── Cancellation + refund ──────────────────────────────
  async sendOrderCancelled(order, customer, refundRef) {
    await send({
      to:      customer.Email,
      subject: `❌ Order #${order.OrderID} Cancelled — Refund Initiated`,
      html: base('Order Cancelled', `
        <h2>Order cancelled</h2>
        <p>Hi ${customer.FirstName}, your order <strong>#${order.OrderID}</strong> has been cancelled.</p>
        ${refundRef ? `<p>A refund of <strong>₹${order.TotalAmount?.toLocaleString('en-IN')}</strong> has been initiated to your original payment method.</p><p>Reference: <code>${refundRef}</code></p><p>Expect the refund in <strong>3–5 business days</strong>.</p>` : ''}
        <a href="${process.env.APP_URL || 'https://deemona.com'}/shop" class="btn">Continue Shopping</a>
      `),
    });
  },

  // ── Password reset ─────────────────────────────────────
  async sendPasswordReset(customer, resetLink) {
    await send({
      to:      customer.Email,
      subject: '🔑 Reset Your Deemona Password',
      html: base('Password Reset', `
        <h2>Reset your password</h2>
        <p>Hi ${customer.FirstName}, we received a request to reset your password.</p>
        <p>This link expires in <strong>1 hour</strong>. If you didn't request this, ignore this email.</p>
        <a href="${resetLink}" class="btn">Reset Password</a>
        <hr class="divider"/>
        <p style="font-size:12px;color:#9ca3af">If the button doesn't work, copy this link:<br/><a href="${resetLink}" style="color:#6b7280;word-break:break-all">${resetLink}</a></p>
      `),
    });
  },

  // ── Low stock alert to admin ───────────────────────────
  async sendLowStockAlert(adminEmail, alerts) {
    const rows = alerts.map(a => `
      <tr>
        <td>${a.Name}</td>
        <td>${a.SKU}</td>
        <td style="color:${a.AlertLevel==='CRITICAL'?'#dc2626':a.AlertLevel==='URGENT'?'#d97706':'#92400e'};font-weight:700">${a.AlertLevel}</td>
        <td style="text-align:center">${a.StockQuantity}</td>
        <td style="text-align:center">${a.SuggestedOrderQty}</td>
      </tr>`).join('');

    await send({
      to:      adminEmail,
      subject: `🔴 ${alerts.filter(a=>a.AlertLevel==='CRITICAL').length} CRITICAL + ${alerts.filter(a=>a.AlertLevel==='URGENT').length} URGENT stock alerts`,
      html: base('Stock Alert', `
        <h2>Low Stock Alert 🔴</h2>
        <p>${alerts.length} products need reordering.</p>
        <table class="table">
          <thead><tr><th>Product</th><th>SKU</th><th>Level</th><th>Stock</th><th>Suggested Order</th></tr></thead>
          <tbody>${rows}</tbody>
        </table>
        <br/>
        <a href="${process.env.ADMIN_URL || 'https://admin.deemona.com'}/inventory/alerts" class="btn">View Inventory</a>
      `),
    });
  },

  // ── Abandoned cart reminder ────────────────────────────
  async sendAbandonedCart(customer, cartValue, couponCode) {
    await send({
      to:      customer.Email,
      subject: `🛒 You left something in your cart — ${couponCode ? `Use ${couponCode} for 10% off!` : 'Complete your order'}`,
      html: base('Complete Your Order', `
        <h2>Your cart is waiting, ${customer.FirstName}! 🛒</h2>
        <p>You have ₹${cartValue.toLocaleString('en-IN')} worth of items waiting.</p>
        ${couponCode ? `<p>Use code <strong style="background:#fef3c7;padding:2px 8px;border-radius:4px">${couponCode}</strong> for <strong>10% off</strong> your order!</p>` : ''}
        <a href="${process.env.APP_URL || 'https://deemona.com'}/cart" class="btn">Complete Purchase</a>
      `),
    });
  },

  // ── Price drop (wishlist) ──────────────────────────────
  async sendPriceDrop(customer, product, oldPrice, newPrice) {
    const savings = oldPrice - newPrice;
    await send({
      to:      customer.Email,
      subject: `💰 Price drop! ${product.Name} is ₹${savings.toLocaleString('en-IN')} cheaper`,
      html: base('Price Drop Alert', `
        <h2>Price drop on your wishlist item! 💰</h2>
        <p><strong>${product.Name}</strong> just dropped in price.</p>
        <p style="font-size:20px">
          <span style="text-decoration:line-through;color:#9ca3af">₹${oldPrice.toLocaleString('en-IN')}</span>
          &nbsp;→&nbsp;
          <strong style="color:#059669">₹${newPrice.toLocaleString('en-IN')}</strong>
          &nbsp;<span class="badge badge-green">Save ₹${savings.toLocaleString('en-IN')}</span>
        </p>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/products/${product.ProductID}" class="btn">Buy Now</a>
      `),
    });
  },

  // ── Loyalty tier upgrade ───────────────────────────────
  async sendTierUpgrade(customer, oldTier, newTier) {
    const badges = { Bronze:'🥉', Silver:'🥈', Gold:'🥇', Platinum:'💎' };
    await send({
      to:      customer.Email,
      subject: `${badges[newTier]} You've been upgraded to ${newTier} tier!`,
      html: base('Tier Upgrade', `
        <h2>Congratulations! You've reached ${newTier} tier ${badges[newTier]}</h2>
        <p>Hi ${customer.FirstName}, you've been upgraded from <strong>${oldTier}</strong> to <strong>${newTier}</strong>!</p>
        <p>Enjoy your new benefits including higher points multiplier and exclusive discounts.</p>
        <a href="${process.env.APP_URL || 'https://deemona.com'}/account/loyalty" class="btn">View Benefits</a>
      `),
    });
  },

};

module.exports = EmailService;
