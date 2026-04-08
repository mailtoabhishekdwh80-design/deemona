// routes/inventory.js — Complete Inventory Management System for Deemona
// Endpoints: Stock tracking, GRN, Purchase Orders, Suppliers, Adjustments, Reports
'use strict';
const router  = require('express').Router();
const { body, param, query } = require('express-validator');
const pool    = require('../config/db');
const {
  ok, fail, wrap, paginate, validate,
  authenticate, adminOnly, toInt
} = require('../middleware');

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 1 — STOCK OVERVIEW & ALERTS
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory
// List all products with stock status, filterable by category, status, search
router.get('/', authenticate, adminOnly, wrap(async (req, res) => {
  const { page, limit, offset } = paginate(req.query);
  const { search, category, status, supplier, sort = 'stock_asc' } = req.query;

  const where  = ['p.IsActive=1'];
  const params = [];

  if (search) {
    where.push('(p.Name LIKE ? OR p.SKU LIKE ? OR p.Brand LIKE ?)');
    const q = `%${search}%`;
    params.push(q, q, q);
  }
  if (category) { where.push('c.CategoryName=?'); params.push(category); }
  if (supplier) { where.push('p.SupplierID=?');   params.push(toInt(supplier)); }
  if (status === 'out_of_stock')  { where.push('p.StockQuantity=0'); }
  if (status === 'low_stock')     { where.push('p.StockQuantity>0 AND p.StockQuantity<=p.ReorderLevel'); }
  if (status === 'in_stock')      { where.push('p.StockQuantity>p.ReorderLevel'); }
  if (status === 'overstock')     { where.push('p.StockQuantity>p.ReorderLevel*5'); }

  const sortMap = {
    stock_asc:   'p.StockQuantity ASC',
    stock_desc:  'p.StockQuantity DESC',
    name:        'p.Name ASC',
    sku:         'p.SKU ASC',
    value_desc:  '(p.StockQuantity * p.CostPrice) DESC',
    updated:     'p.UpdatedAt DESC',
  };
  const orderBy = sortMap[sort] || 'p.StockQuantity ASC';

  const [[countRow]] = await pool.execute(
    `SELECT COUNT(*) AS total FROM Products p
     LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE ${where.join(' AND ')}`, params
  );

  const [rows] = await pool.execute(
    `SELECT
       p.ProductID, p.Name, p.SKU, p.Brand,
       c.CategoryName,
       s.CompanyName AS SupplierName,
       p.StockQuantity, p.ReorderLevel, p.ReservedQty,
       (p.StockQuantity - IFNULL(p.ReservedQty,0)) AS AvailableQty,
       p.CostPrice, p.Price,
       (p.StockQuantity * p.CostPrice) AS StockValue,
       p.Weight, p.UpdatedAt,
       CASE
         WHEN p.StockQuantity = 0                              THEN 'out_of_stock'
         WHEN p.StockQuantity <= p.ReorderLevel                THEN 'low_stock'
         WHEN p.StockQuantity > p.ReorderLevel * 5             THEN 'overstock'
         ELSE 'in_stock'
       END AS StockStatus
     FROM Products p
     LEFT JOIN Categories c  ON c.CategoryID  = p.CategoryID
     LEFT JOIN Suppliers   s  ON s.SupplierID  = p.SupplierID
     WHERE ${where.join(' AND ')}
     ORDER BY ${orderBy}
     LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );

  ok(res, {
    inventory: rows,
    pagination: { total: countRow.total, page, limit, pages: Math.ceil(countRow.total / limit) },
  });
}));

// GET /api/inventory/summary
// Dashboard summary: counts by status, total stock value, alerts
router.get('/summary', authenticate, adminOnly, wrap(async (req, res) => {
  const [[summary]] = await pool.execute(`
    SELECT
      COUNT(*)                                                   AS totalSKUs,
      SUM(StockQuantity)                                         AS totalUnits,
      SUM(StockQuantity * IFNULL(CostPrice,0))                   AS totalStockValue,
      SUM(CASE WHEN StockQuantity = 0 THEN 1 ELSE 0 END)        AS outOfStock,
      SUM(CASE WHEN StockQuantity > 0
               AND StockQuantity <= ReorderLevel THEN 1 ELSE 0 END) AS lowStock,
      SUM(CASE WHEN StockQuantity > ReorderLevel THEN 1 ELSE 0 END) AS inStock,
      SUM(CASE WHEN StockQuantity > ReorderLevel*5 THEN 1 ELSE 0 END) AS overstock
    FROM Products WHERE IsActive=1
  `);

  const [topValue] = await pool.execute(`
    SELECT p.Name, p.SKU, p.StockQuantity,
           (p.StockQuantity * p.CostPrice) AS StockValue,
           c.CategoryName
    FROM Products p
    LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
    WHERE p.IsActive=1 AND p.CostPrice > 0
    ORDER BY StockValue DESC LIMIT 5
  `);

  const [recentAdjustments] = await pool.execute(`
    SELECT sa.*, p.Name AS ProductName, p.SKU
    FROM StockAdjustments sa
    JOIN Products p ON p.ProductID=sa.ProductID
    ORDER BY sa.AdjustedAt DESC LIMIT 10
  `);

  ok(res, { summary, topValue, recentAdjustments });
}));

// GET /api/inventory/alerts
// Products that need immediate attention
router.get('/alerts', authenticate, adminOnly, wrap(async (req, res) => {
  const [rows] = await pool.execute(`
    SELECT
      p.ProductID, p.Name, p.SKU, p.Brand,
      c.CategoryName,
      s.CompanyName AS SupplierName,
      s.ContactEmail AS SupplierEmail,
      p.StockQuantity, p.ReorderLevel,
      CASE
        WHEN p.StockQuantity = 0          THEN 'out_of_stock'
        WHEN p.StockQuantity <= p.ReorderLevel THEN 'low_stock'
      END AS AlertType,
      (p.ReorderLevel * 2 - p.StockQuantity) AS SuggestedOrderQty,
      p.CostPrice,
      (p.ReorderLevel * 2 - p.StockQuantity) * p.CostPrice AS EstimatedCost
    FROM Products p
    LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
    LEFT JOIN Suppliers   s ON s.SupplierID=p.SupplierID
    WHERE p.IsActive=1 AND p.StockQuantity <= p.ReorderLevel
    ORDER BY p.StockQuantity ASC
  `);
  ok(res, rows);
}));

// GET /api/inventory/valuation
// Stock valuation report by category
router.get('/valuation', authenticate, adminOnly, wrap(async (req, res) => {
  const [byCategory] = await pool.execute(`
    SELECT
      c.CategoryName,
      COUNT(p.ProductID)               AS ProductCount,
      SUM(p.StockQuantity)             AS TotalUnits,
      SUM(p.StockQuantity * p.CostPrice)  AS CostValue,
      SUM(p.StockQuantity * p.Price)      AS RetailValue,
      SUM(p.StockQuantity * (p.Price - p.CostPrice)) AS PotentialProfit
    FROM Products p
    LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
    WHERE p.IsActive=1
    GROUP BY c.CategoryID, c.CategoryName
    ORDER BY CostValue DESC
  `);

  const [[totals]] = await pool.execute(`
    SELECT
      SUM(StockQuantity * CostPrice)  AS TotalCostValue,
      SUM(StockQuantity * Price)      AS TotalRetailValue,
      SUM(StockQuantity * (Price - CostPrice)) AS TotalPotentialProfit,
      SUM(StockQuantity)              AS TotalUnits
    FROM Products WHERE IsActive=1
  `);

  ok(res, { byCategory, totals });
}));

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 2 — INDIVIDUAL PRODUCT INVENTORY
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/:id
// Full inventory detail for one product including adjustment history
router.get('/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req, res) => {
    const id = toInt(req.params.id);

    const [rows] = await pool.execute(`
      SELECT p.*, c.CategoryName, s.CompanyName AS SupplierName,
             s.ContactEmail AS SupplierEmail, s.City AS SupplierCity,
             (p.StockQuantity * p.CostPrice)  AS StockCostValue,
             (p.StockQuantity * p.Price)      AS StockRetailValue,
             (p.StockQuantity - IFNULL(p.ReservedQty,0)) AS AvailableQty,
             CASE
               WHEN p.StockQuantity = 0                    THEN 'out_of_stock'
               WHEN p.StockQuantity <= p.ReorderLevel      THEN 'low_stock'
               WHEN p.StockQuantity > p.ReorderLevel * 5   THEN 'overstock'
               ELSE 'in_stock'
             END AS StockStatus
      FROM Products p
      LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
      LEFT JOIN Suppliers   s ON s.SupplierID=p.SupplierID
      WHERE p.ProductID=? AND p.IsActive=1
    `, [id]);

    if (!rows.length) return fail(res, 'Product not found', 404);

    const [history] = await pool.execute(`
      SELECT sa.*, au.Email AS AdjustedByEmail
      FROM StockAdjustments sa
      LEFT JOIN AdminUsers au ON au.AdminID=sa.AdjustedBy
      WHERE sa.ProductID=?
      ORDER BY sa.AdjustedAt DESC LIMIT 50
    `, [id]);

    ok(res, { ...rows[0], adjustmentHistory: history });
  })
);

// PATCH /api/inventory/:id/stock
// Adjust stock (add, remove, set, reserve, unreserve)
router.patch('/:id/stock', authenticate, adminOnly,
  [param('id').isInt(),
   body('action').isIn(['add','remove','set','reserve','unreserve']),
   body('quantity').isInt({ min: 0 }),
   body('reason').optional().isString()],
  validate,
  wrap(async (req, res) => {
    const id  = toInt(req.params.id);
    const { action, quantity, reason, reference } = req.body;
    const qty = parseInt(quantity);

    const [old] = await pool.execute(
      'SELECT StockQuantity, ReservedQty, Name FROM Products WHERE ProductID=? AND IsActive=1', [id]
    );
    if (!old.length) return fail(res, 'Product not found', 404);

    const { StockQuantity: oldStock, ReservedQty: oldReserved } = old[0];

    let newStock    = oldStock;
    let newReserved = oldReserved || 0;
    let adjustmentType = action;

    switch (action) {
      case 'add':       newStock    = oldStock + qty;    break;
      case 'remove':    newStock    = oldStock - qty;    break;
      case 'set':       newStock    = qty;               break;
      case 'reserve':   newReserved = newReserved + qty; break;
      case 'unreserve': newReserved = Math.max(0, newReserved - qty); break;
    }

    if (newStock < 0) return fail(res, 'Stock cannot go below 0', 400);
    if (newReserved > newStock) return fail(res, 'Reserved qty cannot exceed stock', 400);

    await pool.execute(
      'UPDATE Products SET StockQuantity=?, ReservedQty=?, UpdatedAt=NOW() WHERE ProductID=?',
      [newStock, newReserved, id]
    );

    if (['add','remove','set'].includes(action)) {
      await pool.execute(
        `INSERT INTO StockAdjustments
           (ProductID, OldQuantity, NewQuantity, Reason, Reference, AdjustedBy)
         VALUES (?,?,?,?,?,?)`,
        [id, oldStock, newStock, reason || action, reference || null, req.user.id]
      );
    }

    ok(res, {
      productID:    id,
      productName:  old[0].Name,
      oldStock,     newStock,
      oldReserved,  newReserved,
      available:    newStock - newReserved,
      action, qty,
      message: 'Stock updated successfully',
    });
  })
);

// POST /api/inventory/bulk-adjust
// Adjust stock for multiple products at once (e.g., after stock take)
router.post('/bulk-adjust', authenticate, adminOnly,
  [body('adjustments').isArray({ min: 1 })],
  validate,
  wrap(async (req, res) => {
    const { adjustments, reason = 'Bulk stock adjustment' } = req.body;
    const conn = await pool.getConnection();
    const results = { success: [], failed: [] };

    try {
      await conn.beginTransaction();

      for (const adj of adjustments) {
        const { productID, newQuantity, reason: itemReason } = adj;
        const id  = toInt(productID);
        const qty = parseInt(newQuantity);

        if (isNaN(qty) || qty < 0) {
          results.failed.push({ productID, error: 'Invalid quantity' });
          continue;
        }

        const [[old]] = await conn.execute(
          'SELECT StockQuantity, Name FROM Products WHERE ProductID=? AND IsActive=1', [id]
        );
        if (!old) { results.failed.push({ productID, error: 'Not found' }); continue; }

        await conn.execute(
          'UPDATE Products SET StockQuantity=?, UpdatedAt=NOW() WHERE ProductID=?', [qty, id]
        );
        await conn.execute(
          `INSERT INTO StockAdjustments (ProductID,OldQuantity,NewQuantity,Reason,AdjustedBy)
           VALUES (?,?,?,?,?)`,
          [id, old.StockQuantity, qty, itemReason || reason, req.user.id]
        );

        results.success.push({ productID, productName: old.Name, oldQty: old.StockQuantity, newQty: qty });
      }

      await conn.commit();
      ok(res, { ...results, total: adjustments.length, successCount: results.success.length, failedCount: results.failed.length });
    } catch (e) {
      await conn.rollback();
      throw e;
    } finally {
      conn.release();
    }
  })
);

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 3 — SUPPLIERS
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/suppliers/all
router.get('/suppliers/all', authenticate, adminOnly, wrap(async (req, res) => {
  const { search } = req.query;
  const where  = ['s.IsActive=1'];
  const params = [];

  if (search) {
    where.push('(s.CompanyName LIKE ? OR s.ContactEmail LIKE ? OR s.City LIKE ?)');
    const q = `%${search}%`;
    params.push(q, q, q);
  }

  const [rows] = await pool.execute(`
    SELECT s.*,
           COUNT(p.ProductID)                         AS ProductCount,
           SUM(p.StockQuantity)                       AS TotalStock,
           SUM(p.StockQuantity * p.CostPrice)         AS TotalStockValue
    FROM Suppliers s
    LEFT JOIN Products p ON p.SupplierID=s.SupplierID AND p.IsActive=1
    WHERE ${where.join(' AND ')}
    GROUP BY s.SupplierID
    ORDER BY s.CompanyName
  `, params);

  ok(res, rows);
}));

// GET /api/inventory/suppliers/:id
router.get('/suppliers/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req, res) => {
    const [[supplier]] = await pool.execute(
      'SELECT * FROM Suppliers WHERE SupplierID=? AND IsActive=1', [toInt(req.params.id)]
    );
    if (!supplier) return fail(res, 'Supplier not found', 404);

    const [products] = await pool.execute(`
      SELECT ProductID, Name, SKU, StockQuantity, ReorderLevel, CostPrice, Price
      FROM Products WHERE SupplierID=? AND IsActive=1 ORDER BY Name
    `, [toInt(req.params.id)]);

    ok(res, { ...supplier, products });
  })
);

// POST /api/inventory/suppliers
router.post('/suppliers', authenticate, adminOnly,
  [body('companyName').notEmpty().trim()],
  validate,
  wrap(async (req, res) => {
    const {
      companyName, contactName, contactEmail, contactPhone,
      address, city, state, country = 'India',
      gstNumber, paymentTerms, leadTimeDays, notes,
    } = req.body;

    const [result] = await pool.execute(`
      INSERT INTO Suppliers
        (CompanyName, ContactName, ContactEmail, ContactPhone,
         Address, City, State, Country, GSTNumber,
         PaymentTerms, LeadTimeDays, Notes, IsActive)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,1)
    `, [companyName, contactName||null, contactEmail||null, contactPhone||null,
        address||null, city||null, state||null, country, gstNumber||null,
        paymentTerms||null, leadTimeDays||null, notes||null]);

    ok(res, { supplierID: result.insertId, message: 'Supplier created' }, 201);
  })
);

// PUT /api/inventory/suppliers/:id
router.put('/suppliers/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req, res) => {
    const {
      companyName, contactName, contactEmail, contactPhone,
      address, city, state, country, gstNumber,
      paymentTerms, leadTimeDays, notes, isActive,
    } = req.body;

    await pool.execute(`
      UPDATE Suppliers SET
        CompanyName   = IFNULL(?,CompanyName),
        ContactName   = IFNULL(?,ContactName),
        ContactEmail  = IFNULL(?,ContactEmail),
        ContactPhone  = IFNULL(?,ContactPhone),
        Address       = IFNULL(?,Address),
        City          = IFNULL(?,City),
        State         = IFNULL(?,State),
        Country       = IFNULL(?,Country),
        GSTNumber     = IFNULL(?,GSTNumber),
        PaymentTerms  = IFNULL(?,PaymentTerms),
        LeadTimeDays  = IFNULL(?,LeadTimeDays),
        Notes         = IFNULL(?,Notes),
        IsActive      = IFNULL(?,IsActive)
      WHERE SupplierID=?
    `, [companyName||null, contactName||null, contactEmail||null, contactPhone||null,
        address||null, city||null, state||null, country||null, gstNumber||null,
        paymentTerms||null, leadTimeDays||null, notes||null,
        isActive!=null?isActive:null, toInt(req.params.id)]);

    ok(res, { message: 'Supplier updated' });
  })
);

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 4 — PURCHASE ORDERS (GRN — Goods Received Notes)
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/purchase-orders
router.get('/purchase-orders', authenticate, adminOnly, wrap(async (req, res) => {
  const { page, limit, offset } = paginate(req.query);
  const { status, supplier } = req.query;
  const where  = ['1=1'];
  const params = [];

  if (status)   { where.push('po.Status=?');     params.push(status); }
  if (supplier) { where.push('po.SupplierID=?'); params.push(toInt(supplier)); }

  const [[countRow]] = await pool.execute(
    `SELECT COUNT(*) AS total FROM PurchaseOrders po WHERE ${where.join(' AND ')}`, params
  );

  const [rows] = await pool.execute(`
    SELECT po.*, s.CompanyName AS SupplierName,
           au.Email AS CreatedByEmail,
           COUNT(poi.POIID) AS ItemCount,
           SUM(poi.OrderedQty) AS TotalUnitsOrdered,
           SUM(poi.ReceivedQty) AS TotalUnitsReceived
    FROM PurchaseOrders po
    LEFT JOIN Suppliers    s  ON s.SupplierID  = po.SupplierID
    LEFT JOIN AdminUsers   au ON au.AdminID    = po.CreatedBy
    LEFT JOIN PurchaseOrderItems poi ON poi.POID = po.POID
    WHERE ${where.join(' AND ')}
    GROUP BY po.POID
    ORDER BY po.CreatedAt DESC
    LIMIT ${Number(limit)} OFFSET ${Number(offset)}
  `, params);

  ok(res, {
    purchaseOrders: rows,
    pagination: { total: countRow.total, page, limit, pages: Math.ceil(countRow.total / limit) },
  });
}));

// GET /api/inventory/purchase-orders/:id
router.get('/purchase-orders/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req, res) => {
    const [[po]] = await pool.execute(`
      SELECT po.*, s.CompanyName AS SupplierName, s.ContactEmail AS SupplierEmail,
             au.Email AS CreatedByEmail
      FROM PurchaseOrders po
      LEFT JOIN Suppliers  s  ON s.SupplierID = po.SupplierID
      LEFT JOIN AdminUsers au ON au.AdminID   = po.CreatedBy
      WHERE po.POID=?
    `, [toInt(req.params.id)]);
    if (!po) return fail(res, 'Purchase order not found', 404);

    const [items] = await pool.execute(`
      SELECT poi.*, p.Name AS ProductName, p.SKU, p.Brand, c.CategoryName
      FROM PurchaseOrderItems poi
      JOIN Products    p ON p.ProductID = poi.ProductID
      LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
      WHERE poi.POID=?
    `, [toInt(req.params.id)]);

    ok(res, { ...po, items });
  })
);

// POST /api/inventory/purchase-orders
// Create a new purchase order
router.post('/purchase-orders', authenticate, adminOnly,
  [body('supplierID').isInt(), body('items').isArray({ min: 1 })],
  validate,
  wrap(async (req, res) => {
    const { supplierID, items, notes, expectedDeliveryDate } = req.body;
    const conn = await pool.getConnection();

    try {
      await conn.beginTransaction();

      // Calculate totals
      let totalAmount = 0;
      const poItems = [];
      for (const item of items) {
        const qty   = parseInt(item.orderedQty);
        const price = parseFloat(item.unitCost);
        totalAmount += qty * price;
        poItems.push({ productID: toInt(item.productID), qty, price, total: qty * price });
      }

      // Generate PO Number
      const poNumber = `PO-${Date.now()}`;

      const [result] = await conn.execute(`
        INSERT INTO PurchaseOrders
          (PONumber, SupplierID, Status, TotalAmount, Notes, ExpectedDeliveryDate, CreatedBy)
        VALUES (?,?,'pending',?,?,?,?)
      `, [poNumber, toInt(supplierID), totalAmount, notes||null, expectedDeliveryDate||null, req.user.id]);

      const poID = result.insertId;

      for (const item of poItems) {
        await conn.execute(`
          INSERT INTO PurchaseOrderItems
            (POID, ProductID, OrderedQty, ReceivedQty, UnitCost, TotalCost)
          VALUES (?,?,?,0,?,?)
        `, [poID, item.productID, item.qty, item.price, item.total]);
      }

      await conn.commit();
      ok(res, { poID, poNumber, totalAmount, itemCount: poItems.length, message: 'Purchase order created' }, 201);
    } catch (e) {
      await conn.rollback(); throw e;
    } finally {
      conn.release();
    }
  })
);

// POST /api/inventory/purchase-orders/:id/receive
// Receive goods against a PO (GRN — Goods Received Note)
router.post('/purchase-orders/:id/receive', authenticate, adminOnly,
  [param('id').isInt(), body('items').isArray({ min: 1 })],
  validate,
  wrap(async (req, res) => {
    const poID = toInt(req.params.id);
    const { items, notes } = req.body;
    const conn = await pool.getConnection();

    try {
      await conn.beginTransaction();

      const [[po]] = await conn.execute(
        'SELECT * FROM PurchaseOrders WHERE POID=? AND Status IN ("pending","partial")', [poID]
      );
      if (!po) return fail(res, 'Purchase order not found or already completed', 404);

      const received = [];
      for (const item of items) {
        const qty = parseInt(item.receivedQty);
        if (qty <= 0) continue;

        const productID = toInt(item.productID);

        // Update PO item received qty
        await conn.execute(`
          UPDATE PurchaseOrderItems
          SET ReceivedQty = ReceivedQty + ?
          WHERE POID=? AND ProductID=?
        `, [qty, poID, productID]);

        // Update product stock
        const [[old]] = await conn.execute(
          'SELECT StockQuantity, Name FROM Products WHERE ProductID=?', [productID]
        );
        const newStock = old.StockQuantity + qty;

        await conn.execute(
          'UPDATE Products SET StockQuantity=?, UpdatedAt=NOW() WHERE ProductID=?',
          [newStock, productID]
        );

        // Record adjustment
        await conn.execute(`
          INSERT INTO StockAdjustments
            (ProductID, OldQuantity, NewQuantity, Reason, Reference, AdjustedBy)
          VALUES (?,?,?,?,?,?)
        `, [productID, old.StockQuantity, newStock, `GRN - PO#${po.PONumber}`, po.PONumber, req.user.id]);

        received.push({ productID, productName: old.Name, receivedQty: qty, newStock });
      }

      // Check if PO is fully received
      const [[remaining]] = await conn.execute(`
        SELECT SUM(OrderedQty - ReceivedQty) AS remaining
        FROM PurchaseOrderItems WHERE POID=?
      `, [poID]);

      const newStatus = remaining.remaining <= 0 ? 'received' : 'partial';
      await conn.execute(
        'UPDATE PurchaseOrders SET Status=?, ReceivedAt=NOW(), ReceivedNotes=? WHERE POID=?',
        [newStatus, notes||null, poID]
      );

      await conn.commit();
      ok(res, { poID, status: newStatus, received, message: `GRN processed — PO is now ${newStatus}` });
    } catch (e) {
      await conn.rollback(); throw e;
    } finally {
      conn.release();
    }
  })
);

