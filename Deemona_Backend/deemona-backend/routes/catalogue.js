// routes/catalogue.js  — Categories + Products + Inventory (MySQL)
'use strict';
const router = require('express').Router();
const { body, param, query } = require('express-validator');
const pool   = require('../config/db');
const { ok, fail, wrap, paginate, validate, authenticate, adminOnly, toInt } = require('../middleware');

// ══ CATEGORIES ══════════════════════════════════════════════

router.get('/categories', wrap(async (req,res) => {
  const active = req.query.includeInactive==='true' ? '1=1' : 'c.IsActive=1';
  const [rows] = await pool.execute(
    `SELECT c.CategoryID,c.CategoryName,c.Description,c.ParentCategoryID,c.IsActive,
            pc.CategoryName AS ParentName, COUNT(p.ProductID) AS ProductCount
     FROM Categories c
     LEFT JOIN Categories pc ON pc.CategoryID=c.ParentCategoryID
     LEFT JOIN Products   p  ON p.CategoryID=c.CategoryID AND p.IsActive=1
     WHERE ${active}
     GROUP BY c.CategoryID,c.CategoryName,c.Description,c.ParentCategoryID,c.IsActive,pc.CategoryName
     ORDER BY c.CategoryName`
  );
  ok(res, rows);
}));

