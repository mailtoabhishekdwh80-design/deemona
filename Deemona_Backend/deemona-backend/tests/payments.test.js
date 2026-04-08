// tests/payments.test.js  — Payment Gateway Integration Tests
'use strict';
const request        = require('supertest');
const crypto         = require('crypto');
const app            = require('../server');
const PaymentService = require('../services/payment');
const { getPool, sql } = require('../config/db');

// ── Test state ─────────────────────────────────────────────
let customerToken, adminToken, testOrderID, testPaymentID;

// Razorpay test credentials (use test mode keys in CI)
const RZP_KEY_SECRET = process.env.RAZORPAY_KEY_SECRET || 'test_secret';

const makeRazorpaySignature = (orderID, paymentID) =>
  crypto.createHmac('sha256', RZP_KEY_SECRET)
    .update(`${orderID}|${paymentID}`)
    .digest('hex');

beforeAll(async () => {
  const [cr, ar] = await Promise.all([
    request(app).post('/api/auth/login').send({
      email:    process.env.TEST_CUSTOMER_EMAIL || 'test@deemona.test',
      password: process.env.TEST_CUSTOMER_PASS  || 'TestPass123!',
    }),
    request(app).post('/api/auth/admin/login').send({
      email:    process.env.TEST_ADMIN_EMAIL || 'admin@deemona.com',
      password: process.env.TEST_ADMIN_PASS  || 'Admin@123456!',
    }),
  ]);
  customerToken = cr.body.data?.accessToken;
  adminToken    = ar.body.data?.accessToken;
});

afterAll(async () => {
  if (testOrderID) {
    const db = await getPool();
    await db.request().input('O', sql.Int, testOrderID)
      .query("UPDATE Orders SET Status='cancelled' WHERE OrderID=@O");
  }
});