// PATCH /api/inventory/purchase-orders/:id/cancel
router.patch('/purchase-orders/:id/cancel', authenticate, adminOnly,
  [param('id').isInt()], validate,
  wrap(async (req, res) => {
    const [[po]] = await pool.execute(
      "SELECT POID FROM PurchaseOrders WHERE POID=? AND Status='pending'",
      [toInt(req.params.id)]
    );
    if (!po) return fail(res, 'Order not found or cannot be cancelled', 404);
    await pool.execute("UPDATE PurchaseOrders SET Status='cancelled' WHERE POID=?", [toInt(req.params.id)]);
    ok(res, { message: 'Purchase order cancelled' });
  })
);

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 5 — STOCK ADJUSTMENTS HISTORY
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/adjustments
router.get('/adjustments', authenticate, adminOnly, wrap(async (req, res) => {
  const { page, limit, offset } = paginate(req.query);
  const { productID, from, to } = req.query;
  const where  = ['1=1'];
  const params = [];

  if (productID) { where.push('sa.ProductID=?'); params.push(toInt(productID)); }
  if (from)      { where.push('sa.AdjustedAt>=?'); params.push(from); }
  if (to)        { where.push('sa.AdjustedAt<=?'); params.push(to + ' 23:59:59'); }

  const [[countRow]] = await pool.execute(
    `SELECT COUNT(*) AS total FROM StockAdjustments sa WHERE ${where.join(' AND ')}`, params
  );

  const [rows] = await pool.execute(`
    SELECT sa.*, p.Name AS ProductName, p.SKU, c.CategoryName, au.Email AS AdjustedByEmail
    FROM StockAdjustments sa
    JOIN Products    p  ON p.ProductID  = sa.ProductID
    LEFT JOIN Categories c  ON c.CategoryID  = p.CategoryID
    LEFT JOIN AdminUsers au ON au.AdminID    = sa.AdjustedBy
    WHERE ${where.join(' AND ')}
    ORDER BY sa.AdjustedAt DESC
    LIMIT ${Number(limit)} OFFSET ${Number(offset)}
  `, params);

  ok(res, {
    adjustments: rows,
    pagination: { total: countRow.total, page, limit, pages: Math.ceil(countRow.total / limit) },
  });
}));

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 6 — INVENTORY REPORTS
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/report/turnover
// Stock turnover rate — how fast products are selling
router.get('/report/turnover', authenticate, adminOnly, wrap(async (req, res) => {
  const { days = 30 } = req.query;

  const [rows] = await pool.execute(`
    SELECT
      p.ProductID, p.Name, p.SKU, p.Brand, c.CategoryName,
      p.StockQuantity AS CurrentStock,
      IFNULL(SUM(oi.Quantity), 0) AS UnitsSold,
      p.CostPrice,
      IFNULL(SUM(oi.Quantity), 0) * p.CostPrice AS COGS,
      CASE
        WHEN p.StockQuantity = 0 THEN NULL
        ELSE ROUND(IFNULL(SUM(oi.Quantity), 0) / GREATEST(p.StockQuantity, 1), 2)
      END AS TurnoverRatio,
      CASE
        WHEN IFNULL(SUM(oi.Quantity), 0) = 0 THEN NULL
        ELSE ROUND(p.StockQuantity / (IFNULL(SUM(oi.Quantity), 0) / ?), 0)
      END AS DaysOfStockRemaining
    FROM Products p
    LEFT JOIN Categories c  ON c.CategoryID = p.CategoryID
    LEFT JOIN OrderItems  oi ON oi.ProductID = p.ProductID
      AND oi.CreatedAt >= DATE_SUB(NOW(), INTERVAL ? DAY)
    WHERE p.IsActive=1
    GROUP BY p.ProductID
    ORDER BY TurnoverRatio DESC
  `, [parseInt(days), parseInt(days)]);

  ok(res, { period: `${days} days`, rows });
}));

