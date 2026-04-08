// tests/products.test.js  — Product & Catalogue Tests
'use strict';
const request = require('supertest');
const app     = require('../server');

let adminToken, customerToken, createdProductID;

beforeAll(async () => {
  // Get customer token
  const cr = await request(app).post('/api/auth/login').send({
    email: process.env.TEST_CUSTOMER_EMAIL || 'test@deemona.test',
    password: process.env.TEST_CUSTOMER_PASS || 'TestPass123!',
  });
  customerToken = cr.body.data?.accessToken;

  // Get admin token
  const ar = await request(app).post('/api/auth/admin/login').send({
    email:    process.env.TEST_ADMIN_EMAIL || 'admin@deemona.com',
    password: process.env.TEST_ADMIN_PASS  || 'AdminPass123!',
  });
  adminToken = ar.body.data?.accessToken;
});

afterAll(async () => {
  if (createdProductID) {
    await request(app).delete(`/api/products/${createdProductID}`)
      .set('Authorization', `Bearer ${adminToken}`);
  }
});

// ══════════════════════════════════════════════════════════
describe('GET /api/products', () => {

  it('returns paginated products list publicly', async () => {
    const res = await request(app).get('/api/products');
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data.products)).toBe(true);
    expect(res.body.data.pagination).toBeDefined();
    expect(res.body.data.pagination.total).toBeGreaterThanOrEqual(0);
  });

  it('filters by category', async () => {
    const res = await request(app).get('/api/products?category=Electronics');
    expect(res.status).toBe(200);
    res.body.data.products.forEach(p => {
      expect(p.CategoryName).toBe('Electronics');
    });
  });

  it('filters by price range', async () => {
    const res = await request(app).get('/api/products?minPrice=100&maxPrice=1000');
    expect(res.status).toBe(200);
    res.body.data.products.forEach(p => {
      expect(p.Price).toBeGreaterThanOrEqual(100);
      expect(p.Price).toBeLessThanOrEqual(1000);
    });
  });

  it('searches by name', async () => {
    const res = await request(app).get('/api/products?search=wireless');
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data.products)).toBe(true);
  });

  it('returns featured products only', async () => {
    const res = await request(app).get('/api/products?featured=true');
    expect(res.status).toBe(200);
    res.body.data.products.forEach(p => expect(p.IsFeatured).toBe(true));
  });

  it('respects pagination', async () => {
    const res = await request(app).get('/api/products?page=1&limit=5');
    expect(res.status).toBe(200);
    expect(res.body.data.products.length).toBeLessThanOrEqual(5);
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/products/:id', () => {

  it('returns product detail with related products', async () => {
    const listRes = await request(app).get('/api/products?limit=1');
    const firstID = listRes.body.data.products[0]?.ProductID;
    if (!firstID) return;

    const res = await request(app).get(`/api/products/${firstID}`);
    expect(res.status).toBe(200);
    expect(res.body.data.ProductID).toBe(firstID);
    expect(Array.isArray(res.body.data.related)).toBe(true);
    expect(res.body.data.StockStatus).toMatch(/in_stock|low_stock|out_of_stock/);
    expect(res.body.data.DiscountPct).toBeGreaterThanOrEqual(0);
  });

  it('returns 404 for non-existent product', async () => {
    const res = await request(app).get('/api/products/999999999');
    expect(res.status).toBe(404);
  });

  it('returns 422 for non-integer ID', async () => {
    const res = await request(app).get('/api/products/abc');
    expect(res.status).toBe(422);
  });
});

// ══════════════════════════════════════════════════════════
describe('POST /api/products (admin)', () => {

  it('requires admin token', async () => {
    const res = await request(app).post('/api/products')
      .set('Authorization', `Bearer ${customerToken}`)
      .send({ name:'Test', sku:'TST-001', price:99 });
    expect(res.status).toBe(403);
  });

  it('creates a product with admin token', async () => {
    if (!adminToken) return;
    const res = await request(app).post('/api/products')
      .set('Authorization', `Bearer ${adminToken}`)
      .send({
        name: 'Test Product ' + Date.now(),
        sku:  'TST-' + Date.now(),
        price: 299, mrp: 399,
        stockQuantity: 50, reorderLevel: 10,
        brand: 'TestBrand', categoryID: 1,
      });
    expect(res.status).toBe(201);
    expect(res.body.data.productID).toBeDefined();
    createdProductID = res.body.data.productID;
  });

  it('rejects missing required fields', async () => {
    if (!adminToken) return;
    const res = await request(app).post('/api/products')
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ name: 'No SKU No Price' });
    expect(res.status).toBe(422);
  });

  it('rejects duplicate SKU', async () => {
    if (!adminToken || !createdProductID) return;
    // Get the SKU we just created
    const detail = await request(app).get(`/api/products/${createdProductID}`);
    const sku = detail.body.data.SKU;
    const res = await request(app).post('/api/products')
      .set('Authorization', `Bearer ${adminToken}`)
      .send({ name:'Dup', sku, price:100 });
    expect(res.status).toBe(409);
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/categories', () => {

  it('returns category list publicly', async () => {
    const res = await request(app).get('/api/categories');
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data)).toBe(true);
  });
});

// ══════════════════════════════════════════════════════════
describe('GET /api/search', () => {

  it('returns search results', async () => {
    const res = await request(app).get('/api/search?q=phone');
    expect(res.status).toBe(200);
    expect(res.body.data.products).toBeDefined();
    expect(res.body.data.categories).toBeDefined();
  });

  it('rejects queries shorter than 2 chars', async () => {
    const res = await request(app).get('/api/search?q=a');
    expect(res.status).toBe(422);
  });

  it('autocomplete returns fast suggestions', async () => {
    const res = await request(app).get('/api/search/autocomplete?q=ph');
    expect(res.status).toBe(200);
    expect(Array.isArray(res.body.data)).toBe(true);
  });
});
