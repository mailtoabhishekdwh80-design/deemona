// services/payment.js  — Complete Payment Gateway Service
// Razorpay (primary, India) + Stripe (international)
// Operations: createOrder, verify, capture, refund, links, webhook
'use strict';
const crypto = require('crypto');

// ── Lazy-load SDKs (optional installs) ────────────────────
let _razorpay;
const getRazorpay = () => {
  if (_razorpay) return _razorpay;
  try { const R = require('razorpay'); _razorpay = new R({ key_id: process.env.RAZORPAY_KEY_ID, key_secret: process.env.RAZORPAY_KEY_SECRET }); }
  catch { throw new Error('razorpay not installed. Run: npm install razorpay'); }
  if (!process.env.RAZORPAY_KEY_ID) throw new Error('RAZORPAY_KEY_ID missing in .env');
  return _razorpay;
};

let _stripe;
const getStripe = () => {
  if (_stripe) return _stripe;
  if (!process.env.STRIPE_SECRET_KEY) throw new Error('STRIPE_SECRET_KEY missing in .env');
  try { _stripe = require('stripe')(process.env.STRIPE_SECRET_KEY); }
  catch { throw new Error('stripe not installed. Run: npm install stripe'); }
  return _stripe;
};

// ── Detect which gateway to use ───────────────────────────
const detectGateway = (currency = 'INR', method = '') => {
  if (currency !== 'INR') return 'stripe';
  if (['card_international'].includes(method)) return 'stripe';
  return 'razorpay';
};