// GET /api/inventory/report/dead-stock
// Products with no sales in given period
router.get('/report/dead-stock', authenticate, adminOnly, wrap(async (req, res) => {
  const { days = 90 } = req.query;

  const [rows] = await pool.execute(`
    SELECT
      p.ProductID, p.Name, p.SKU, p.Brand, c.CategoryName,
      p.StockQuantity, p.ReorderLevel,
      p.CostPrice, (p.StockQuantity * p.CostPrice) AS TiedUpCapital,
      p.CreatedAt AS AddedOn,
      DATEDIFF(NOW(), p.UpdatedAt) AS DaysSinceUpdate
    FROM Products p
    LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
    WHERE p.IsActive=1 AND p.StockQuantity > 0
      AND p.ProductID NOT IN (
        SELECT DISTINCT oi.ProductID FROM OrderItems oi
        WHERE oi.CreatedAt >= DATE_SUB(NOW(), INTERVAL ? DAY)
      )
    ORDER BY TiedUpCapital DESC
  `, [parseInt(days)]);

  ok(res, { period: `${days} days`, deadStockItems: rows.length, rows });
}));

// GET /api/inventory/report/movement
// Stock movement report — in vs out
router.get('/report/movement', authenticate, adminOnly, wrap(async (req, res) => {
  const { from, to, productID } = req.query;
  const dateFrom = from || new Date(Date.now() - 30*24*60*60*1000).toISOString().split('T')[0];
  const dateTo   = to   || new Date().toISOString().split('T')[0];
  const params   = [dateFrom, dateTo + ' 23:59:59'];
  const prodFilter = productID ? 'AND sa.ProductID=?' : '';
  if (productID) params.push(toInt(productID));

  const [inbound] = await pool.execute(`
    SELECT DATE(AdjustedAt) AS Date, SUM(NewQuantity-OldQuantity) AS UnitsIn
    FROM StockAdjustments
    WHERE AdjustedAt BETWEEN ? AND ? AND NewQuantity > OldQuantity ${prodFilter}
    GROUP BY DATE(AdjustedAt) ORDER BY Date
  `, params);

  const [outbound] = await pool.execute(`
    SELECT DATE(CreatedAt) AS Date, SUM(Quantity) AS UnitsOut
    FROM OrderItems
    WHERE CreatedAt BETWEEN ? AND ? ${productID ? 'AND ProductID=?' : ''}
    GROUP BY DATE(CreatedAt) ORDER BY Date
  `, params);

  ok(res, { dateFrom, dateTo, inbound, outbound });
}));

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 7 — REORDER MANAGEMENT
// ══════════════════════════════════════════════════════════════════════════════