router.get('/categories/:id', [param('id').isInt()], validate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT c.*,pc.CategoryName AS ParentName,COUNT(p.ProductID) AS ProductCount
     FROM Categories c
     LEFT JOIN Categories pc ON pc.CategoryID=c.ParentCategoryID
     LEFT JOIN Products   p  ON p.CategoryID=c.CategoryID AND p.IsActive=1
     WHERE c.CategoryID=? GROUP BY c.CategoryID`, [toInt(req.params.id)]
  );
  if (!rows.length) return fail(res, 'Category not found', 404);
  ok(res, rows[0]);
}));

router.get('/categories/:id/products', [param('id').isInt()], validate, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { sort='relevance' } = req.query;
  const sortMap = { price_asc:'p.Price ASC', price_desc:'p.Price DESC', rating:'p.AverageRating DESC', newest:'p.CreatedAt DESC' };
  const orderBy = sortMap[sort] || 'p.IsFeatured DESC, p.ViewsCount DESC';
  const [[countRow]] = await pool.execute('SELECT COUNT(*) AS total FROM Products p WHERE p.CategoryID=? AND p.IsActive=1', [toInt(req.params.id)]);
  const [rows] = await pool.execute(
    `SELECT p.ProductID,p.Name,p.Price,p.MRP,p.AverageRating,p.ReviewsCount,p.StockQuantity,p.IsFeatured,p.ImageURLs,
            CASE WHEN p.MRP>0 THEN ROUND((p.MRP-p.Price)*100.0/p.MRP,0) ELSE 0 END AS DiscountPct
     FROM Products p WHERE p.CategoryID=? AND p.IsActive=1 ORDER BY ${orderBy} LIMIT ? OFFSET ?`,
    
  );
  ok(res, { products:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

router.post('/categories', authenticate, adminOnly,
  [body('categoryName').notEmpty().trim()], validate,
  wrap(async (req,res) => {
    const { categoryName, description, parentCategoryID } = req.body;
    const [result] = await pool.execute(
      'INSERT INTO Categories(CategoryName,Description,ParentCategoryID) VALUES(?,?,?)',
      [categoryName, description||null, parentCategoryID||null]
    );
    ok(res, { categoryID:result.insertId, message:'Category created' }, 201);
  })
);

router.put('/categories/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { categoryName, description, isActive, parentCategoryID } = req.body;
    await pool.execute(
      `UPDATE Categories SET
         CategoryName=IFNULL(?,CategoryName), Description=IFNULL(?,Description),
         IsActive=IFNULL(?,IsActive), ParentCategoryID=IFNULL(?,ParentCategoryID)
       WHERE CategoryID=?`,
      [categoryName||null, description||null, isActive!=null?isActive:null, parentCategoryID||null, toInt(req.params.id)]
    );
    ok(res, { message:'Category updated' });
  })
);

router.delete('/categories/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('UPDATE Categories SET IsActive=0 WHERE CategoryID=?', [toInt(req.params.id)]);
    ok(res, { message:'Category deactivated' });
  })
);

// ══ PRODUCTS ════════════════════════════════════════════════

router.get('/products', wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { search, category, minPrice, maxPrice, minRating, inStock, featured, brand, sort='relevance' } = req.query;
  const where = ['p.IsActive=1','(p.ShowPublicly=1 OR p.ShowPublicly IS NULL)']; const params = [];

  if (search)   { where.push('(p.Name LIKE ? OR p.Description LIKE ? OR p.Brand LIKE ? OR p.Tags LIKE ?)'); const q=`%${search}%`; params.push(q,q,q,q); }
  if (category) { where.push('(c.CategoryName=? OR p.CategoryID=(SELECT CategoryID FROM Categories WHERE CategoryName=? LIMIT 1))'); params.push(category,category); }
  if (minPrice) { where.push('p.Price>=?'); params.push(parseFloat(minPrice)); }
  if (maxPrice) { where.push('p.Price<=?'); params.push(parseFloat(maxPrice)); }
  if (minRating){ where.push('p.AverageRating>=?'); params.push(parseFloat(minRating)); }
  if (inStock==='true') { where.push('p.StockQuantity>0'); }
  if (featured==='true'){ where.push('p.IsFeatured=1'); }
  if (brand)    { where.push('p.Brand LIKE ?'); params.push(`%${brand}%`); }

  const sortMap = { price_asc:'p.Price ASC', price_desc:'p.Price DESC', rating:'p.AverageRating DESC', newest:'p.CreatedAt DESC', relevance:'p.IsFeatured DESC,p.ViewsCount DESC' };
  const orderBy = sortMap[sort]||'p.IsFeatured DESC,p.ViewsCount DESC';

  const [[countRow]] = await pool.execute(
    `SELECT COUNT(*) AS total FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID WHERE ${where.join(' AND ')}`, params
  );
  const [rows] = await pool.execute(
    `SELECT p.ProductID,p.Name,p.Description,p.Price,p.MRP,p.Brand,p.SKU,
            p.AverageRating,p.ReviewsCount,p.StockQuantity,p.IsFeatured,p.ImageURLs,
            c.CategoryName,
            CASE WHEN p.MRP>0 THEN ROUND((p.MRP-p.Price)*100.0/p.MRP,0) ELSE 0 END AS DiscountPct
     FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE ${where.join(' AND ')} ORDER BY ${orderBy} LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,
    params
  );
  ok(res, { products:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

router.get('/products/:id', [param('id').isInt()], validate, wrap(async (req,res) => {
  const id = toInt(req.params.id);
  await pool.execute('UPDATE Products SET ViewsCount=IFNULL(ViewsCount,0)+1 WHERE ProductID=?', [id]);
  const [rows] = await pool.execute(
    `SELECT p.*,c.CategoryName,s.CompanyName AS SupplierName
     FROM Products p
     LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     LEFT JOIN Suppliers   s ON s.SupplierID=p.SupplierID
     WHERE p.ProductID=? AND p.IsActive=1`, [id]
  );
  if (!rows.length) return fail(res, 'Product not found', 404);
  const [related] = await pool.execute(
    `SELECT ProductID,Name,Price,MRP,AverageRating,ReviewsCount,StockQuantity,ImageURLs
     FROM Products WHERE CategoryID=? AND ProductID!=? AND IsActive=1
     ORDER BY AverageRating DESC LIMIT 6`, [rows[0].CategoryID, id]
  );
  ok(res, { ...rows[0], related });
}));

router.get('/products/:id/reviews', [param('id').isInt()], validate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT r.*,CONCAT(c.FirstName,' ',c.LastName) AS CustomerName
     FROM Reviews r LEFT JOIN Customers c ON c.CustomerID=r.CustomerID
     WHERE r.ProductID=? AND r.ModerationStatus='approved' ORDER BY r.ReviewDate DESC`, [toInt(req.params.id)]
  );
  ok(res, rows);
}));

router.get('/products/:id/price-history', [param('id').isInt()], validate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    'SELECT OldPrice,NewPrice,ChangedAt,ChangeReason FROM ProductPriceHistory WHERE ProductID=? ORDER BY ChangedAt DESC LIMIT 30',
    [toInt(req.params.id)]
  );
  ok(res, rows);
}));

router.post('/products', authenticate, adminOnly,
  [body('name').notEmpty(), body('price').isFloat({min:0}), body('categoryID').isInt()], validate,
  wrap(async (req,res) => {
    const { name,description,sku,brand,categoryID,supplierID,price,mrp,costPrice,stockQuantity,reorderLevel,weight,dimensions,tags,isFeatured,showPublicly } = req.body;
    const [result] = await pool.execute(
      `INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,StockQuantity,ReorderLevel,Weight,Dimensions,Tags,IsFeatured,ShowPublicly,IsActive)
       VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1)`,
      [name,description||null,sku||null,brand||null,categoryID,supplierID||null,price,mrp||price,costPrice||null,stockQuantity||0,reorderLevel||10,weight||null,dimensions||null,tags||null,isFeatured?1:0,showPublicly!==false?1:0]
    );
    ok(res, { productID:result.insertId, message:'Product created' }, 201);
  })
);

router.put('/products/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const id = toInt(req.params.id);
    const [old] = await pool.execute('SELECT Price FROM Products WHERE ProductID=?', [id]);
    const { name,description,sku,brand,categoryID,price,mrp,costPrice,stockQuantity,reorderLevel,tags,isFeatured,isActive,showPublicly } = req.body;
    if (price && old[0] && parseFloat(price)!==old[0].Price)
      await pool.execute('INSERT INTO ProductPriceHistory(ProductID,OldPrice,NewPrice,ChangeReason) VALUES(?,?,?,?)', [id, old[0].Price, price, 'Admin update']);
    await pool.execute(
      `UPDATE Products SET
         Name=IFNULL(?,Name),Description=IFNULL(?,Description),SKU=IFNULL(?,SKU),Brand=IFNULL(?,Brand),
         CategoryID=IFNULL(?,CategoryID),Price=IFNULL(?,Price),MRP=IFNULL(?,MRP),CostPrice=IFNULL(?,CostPrice),
         StockQuantity=IFNULL(?,StockQuantity),ReorderLevel=IFNULL(?,ReorderLevel),Tags=IFNULL(?,Tags),
         IsFeatured=IFNULL(?,IsFeatured),IsActive=IFNULL(?,IsActive),ShowPublicly=IFNULL(?,ShowPublicly),UpdatedAt=NOW()
       WHERE ProductID=?`,
      [name||null,description||null,sku||null,brand||null,categoryID||null,price||null,mrp||null,costPrice||null,stockQuantity!=null?stockQuantity:null,reorderLevel||null,tags||null,isFeatured!=null?isFeatured:null,isActive!=null?isActive:null,showPublicly!=null?showPublicly:null,id]
    );
    ok(res, { message:'Product updated' });
  })
);

router.patch('/products/:id/stock', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { adjustment, reason, newQuantity } = req.body;
    const id = toInt(req.params.id);
    const [old] = await pool.execute('SELECT StockQuantity FROM Products WHERE ProductID=?', [id]);
    const oldQty = old[0]?.StockQuantity || 0;
    const newQty = newQuantity!=null ? parseInt(newQuantity) : oldQty + (parseInt(adjustment)||0);
    if (newQty < 0) return fail(res, 'Stock cannot go below 0', 400);
    await pool.execute('UPDATE Products SET StockQuantity=?,UpdatedAt=NOW() WHERE ProductID=?', [newQty, id]);
    await pool.execute('INSERT INTO StockAdjustments(ProductID,OldQuantity,NewQuantity,Reason,AdjustedBy) VALUES(?,?,?,?,?)', [id,oldQty,newQty,reason||'Manual',req.user.id]);
    ok(res, { oldQty, newQty, message:'Stock updated' });
  })
);

router.delete('/products/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('UPDATE Products SET IsActive=0,UpdatedAt=NOW() WHERE ProductID=?', [toInt(req.params.id)]);
    ok(res, { message:'Product deactivated' });
  })
);

// ══ INVENTORY ═══════════════════════════════════════════════

router.get('/inventory', authenticate, adminOnly, wrap(async (req,res) => {
  const { page, limit, offset } = paginate(req.query);
  const { lowStock, category, search } = req.query;
  const where = ['p.IsActive=1']; const params = [];
  if (lowStock==='true') { where.push('p.StockQuantity<=p.ReorderLevel'); }
  if (category) { where.push('c.CategoryName=?'); params.push(category); }
  if (search)   { where.push('(p.Name LIKE ? OR p.SKU LIKE ?)'); const q=`%${search}%`; params.push(q,q); }
  const [[countRow]] = await pool.execute(`SELECT COUNT(*) AS total FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID WHERE ${where.join(' AND ')}`, params);
  const [rows] = await pool.execute(
    `SELECT p.ProductID,p.Name,p.SKU,p.Brand,c.CategoryName,p.StockQuantity,p.ReorderLevel,p.Price,p.UpdatedAt
     FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE ${where.join(' AND ')} ORDER BY p.StockQuantity ASC LIMIT ? OFFSET ?`,
    
  );
  ok(res, { inventory:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });
}));

router.get('/inventory/alerts/all', authenticate, adminOnly, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT p.ProductID,p.Name,p.SKU,p.Brand,c.CategoryName,p.StockQuantity,p.ReorderLevel,
            CASE WHEN p.StockQuantity=0 THEN 'out_of_stock' ELSE 'low_stock' END AS AlertType
     FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID
     WHERE p.IsActive=1 AND p.StockQuantity<=p.ReorderLevel ORDER BY p.StockQuantity ASC`
  );
  ok(res, rows);
}));

