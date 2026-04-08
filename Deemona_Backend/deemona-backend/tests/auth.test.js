// tests/auth.test.js  — Authentication Tests
'use strict';
const request  = require('supertest');
const app      = require('../server');
const { getPool, sql } = require('../config/db');

// ── Test state ─────────────────────────────────────────────
let accessToken, refreshToken, customerID;
const testEmail = `test.${Date.now()}@deemona.test`;
const testPass  = 'TestPass123!';

// ── Setup / teardown ───────────────────────────────────────
afterAll(async () => {
  // Clean up test customer
  if (customerID) {
    const db = await getPool();
    await db.request().input('I', sql.Int, customerID)
      .query("UPDATE Customers SET AccountStatus='deleted' WHERE CustomerID=@I");
  }
});

// ══════════════════════════════════════════════════════════
describe('POST /api/auth/register', () => {

  it('registers a new customer and returns tokens', async () => {
    const res = await request(app).post('/api/auth/register').send({
      firstName: 'Test', lastName: 'User', email: testEmail, password: testPass,
    });
    expect(res.status).toBe(201);
    expect(res.body.success).toBe(true);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).toBeDefined();
    expect(res.body.data.customer.Email).toBe(testEmail);
    accessToken  = res.body.data.accessToken;
    refreshToken = res.body.data.refreshToken;
    customerID   = res.body.data.customer.CustomerID;
  });

  it('rejects duplicate email with 409', async () => {
    const res = await request(app).post('/api/auth/register').send({
      firstName:'A', lastName:'B', email: testEmail, password: testPass,
    });
    expect(res.status).toBe(409);
  });

  it('rejects weak password', async () => {
    const res = await request(app).post('/api/auth/register').send({
      firstName:'A', lastName:'B', email:'new@test.com', password:'short',
    });
    expect(res.status).toBe(422);
  });

  it('rejects invalid email format', async () => {
    const res = await request(app).post('/api/auth/register').send({
      firstName:'A', lastName:'B', email:'not-an-email', password:testPass,
    });
    expect(res.status).toBe(422);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/auth/login', () => {

  it('logs in with correct credentials', async () => {
    const res = await request(app).post('/api/auth/login').send({ email: testEmail, password: testPass });
    expect(res.status).toBe(200);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).toBeDefined();
    accessToken  = res.body.data.accessToken;
    refreshToken = res.body.data.refreshToken;
  });

  it('rejects wrong password', async () => {
    const res = await request(app).post('/api/auth/login').send({ email: testEmail, password: 'WrongPass99!' });
    expect(res.status).toBe(401);
  });

  it('rejects non-existent user', async () => {
    const res = await request(app).post('/api/auth/login').send({ email: 'nobody@test.com', password: testPass });
    expect(res.status).toBe(401);
  });

  it('rejects missing fields', async () => {
    const res = await request(app).post('/api/auth/login').send({ email: testEmail });
    expect(res.status).toBe(422);
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/auth/me', () => {

  it('returns current user with valid token', async () => {
    const res = await request(app).get('/api/auth/me').set('Authorization', `Bearer ${accessToken}`);
    expect(res.status).toBe(200);
    expect(res.body.data.Email).toBe(testEmail);
    expect(res.body.data.PasswordHash).toBeUndefined(); // never exposed
  });

  it('rejects request without token', async () => {
    const res = await request(app).get('/api/auth/me');
    expect(res.status).toBe(401);
  });

  it('rejects malformed token', async () => {
    const res = await request(app).get('/api/auth/me').set('Authorization', 'Bearer bad-token-here');
    expect(res.status).toBe(401);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/auth/token/refresh', () => {

  it('returns new tokens with valid refresh token', async () => {
    const res = await request(app).post('/api/auth/token/refresh').send({ refreshToken });
    expect(res.status).toBe(200);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).toBeDefined();
    // Refresh token should rotate (be different)
    expect(res.body.data.refreshToken).not.toBe(refreshToken);
    accessToken  = res.body.data.accessToken;
    refreshToken = res.body.data.refreshToken;
  });

  it('rejects used refresh token (rotation)', async () => {
    const first = refreshToken;
    await request(app).post('/api/auth/token/refresh').send({ refreshToken: first });
    // Try to use the same token again
    const res = await request(app).post('/api/auth/token/refresh').send({ refreshToken: first });
    expect(res.status).toBe(401);
  });

  it('rejects invalid refresh token', async () => {
    const res = await request(app).post('/api/auth/token/refresh').send({ refreshToken: 'fakefakefake' });
    expect(res.status).toBe(401);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/auth/logout', () => {

  it('logs out and invalidates token', async () => {
    const logoutRes = await request(app).post('/api/auth/logout')
      .set('Authorization', `Bearer ${accessToken}`)
      .send({ refreshToken });
    expect(logoutRes.status).toBe(200);

    // Token should now be rejected
    const meRes = await request(app).get('/api/auth/me').set('Authorization', `Bearer ${accessToken}`);
    expect(meRes.status).toBe(401);
  });
});