// GET /api/inventory/reorder-suggestions
// AI-style reorder suggestions based on sales velocity
router.get('/reorder-suggestions', authenticate, adminOnly, wrap(async (req, res) => {
  const [rows] = await pool.execute(`
    SELECT
      p.ProductID, p.Name, p.SKU, p.Brand, c.CategoryName,
      s.CompanyName AS SupplierName, s.ContactEmail AS SupplierEmail, s.LeadTimeDays,
      p.StockQuantity AS CurrentStock,
      p.ReorderLevel,
      IFNULL(SUM(oi.Quantity), 0) AS SoldLast30Days,
      ROUND(IFNULL(SUM(oi.Quantity), 0) / 30, 2) AS DailyVelocity,
      CASE
        WHEN IFNULL(SUM(oi.Quantity), 0) = 0 THEN 999
        ELSE ROUND(p.StockQuantity / GREATEST(IFNULL(SUM(oi.Quantity), 0)/30, 0.1), 0)
      END AS DaysOfStockLeft,
      GREATEST(
        p.ReorderLevel * 2 - p.StockQuantity,
        ROUND(IFNULL(SUM(oi.Quantity), 0) / 30 * IFNULL(s.LeadTimeDays, 7) * 1.5, 0)
      ) AS SuggestedOrderQty,
      p.CostPrice,
      GREATEST(
        p.ReorderLevel * 2 - p.StockQuantity,
        ROUND(IFNULL(SUM(oi.Quantity), 0) / 30 * IFNULL(s.LeadTimeDays, 7) * 1.5, 0)
      ) * p.CostPrice AS EstimatedCost
    FROM Products p
    LEFT JOIN Categories c  ON c.CategoryID = p.CategoryID
    LEFT JOIN Suppliers   s  ON s.SupplierID  = p.SupplierID
    LEFT JOIN OrderItems  oi ON oi.ProductID  = p.ProductID
      AND oi.CreatedAt >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    WHERE p.IsActive=1 AND p.StockQuantity <= p.ReorderLevel * 1.5
    GROUP BY p.ProductID
    ORDER BY DaysOfStockLeft ASC
    LIMIT 50
  `);

  ok(res, { suggestions: rows, generatedAt: new Date() });
}));