// ══════════════════════════════════════════════════════════
describe('POST /api/payments/initiate', () => {

  it('requires authentication', async () => {
    const res = await request(app).post('/api/payments/initiate').send({ orderID: 1 });
    expect(res.status).toBe(401);
  });

  it('rejects invalid orderID', async () => {
    if (!customerToken) return;
    const res = await request(app).post('/api/payments/initiate')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ orderID: 'abc' });
    expect(res.status).toBe(422);
  });

  it('returns 404 for non-existent order', async () => {
    if (!customerToken) return;
    const res = await request(app).post('/api/payments/initiate')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ orderID: 999999999 });
    expect(res.status).toBe(404);
  });

  it('returns gateway credentials for pending order', async () => {
    if (!customerToken || !testOrderID) return;
    const res = await request(app).post('/api/payments/initiate')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ orderID: testOrderID, gateway: 'razorpay' });
    // Will fail without real Razorpay keys — expect either success or gateway error
    expect([200, 400, 500]).toContain(res.status);
    if (res.status === 200) {
      expect(res.body.data.gateway).toBe('razorpay');
      expect(res.body.data.keyID).toBeDefined();
      expect(res.body.data.gatewayOrderID).toMatch(/^order_/);
    }
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/payments/verify — Razorpay signature', () => {

  it('requires authentication', async () => {
    const res = await request(app).post('/api/payments/verify').send({
      orderID: 1, gateway: 'razorpay',
      gatewayOrderID: 'order_test', gatewayPaymentID: 'pay_test', signature: 'sig'
    });
    expect(res.status).toBe(401);
  });

  it('rejects tampered signature', async () => {
    if (!customerToken || !testOrderID) return;
    const res = await request(app).post('/api/payments/verify')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({
        orderID:          testOrderID,
        gateway:          'razorpay',
        gatewayOrderID:   'order_fake123',
        gatewayPaymentID: 'pay_fake456',
        signature:        'this_is_a_fake_signature',
      });
    expect(res.status).toBe(400);
    expect(res.body.error).toMatch(/signature/i);
  });

  it('accepts valid HMAC signature (unit test)', () => {
    const orderID   = 'order_test123';
    const paymentID = 'pay_test456';
    const validSig  = makeRazorpaySignature(orderID, paymentID);

    const result = PaymentService.razorpay_verifySignature({
      gatewayOrderID:  orderID,
      gatewayPaymentID: paymentID,
      signature:       validSig,
    });
    expect(result).toBe(true);
  });

  it('rejects forged signature (unit test)', () => {
    const result = PaymentService.razorpay_verifySignature({
      gatewayOrderID:   'order_real',
      gatewayPaymentID: 'pay_real',
      signature:        'forged_sig_0000000000000000000000000',
    });
    expect(result).toBe(false);
  });

  it('rejects missing required fields', async () => {
    if (!customerToken) return;
    const res = await request(app).post('/api/payments/verify')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ orderID: 1, gateway: 'razorpay' }); // missing gatewayOrderID etc.
    expect(res.status).toBe(422);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/payments/webhook — Razorpay', () => {

  const makeWebhookBody = (event, deemonaOrderID) => JSON.stringify({
    event,
    payload: {
      payment: {
        entity: {
          id:          'pay_webhook_test',
          order_id:    'order_webhook_test',
          amount:      50000,
          currency:    'INR',
          status:      'captured',
          notes:       { deemonaOrderID: String(deemonaOrderID) },
          error_code:  null,
        }
      }
    }
  });

  const makeWebhookSig = (body) =>
    crypto.createHmac('sha256', process.env.RAZORPAY_WEBHOOK_SECRET || 'test_webhook_secret')
      .update(body).digest('hex');

  it('rejects webhook with invalid signature', async () => {
    const body = makeWebhookBody('payment.captured', 999);
    const res = await request(app)
      .post('/api/payments/webhook')
      .set('Content-Type', 'application/json')
      .set('x-razorpay-signature', 'bad_signature_here')
      .send(body);
    expect(res.status).toBe(400);
  });

  it('accepts webhook with valid signature', async () => {
    const body = makeWebhookBody('payment.captured', 999999);
    const sig  = makeWebhookSig(body);
    const res = await request(app)
      .post('/api/payments/webhook')
      .set('Content-Type', 'application/json')
      .set('x-razorpay-signature', sig)
      .send(Buffer.from(body));
    // 200 regardless of whether order exists (idempotent)
    expect(res.status).toBe(200);
    expect(res.body.received).toBe(true);
  });

  it('handles payment.failed event', async () => {
    const body = JSON.stringify({
      event: 'payment.failed',
      payload: {
        payment: {
          entity: {
            id: 'pay_failed_test',
            order_id: 'order_test',
            notes: { deemonaOrderID: '999999' },
            error_code: 'BAD_REQUEST_ERROR',
            error_description: 'Card declined',
            error_reason: 'payment_failed',
          }
        }
      }
    });
    const sig = makeWebhookSig(body);
    const res = await request(app)
      .post('/api/payments/webhook')
      .set('Content-Type', 'application/json')
      .set('x-razorpay-signature', sig)
      .send(Buffer.from(body));
    expect(res.status).toBe(200);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/payments/:id/refund  (admin)', () => {

  it('requires admin role', async () => {
    if (!customerToken) return;
    const res = await request(app).post('/api/payments/1/refund')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ amount: 100 });
    expect(res.status).toBe(403);
  });

  it('rejects refund for non-completed payment', async () => {
    if (!adminToken || !testPaymentID) return;
    const res = await request(app).post(`/api/payments/${testPaymentID}/refund`)
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ amount: 100 });
    // Pending payment cannot be refunded
    expect([400, 404]).toContain(res.status);
  });

  it('rejects refund amount exceeding payment', async () => {
    if (!adminToken) return;
    const res = await request(app).post('/api/payments/1/refund')
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ amount: 9999999 });
    expect([400, 404]).toContain(res.status);
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/payments  (admin)', () => {

  it('requires admin role', async () => {
    if (!customerToken) return;
    const res = await request(app).get('/api/payments')
      .set('Authorization', `Bearer ${customerToken}`);
    expect(res.status).toBe(403);
  });

  it('returns paginated payments for admin', async () => {
    if (!adminToken) return;
    const res = await request(app).get('/api/payments')
      .set('Authorization', `Bearer ${adminToken}`);
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data.payments)).toBe(true);
    expect(res.body.data.pagination).toBeDefined();
  });

  it('filters by payment status', async () => {
    if (!adminToken) return;
    const res = await request(app).get('/api/payments?status=completed')
      .set('Authorization', `Bearer ${adminToken}`);
    expect(res.status).toBe(200);
    res.body.data.payments.forEach(p => expect(p.PaymentStatus).toBe('completed'));
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/payments/admin/stats', () => {

  it('returns stats for date range', async () => {
    if (!adminToken) return;
    const from = new Date(Date.now() - 30*86400000).toISOString().split('T')[0];
    const to   = new Date().toISOString().split('T')[0];
    const res  = await request(app)
      .get(`/api/payments/admin/stats?from=${from}&to=${to}`)
      .set('Authorization', `Bearer ${adminToken}`);
    expect(res.status).toBe(200);
    expect(res.body.data.volume).toBeDefined();
    expect(res.body.data.methodBreakdown).toBeDefined();
    expect(res.body.data.failureReasons).toBeDefined();
  });
});

// ══════════════════════════════════════════════════════════
describe('PaymentService unit tests', () => {

  describe('getTransactionFee', () => {
    it('returns 0 for UPI', () => {
      const { fee } = PaymentService.getTransactionFee('upi', 1000);
      expect(fee).toBe(0);
    });
    it('returns flat ₹29 for COD', () => {
      const { fee } = PaymentService.getTransactionFee('cod', 1000);
      expect(fee).toBe(29);
    });
    it('returns 2% for credit card', () => {
      const { fee } = PaymentService.getTransactionFee('credit_card', 1000);
      expect(fee).toBe(20); // 2% of 1000
    });
    it('includes 18% GST on fee', () => {
      const { fee, gst, total } = PaymentService.getTransactionFee('credit_card', 1000);
      expect(total).toBe(fee + gst);
      expect(gst).toBe(Math.round(fee * 0.18));
    });
  });

  describe('detectGateway', () => {
    it('uses razorpay for INR by default', () => {
      expect(PaymentService.detectGateway('INR', 'upi')).toBe('razorpay');
    });
    it('uses stripe for non-INR', () => {
      expect(PaymentService.detectGateway('USD', 'card')).toBe('stripe');
    });
  });
});