router.get('/inventory/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute(
      `SELECT p.*,c.CategoryName,
              (SELECT JSON_ARRAYAGG(JSON_OBJECT('adj',sa.NewQuantity-sa.OldQuantity,'reason',sa.Reason,'at',sa.AdjustedAt)) FROM StockAdjustments sa WHERE sa.ProductID=p.ProductID ORDER BY sa.AdjustedAt DESC LIMIT 10) AS History
       FROM Products p LEFT JOIN Categories c ON c.CategoryID=p.CategoryID WHERE p.ProductID=?`,
      [toInt(req.params.id)]
    );
    if (!rows.length) return fail(res, 'Product not found', 404);
    ok(res, rows[0]);
  })
);

router.post('/inventory', authenticate, adminOnly, wrap(async (req,res) => {
  const { productID, stockQuantity, reorderLevel } = req.body;
  await pool.execute('UPDATE Products SET StockQuantity=?,ReorderLevel=IFNULL(?,ReorderLevel),UpdatedAt=NOW() WHERE ProductID=?', [stockQuantity, reorderLevel||null, productID]);
  ok(res, { message:'Inventory updated' });
}));

router.put('/inventory/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    const { StockQuantity, ReorderLevel } = req.body;
    await pool.execute('UPDATE Products SET StockQuantity=IFNULL(?,StockQuantity),ReorderLevel=IFNULL(?,ReorderLevel),UpdatedAt=NOW() WHERE ProductID=?',
      [StockQuantity!=null?StockQuantity:null, ReorderLevel!=null?ReorderLevel:null, toInt(req.params.id)]);
    ok(res, { message:'Inventory updated' });
  })
);

module.exports = router;