// PATCH /api/inventory/:id/reorder-level
// Update reorder point for a product
router.patch('/:id/reorder-level', authenticate, adminOnly,
  [param('id').isInt(), body('reorderLevel').isInt({ min: 0 })],
  validate,
  wrap(async (req, res) => {
    const { reorderLevel } = req.body;
    await pool.execute(
      'UPDATE Products SET ReorderLevel=?, UpdatedAt=NOW() WHERE ProductID=?',
      [parseInt(reorderLevel), toInt(req.params.id)]
    );
    ok(res, { message: 'Reorder level updated' });
  })
);

// ══════════════════════════════════════════════════════════════════════════════
// SECTION 8 — DATABASE SETUP (Run once to create PO tables)
// ══════════════════════════════════════════════════════════════════════════════

// POST /api/inventory/setup (admin only — creates PO tables if not exist)
router.post('/setup', authenticate, adminOnly, wrap(async (req, res) => {
  await pool.execute(`
    CREATE TABLE IF NOT EXISTS PurchaseOrders (
      POID                INT AUTO_INCREMENT PRIMARY KEY,
      PONumber            VARCHAR(50)  NOT NULL UNIQUE,
      SupplierID          INT          NULL,
      Status              ENUM('pending','partial','received','cancelled') NOT NULL DEFAULT 'pending',
      TotalAmount         DECIMAL(12,2) NOT NULL DEFAULT 0,
      Notes               TEXT          NULL,
      ExpectedDeliveryDate DATE         NULL,
      ReceivedAt          DATETIME      NULL,
      ReceivedNotes       TEXT          NULL,
      CreatedBy           INT           NULL,
      CreatedAt           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UpdatedAt           DATETIME      NULL ON UPDATE CURRENT_TIMESTAMP,
      FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE SET NULL
    )
  `);

  await pool.execute(`
    CREATE TABLE IF NOT EXISTS PurchaseOrderItems (
      POIID       INT AUTO_INCREMENT PRIMARY KEY,
      POID        INT            NOT NULL,
      ProductID   INT            NOT NULL,
      OrderedQty  INT            NOT NULL DEFAULT 0,
      ReceivedQty INT            NOT NULL DEFAULT 0,
      UnitCost    DECIMAL(10,2)  NOT NULL DEFAULT 0,
      TotalCost   DECIMAL(12,2)  NOT NULL DEFAULT 0,
      FOREIGN KEY (POID)      REFERENCES PurchaseOrders(POID) ON DELETE CASCADE,
      FOREIGN KEY (ProductID) REFERENCES Products(ProductID)  ON DELETE CASCADE
    )
  `);

  // Add columns to Suppliers if missing
  const alterCols = [
    "ADD COLUMN IF NOT EXISTS ContactName   VARCHAR(150) NULL",
    "ADD COLUMN IF NOT EXISTS ContactPhone  VARCHAR(30)  NULL",
    "ADD COLUMN IF NOT EXISTS GSTNumber     VARCHAR(20)  NULL",
    "ADD COLUMN IF NOT EXISTS PaymentTerms  VARCHAR(100) NULL",
    "ADD COLUMN IF NOT EXISTS LeadTimeDays  INT          NULL DEFAULT 7",
    "ADD COLUMN IF NOT EXISTS Notes         TEXT         NULL",
  ];
  for (const col of alterCols) {
    await pool.execute(`ALTER TABLE Suppliers ${col}`).catch(() => {});
  }

  ok(res, { message: 'Inventory tables created/verified successfully' });
}));

module.exports = router;