const PaymentService = {

  // ════════════════════════════════════════════════════════
  //  RAZORPAY
  // ════════════════════════════════════════════════════════

  /**
   * Step 1: Create a Razorpay order.
   * Call this from POST /api/payments/initiate.
   * Returns the razorpayOrderID + keyID — both needed by the frontend SDK.
   */
  async razorpay_createOrder({ amount, currency = 'INR', orderID, customerID, notes = {} }) {
    const rzp = getRazorpay();
    const rzpOrder = await rzp.orders.create({
      amount:   Math.round(amount * 100),       // in paise
      currency,
      receipt:  `rcpt_${orderID}_${Date.now()}`,
      notes:    { deemonaOrderID: String(orderID), customerID: String(customerID), ...notes },
      payment_capture: 1,                       // auto-capture on success
    });
    return {
      gateway:         'razorpay',
      gatewayOrderID:  rzpOrder.id,
      amount:          rzpOrder.amount / 100,   // back to rupees for display
      currency:        rzpOrder.currency,
      keyID:           process.env.RAZORPAY_KEY_ID,
      name:            process.env.BRAND_NAME || 'Deemona',
      description:     `Order #${orderID}`,
      prefill: {},     // caller fills email/contact from customer record
    };
  },

  /**
   * Step 2: Verify the payment signature.
   * This MUST happen server-side before confirming the order.
   * The signature = HMAC-SHA256(gatewayOrderID + "|" + gatewayPaymentID, key_secret)
   */
  razorpay_verifySignature({ gatewayOrderID, gatewayPaymentID, signature }) {
    const expected = crypto
      .createHmac('sha256', process.env.RAZORPAY_KEY_SECRET || '')
      .update(`${gatewayOrderID}|${gatewayPaymentID}`)
      .digest('hex');
    return crypto.timingSafeEqual(
      Buffer.from(expected),
      Buffer.from(signature)
    );
  },

  /**
   * Fetch full payment details from Razorpay (for audit).
   */
  async razorpay_fetchPayment(gatewayPaymentID) {
    return getRazorpay().payments.fetch(gatewayPaymentID);
  },

  /**
   * Fetch Razorpay order (check status before confirming).
   */
  async razorpay_fetchOrder(gatewayOrderID) {
    return getRazorpay().orders.fetch(gatewayOrderID);
  },

  /**
   * Manually capture an authorized payment (if auto-capture is off).
   */
  async razorpay_capturePayment(gatewayPaymentID, amount, currency = 'INR') {
    return getRazorpay().payments.capture(
      gatewayPaymentID,
      Math.round(amount * 100),
      currency
    );
  },

  /**
   * Initiate a refund. Returns the Razorpay refund object.
   * speed: 'normal' (3-5 days) | 'optimum' (same day, higher cost)
   */
  async razorpay_refund(gatewayPaymentID, amount, { reason = 'customer_request', speed = 'normal', notes = {} } = {}) {
    return getRazorpay().payments.refund(gatewayPaymentID, {
      amount:  Math.round(amount * 100),
      speed,
      notes:   { reason, ...notes },
    });
  },

  /**
   * Fetch refund details.
   */
  async razorpay_fetchRefund(gatewayPaymentID, refundID) {
    return getRazorpay().payments.fetchRefund(gatewayPaymentID, refundID);
  },

  /**
   * Create a payment link (share via WhatsApp/email/SMS).
   */
  async razorpay_createPaymentLink({ amount, currency = 'INR', orderID, customer, expiryMinutes = 60 }) {
    const rzp = getRazorpay();
    const expiresAt = Math.floor(Date.now() / 1000) + expiryMinutes * 60;
    const link = await rzp.paymentLink.create({
      amount:       Math.round(amount * 100),
      currency,
      accept_partial: false,
      expire_by:    expiresAt,
      reference_id: `order_${orderID}`,
      description:  `Payment for Order #${orderID}`,
      customer: {
        name:    customer.name,
        email:   customer.email,
        contact: customer.phone,
      },
      notify: { sms: !!customer.phone, email: !!customer.email },
      reminder_enable: true,
      notes:  { deemonaOrderID: String(orderID) },
      callback_url:    `${process.env.APP_URL}/payment/result`,
      callback_method: 'get',
    });
    return { gatewayLinkID: link.id, shortURL: link.short_url, expiresAt: new Date(expiresAt * 1000) };
  },

  // Verify webhook from Razorpay
  razorpay_verifyWebhook(rawBody, signature) {
    const expected = crypto
      .createHmac('sha256', process.env.RAZORPAY_WEBHOOK_SECRET || '')
      .update(rawBody)
      .digest('hex');
    try {
      return crypto.timingSafeEqual(Buffer.from(expected), Buffer.from(signature));
    } catch { return false; }
  },

  // ════════════════════════════════════════════════════════
  //  STRIPE
  // ════════════════════════════════════════════════════════

  /**
   * Create a Stripe PaymentIntent.
   */
  async stripe_createPaymentIntent({ amount, currency = 'inr', orderID, customerID, metadata = {} }) {
    const stripe = getStripe();
    const intent = await stripe.paymentIntents.create({
      amount:               Math.round(amount * 100),
      currency:             currency.toLowerCase(),
      automatic_payment_methods: { enabled: true },
      metadata:             { deemonaOrderID: String(orderID), customerID: String(customerID), ...metadata },
      description:          `Deemona Order #${orderID}`,
    });
    return {
      gateway:        'stripe',
      clientSecret:   intent.client_secret,    // sent to frontend
      paymentIntentID: intent.id,
      amount:         intent.amount / 100,
      currency:       intent.currency,
    };
  },

  /**
   * Retrieve a Stripe PaymentIntent (server-side status check).
   */
  async stripe_fetchPaymentIntent(paymentIntentID) {
    return getStripe().paymentIntents.retrieve(paymentIntentID);
  },

  /**
   * Initiate a Stripe refund.
   */
  async stripe_refund(paymentIntentID, amount, { reason = 'requested_by_customer' } = {}) {
    const stripe = getStripe();
    // Get the charge ID from the PaymentIntent
    const pi = await stripe.paymentIntents.retrieve(paymentIntentID);
    const chargeID = pi.latest_charge;
    return stripe.refunds.create({
      charge: chargeID,
      amount: amount ? Math.round(amount * 100) : undefined, // undefined = full refund
      reason,
    });
  },

  // Verify Stripe webhook
  stripe_verifyWebhook(rawBody, signature) {
    try {
      const stripe = getStripe();
      return stripe.webhooks.constructEvent(
        rawBody,
        signature,
        process.env.STRIPE_WEBHOOK_SECRET || ''
      );
    } catch (e) {
      throw new Error(`Stripe webhook verification failed: ${e.message}`);
    }
  },

  // ════════════════════════════════════════════════════════
  //  UTILITY
  // ════════════════════════════════════════════════════════

  detectGateway,

  /**
   * Calculate transaction fee by method (absorbed or passed on).
   * Returns fee amount in INR.
   */
  getTransactionFee(method, amount) {
    const rates = {
      upi:               0,
      cod:               29,       // flat ₹29 handling
      credit_card:       0.020,    // 2%
      debit_card:        0.009,    // 0.9%
      rupay_debit:       0,        // 0% per RBI
      net_banking:       0,
      wallet:            0,
      emi:               0,        // EMI cost borne by bank
    };
    const rate = rates[method] ?? 0;
    const fee  = rate < 1 ? Math.round(amount * rate) : rate;
    const gst  = Math.round(fee * 0.18);  // 18% GST on payment processing fees
    return { fee, gst, total: fee + gst };
  },
};

module.exports = PaymentService;
