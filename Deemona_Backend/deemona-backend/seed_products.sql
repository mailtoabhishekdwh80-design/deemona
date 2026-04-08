-- ============================================================
--  DEEMONA — 1000 Sample Products Seed
--  Generated: 2026-03-21
--  Categories: Electronics, Clothing, Books, Home Decor,
--              Home Appliances, Gym Accessories, Sports, Medicines
-- ============================================================
USE DeemonaDB;
GO

-- Categories
SET IDENTITY_INSERT Categories ON;
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Electronics')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(1,'Electronics',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Clothing')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(2,'Clothing',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Books')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(3,'Books',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Home Decor')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(4,'Home Decor',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Home Appliances')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(5,'Home Appliances',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Gym Accessories')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(6,'Gym Accessories',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Sports')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(7,'Sports',1);
IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='Medicines')
  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(8,'Medicines',1);
SET IDENTITY_INSERT Categories OFF;
GO

-- Suppliers
SET IDENTITY_INSERT Suppliers ON;
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='supply@techvision.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(1,'TechVision Pvt Ltd','supply@techvision.in','Bengaluru',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='orders@fabricworld.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(2,'FabricWorld India','orders@fabricworld.in','Surat',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='bulk@pageturner.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(3,'PageTurner Distributors','bulk@pageturner.in','Mumbai',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='supply@homestyle.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(4,'HomeStyle Suppliers','supply@homestyle.in','Delhi',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='orders@fitgear.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(5,'FitGear Wholesale','orders@fitgear.in','Pune',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='procurement@medsource.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(6,'MedSource India','procurement@medsource.in','Hyderabad',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='bulk@sportzone.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(7,'SportZone Wholesale','bulk@sportzone.in','Chennai',1);
IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='supply@appliancehub.in')
  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)
  VALUES(8,'AplianceHub Pvt Ltd','supply@appliancehub.in','Noida',1);
SET IDENTITY_INSERT Suppliers OFF;
GO

-- Products (532 total)
-- Batch 1/20 (products 1–50)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vivo Pro Max',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00001','OnePlus',1,1,
  18320,23270,9602,191,21,
  'smartphone,5g,mobile',0,0.22,4.7,79,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Samsung Ultra 5G',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00002','Xiaomi',1,1,
  9239,12380,4578,71,14,
  'smartphone,5g,mobile',0,0.22,4.5,31,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xiaomi 5G Plus',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00003','Realme',1,1,
  17873,26270,10680,285,26,
  'smartphone,5g,mobile',0,0.22,3.5,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Realme Lite 5G',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00004','OnePlus',1,1,
  22799,28040,13781,140,21,
  'smartphone,5g,mobile',0,0.22,4.9,105,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Realme Neo 5G',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00005','Samsung',1,1,
  19684,25000,13610,145,31,
  'smartphone,5g,mobile',0,0.22,3.5,220,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xiaomi X Pro',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00006','Realme',1,1,
  33885,46420,18245,203,15,
  'smartphone,5g,mobile',0,0.22,3.7,366,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'AirPods Pro Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00007','Xiaomi',1,1,
  7574,12040,4985,246,22,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.7,148,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Galaxy Buds Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00008','Acer',1,1,
  8771,13240,5521,95,17,
  'earbuds,wireless,bluetooth,audio',0,0.06,3.5,342,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Airdopes 181 Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00009','Acer',1,1,
  11435,17500,6558,147,20,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.5,201,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'XSound Go Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00010','Acer',1,1,
  11872,18520,6059,46,27,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.5,344,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Boat Airdopes 441 Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00011','Dell',1,1,
  3184,4390,1612,127,37,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.9,159,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'QuietComfort Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00012','Acer',1,1,
  5074,7920,2790,64,36,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.9,115,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00013','Realme',1,1,
  14912,22220,8971,41,28,
  'earbuds,wireless,bluetooth,audio',0,0.06,3.9,398,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WF-1000XM5 Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00014','Sony',1,1,
  7869,11720,3975,118,11,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.1,448,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'FreeBuds Pro Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00015','Philips',1,1,
  7430,9210,4908,268,30,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.8,153,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Momentum True Wireless Earbuds',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00016','Belkin',1,1,
  8274,12580,5710,178,35,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.0,107,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fire-Boltt Band Pro Smartwatch',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00017','Noise',1,1,
  13105,16380,6604,30,14,
  'smartwatch,fitness,wearable',0,0.08,4.9,32,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fire-Boltt Watch GT 3 Smartwatch',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00018','Fire-Boltt',1,1,
  1580,2350,1011,38,34,
  'smartwatch,fitness,wearable',0,0.08,4.2,33,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Samsung Smart SE Smartwatch',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00019','boAt',1,1,
  16395,18360,9615,201,25,
  'smartwatch,fitness,wearable',0,0.08,4.3,74,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'boAt FitPro Ultra Smartwatch',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00020','Noise',1,1,
  14867,18580,9398,163,36,
  'smartwatch,fitness,wearable',1,0.08,4.2,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Noise Active 5 Smartwatch',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00021','Noise',1,1,
  2336,3200,1320,41,34,
  'smartwatch,fitness,wearable',0,0.08,4.8,264,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'IdeaPad 3 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00022','Microsoft',1,1,
  73349,86550,45843,38,19,
  'laptop,computer,notebook,work',0,1.60,4.7,39,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'VivoBook 15 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00023','LG',1,1,
  89782,141860,51219,163,18,
  'laptop,computer,notebook,work',0,1.60,4.2,26,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Aspire 5 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00024','Asus',1,1,
  102276,136030,64487,279,34,
  'laptop,computer,notebook,work',0,1.60,3.9,307,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pavilion 15 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00025','Asus',1,1,
  138298,171490,86009,188,13,
  'laptop,computer,notebook,work',0,1.60,4.0,214,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Inspiron 15 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00026','Microsoft',1,1,
  34421,45780,18131,267,12,
  'laptop,computer,notebook,work',0,1.60,3.7,152,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MacBook Air M2 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00027','Lenovo',1,1,
  128855,170090,60090,105,20,
  'laptop,computer,notebook,work',0,1.60,3.7,222,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ThinkPad E14 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00028','Apple',1,1,
  38626,53690,20103,294,26,
  'laptop,computer,notebook,work',0,1.60,4.2,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gram 16 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00029','HP',1,1,
  47899,57480,29796,12,24,
  'laptop,computer,notebook,work',0,1.60,3.8,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ZenBook 14 Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00030','Lenovo',1,1,
  90008,126010,50284,22,25,
  'laptop,computer,notebook,work',0,1.60,3.9,383,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Surface Laptop Laptop',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00031','Microsoft',1,1,
  112685,127330,77666,175,35,
  'laptop,computer,notebook,work',0,1.60,4.0,56,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charge 5 Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00032','Bose',1,1,
  6797,9990,3813,128,27,
  'speaker,bluetooth,portable,audio',0,0.50,4.9,140,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Extreme 3 Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00033','Anker',1,1,
  1976,2210,1107,266,25,
  'speaker,bluetooth,portable,audio',0,0.50,4.5,187,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Flip 6 Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00034','Anker',1,1,
  11564,18270,6114,254,39,
  'speaker,bluetooth,portable,audio',0,0.50,5.0,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Soundlink Mini Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00035','Bose',1,1,
  8268,12730,4262,278,17,
  'speaker,bluetooth,portable,audio',0,0.50,4.6,127,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Go 3 Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00036','JBL',1,1,
  6291,9440,3344,280,14,
  'speaker,bluetooth,portable,audio',0,0.50,4.3,421,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tribit MaxSound Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00037','JBL',1,1,
  2129,3150,1276,57,33,
  'speaker,bluetooth,portable,audio',0,0.50,3.7,142,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mivi Roam 2 Bluetooth Speaker',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00038','Mivi',1,1,
  11639,15710,6095,187,24,
  'speaker,bluetooth,portable,audio',0,0.50,4.0,202,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'EOS M50 Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00039','Nikon',1,1,
  88714,123310,58702,205,30,
  'camera,photography,mirrorless',0,0.40,4.8,80,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Alpha 6400 Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00040','Nikon',1,1,
  68225,102340,32050,177,35,
  'camera,photography,mirrorless',1,0.40,4.2,373,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Z30 Mirrorless Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00041','Canon',1,1,
  55937,77190,37591,52,18,
  'camera,photography,mirrorless',0,0.40,3.8,208,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OM-5 Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00042','Sony',1,1,
  63821,99560,38140,190,18,
  'camera,photography,mirrorless',0,0.40,4.0,51,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fujifilm X-T30 Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00043','Olympus',1,1,
  71539,89420,47662,265,30,
  'camera,photography,mirrorless',0,0.40,3.6,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00044','Sony',1,1,
  41530,46930,22384,91,33,
  'camera,photography,mirrorless',0,0.40,4.2,99,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tab S8 Tablet',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00045','Amazon',1,1,
  34054,38140,22053,8,19,
  'tablet,android,ipad',0,0.55,3.7,24,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'iPad 10th Gen Tablet',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00046','Lenovo',1,1,
  26603,34580,13822,288,11,
  'tablet,android,ipad',0,0.55,4.4,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tab P12 Tablet',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00047','Huawei',1,1,
  28485,35320,16168,242,20,
  'tablet,android,ipad',0,0.55,4.5,130,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MatePad Pro Tablet',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00048','Samsung',1,1,
  41175,61350,27559,280,40,
  'tablet,android,ipad',0,0.55,4.9,50,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fire HD 10 Tablet',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00049','Lenovo',1,1,
  29668,32930,16522,168,31,
  'tablet,android,ipad',0,0.55,4.5,435,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'DualSense Controller',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00050','Logitech',1,1,
  23515,33630,11427,289,17,
  'gaming,peripheral,esports',0,0.80,4.8,163,1);
GO

-- Batch 2/20 (products 51–100)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xbox Controller',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00051','HyperX',1,1,
  38756,51160,17530,185,31,
  'gaming,peripheral,esports',0,0.80,4.5,415,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mechanical Keyboard RGB',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00052','HyperX',1,1,
  7853,12020,4458,20,28,
  'gaming,peripheral,esports',0,0.80,3.7,437,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gaming Mouse Pro',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00053','Microsoft',1,1,
  25356,34230,14223,176,33,
  'gaming,peripheral,esports',0,0.80,4.2,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gaming Headset 7.1',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00054','Razer',1,1,
  23632,30960,14030,169,15,
  'gaming,peripheral,esports',0,0.80,4.6,130,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '27-inch 144Hz Monitor',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00055','Microsoft',1,1,
  16028,18270,9786,23,24,
  'gaming,peripheral,esports',0,0.80,3.6,86,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Capture Card 4K',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00056','Microsoft',1,1,
  35646,49900,19702,143,29,
  'gaming,peripheral,esports',0,0.80,4.2,67,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gaming Chair RGB',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00057','BenQ',1,1,
  35210,42960,20485,286,35,
  'gaming,peripheral,esports',0,0.80,4.5,140,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '65W GaN Charger',
  'Essential everyday tech accessory built to last.',
  'ELC-00058','Xiaomi',1,1,
  1627,2150,1027,233,32,
  'accessory,charger,gadget',0,0.30,4.9,237,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '20000mAh Power Bank',
  'Essential everyday tech accessory built to last.',
  'ELC-00059','Lenovo',1,1,
  1141,1360,754,155,20,
  'accessory,charger,gadget',0,0.30,4.3,188,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'USB-C Hub 7-in-1',
  'Essential everyday tech accessory built to last.',
  'ELC-00060','Lenovo',1,1,
  2796,3580,1323,283,32,
  'accessory,charger,gadget',1,0.30,3.6,129,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wireless Charging Pad',
  'Essential everyday tech accessory built to last.',
  'ELC-00061','Philips',1,1,
  1943,2310,1324,30,34,
  'accessory,charger,gadget',0,0.30,5.0,124,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Phone Stand Adjustable',
  'Essential everyday tech accessory built to last.',
  'ELC-00062','Lenovo',1,1,
  3362,4810,1799,287,16,
  'accessory,charger,gadget',0,0.30,4.2,68,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Laptop Sleeve 15"',
  'Essential everyday tech accessory built to last.',
  'ELC-00063','Anker',1,1,
  2116,3130,1195,100,29,
  'accessory,charger,gadget',0,0.30,3.9,358,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart Plug Wi-Fi',
  'Essential everyday tech accessory built to last.',
  'ELC-00064','Philips',1,1,
  2050,2420,1003,278,15,
  'accessory,charger,gadget',0,0.30,4.3,30,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'LED Desk Lamp Smart',
  'Essential everyday tech accessory built to last.',
  'ELC-00065','Xiaomi',1,1,
  527,630,241,183,32,
  'accessory,charger,gadget',0,0.30,4.3,174,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wi-Fi 6 Router',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00066','TP-Link',1,1,
  4032,5200,2782,151,18,
  'networking,router,wifi,internet',0,0.40,4.8,244,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00067','Tenda',1,1,
  12843,16050,8303,249,32,
  'networking,router,wifi,internet',0,0.40,4.4,426,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '4G LTE Router',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00068','D-Link',1,1,
  1346,1990,689,15,39,
  'networking,router,wifi,internet',0,0.40,5.0,253,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gigabit Switch 8-Port',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00069','Tenda',1,1,
  5587,6590,2697,119,39,
  'networking,router,wifi,internet',0,0.40,4.7,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Powerline Adapter Kit',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00070','Netgear',1,1,
  3919,4980,2289,174,38,
  'networking,router,wifi,internet',0,0.40,3.8,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wi-Fi Range Extender',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00071','Netgear',1,1,
  12130,13340,7917,34,30,
  'networking,router,wifi,internet',0,0.40,4.3,295,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '24" FHD IPS Monitor',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00072','Asus',1,1,
  28462,40990,18014,45,22,
  'monitor,display,screen',0,3.50,3.9,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '27" QHD Monitor',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00073','LG',1,1,
  41704,59220,20801,91,36,
  'monitor,display,screen',0,3.50,4.2,440,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '32" 4K Display',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00074','BenQ',1,1,
  33469,52210,19448,294,31,
  'monitor,display,screen',0,3.50,4.1,448,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Portable 15.6" Monitor',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00075','LG',1,1,
  25513,29080,16632,252,17,
  'monitor,display,screen',0,3.50,3.9,75,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart LED Bulb Colour',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00076','Yale',1,1,
  3291,3980,1618,9,17,
  'smarthome,iot,alexa',0,0.35,4.8,28,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart Door Lock',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00077','Yale',1,1,
  7403,9700,4017,132,14,
  'smarthome,iot,alexa',0,0.35,3.6,16,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Video Doorbell Wi-Fi',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00078','Eufy',1,1,
  1786,2860,1013,92,10,
  'smarthome,iot,alexa',0,0.35,3.8,250,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Security Camera Indoor',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00079','Eufy',1,1,
  3631,5370,2319,107,11,
  'smarthome,iot,alexa',0,0.35,4.0,235,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart Thermostat',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00080','Honeywell',1,1,
  6417,7120,2967,179,35,
  'smarthome,iot,alexa',1,0.35,4.4,242,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Voice-Controlled Smart Strip',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00081','Honeywell',1,1,
  4148,5850,2181,118,23,
  'smarthome,iot,alexa',0,0.35,4.7,300,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WH-1000XM5 Over-Ear Headphones',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00082','Bose',1,1,
  21084,32470,13614,215,11,
  'headphones,anc,audio,hi-fi',0,0.25,3.9,148,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'QuietComfort 45 Over-Ear Headphones',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00083','Philips',1,1,
  23215,29480,12786,85,17,
  'headphones,anc,audio,hi-fi',0,0.25,4.8,126,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Momentum 4 Over-Ear Headphones',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00084','Bose',1,1,
  7329,9230,3377,178,18,
  'headphones,anc,audio,hi-fi',0,0.25,3.5,253,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fidelio X3 Over-Ear Headphones',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00085','Jabra',1,1,
  17645,27880,12288,129,39,
  'headphones,anc,audio,hi-fi',0,0.25,4.5,298,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00086','Sennheiser',1,1,
  10032,11440,5367,61,13,
  'headphones,anc,audio,hi-fi',0,0.25,3.5,134,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Slim Fit Chinos',
  'Black Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00087','Zara',2,2,
  2443,3220,1600,248,15,
  'bottom,trousers,casual',0,0.45,5.0,122,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Slim Fit Chinos',
  'White Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00088','Nike',2,2,
  2578,4100,1405,116,40,
  'bottom,trousers,casual',0,0.45,4.1,8,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Slim Fit Chinos',
  'Navy Blue Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00089','Allen Solly',2,2,
  1774,2290,817,264,40,
  'bottom,trousers,casual',0,0.45,4.5,141,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Slim Fit Chinos',
  'Olive Green Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00090','Roadster',2,2,
  1055,1290,520,248,11,
  'bottom,trousers,casual',0,0.45,3.5,208,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Regular Fit Jeans',
  'Black Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00091','Zara',2,2,
  1131,1720,647,148,13,
  'bottom,trousers,casual',0,0.45,4.9,175,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Regular Fit Jeans',
  'White Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00092','Woodland',2,2,
  2486,3280,1485,45,16,
  'bottom,trousers,casual',0,0.45,4.8,410,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Regular Fit Jeans',
  'Navy Blue Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00093','US Polo',2,2,
  1581,2150,1046,161,18,
  'bottom,trousers,casual',0,0.45,4.4,366,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Regular Fit Jeans',
  'Olive Green Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00094','HRX',2,2,
  1916,2260,1077,264,18,
  'bottom,trousers,casual',0,0.45,5.0,347,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Cargo Pants',
  'Black Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00095','Zara',2,2,
  1147,1620,609,206,27,
  'bottom,trousers,casual',0,0.45,4.0,441,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Cargo Pants',
  'White Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00096','Van Heusen',2,2,
  3230,4360,2151,106,13,
  'bottom,trousers,casual',0,0.45,4.3,107,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Cargo Pants',
  'Navy Blue Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00097','Puma',2,2,
  1591,1780,1038,108,14,
  'bottom,trousers,casual',0,0.45,3.9,181,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Cargo Pants',
  'Olive Green Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00098','Van Heusen',2,2,
  1102,1690,670,267,16,
  'bottom,trousers,casual',0,0.45,4.1,325,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00099','Levi''s',2,2,
  1185,1590,752,141,22,
  'bottom,trousers,casual',0,0.45,3.6,429,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Track Pants',
  'White Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00100','Nike',2,2,
  1339,1510,821,239,35,
  'bottom,trousers,casual',1,0.45,4.0,370,1);
GO

-- Batch 3/20 (products 101–150)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Track Pants',
  'Navy Blue Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00101','Adidas',2,2,
  965,1150,452,296,14,
  'bottom,trousers,casual',0,0.45,3.9,296,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Track Pants',
  'Olive Green Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00102','H&M',2,2,
  2830,3310,1922,201,29,
  'bottom,trousers,casual',0,0.45,4.7,174,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Joggers',
  'Black Joggers in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00103','Arrow',2,2,
  2802,4150,1432,229,28,
  'bottom,trousers,casual',0,0.45,4.3,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Joggers',
  'White Joggers in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00104','Levi''s',2,2,
  614,740,395,140,12,
  'bottom,trousers,casual',0,0.45,4.0,414,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Joggers',
  'Navy Blue Joggers in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00105','HRX',2,2,
  2659,3160,1210,202,22,
  'bottom,trousers,casual',0,0.45,4.2,314,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Joggers',
  'Olive Green Joggers in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00106','Allen Solly',2,2,
  2162,2660,1222,126,40,
  'bottom,trousers,casual',0,0.45,3.6,77,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Graphic Tee',
  'Pure cotton Black Graphic Tee — breathable, soft and easy-care.',
  'CLO-00107','Zara',2,2,
  832,1260,461,221,27,
  'tshirt,top,casual,cotton',0,0.20,4.8,16,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Graphic Tee',
  'Pure cotton White Graphic Tee — breathable, soft and easy-care.',
  'CLO-00108','Woodland',2,2,
  1491,2130,748,149,13,
  'tshirt,top,casual,cotton',0,0.20,4.2,118,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Graphic Tee',
  'Pure cotton Navy Blue Graphic Tee — breathable, soft and easy-care.',
  'CLO-00109','Woodland',2,2,
  547,620,290,47,23,
  'tshirt,top,casual,cotton',0,0.20,4.6,33,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Graphic Tee',
  'Pure cotton Olive Green Graphic Tee — breathable, soft and easy-care.',
  'CLO-00110','Roadster',2,2,
  1049,1480,480,229,15,
  'tshirt,top,casual,cotton',0,0.20,4.7,378,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey Graphic Tee',
  'Pure cotton Charcoal Grey Graphic Tee — breathable, soft and easy-care.',
  'CLO-00111','Jack & Jones',2,2,
  478,680,268,87,13,
  'tshirt,top,casual,cotton',0,0.20,3.7,312,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Polo T-Shirt',
  'Pure cotton Black Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00112','Levi''s',2,2,
  794,1040,420,197,37,
  'tshirt,top,casual,cotton',0,0.20,4.3,243,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Polo T-Shirt',
  'Pure cotton White Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00113','Arrow',2,2,
  728,1120,396,50,36,
  'tshirt,top,casual,cotton',0,0.20,4.4,22,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Polo T-Shirt',
  'Pure cotton Navy Blue Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00114','Adidas',2,2,
  852,1160,538,242,17,
  'tshirt,top,casual,cotton',0,0.20,4.0,433,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Polo T-Shirt',
  'Pure cotton Olive Green Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00115','Levi''s',2,2,
  1423,2130,774,137,38,
  'tshirt,top,casual,cotton',0,0.20,4.2,140,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey Polo T-Shirt',
  'Pure cotton Charcoal Grey Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00116','Roadster',2,2,
  1020,1600,516,137,10,
  'tshirt,top,casual,cotton',0,0.20,4.5,20,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black V-Neck T-Shirt',
  'Pure cotton Black V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00117','Adidas',2,2,
  754,1090,370,225,13,
  'tshirt,top,casual,cotton',0,0.20,3.6,98,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White V-Neck T-Shirt',
  'Pure cotton White V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00118','Woodland',2,2,
  499,680,271,22,17,
  'tshirt,top,casual,cotton',0,0.20,4.8,10,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue V-Neck T-Shirt',
  'Pure cotton Navy Blue V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00119','Arrow',2,2,
  1073,1720,683,114,13,
  'tshirt,top,casual,cotton',0,0.20,4.9,439,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green V-Neck T-Shirt',
  'Pure cotton Olive Green V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00120','H&M',2,2,
  812,1100,467,121,32,
  'tshirt,top,casual,cotton',1,0.20,4.3,266,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey V-Neck T-Shirt',
  'Pure cotton Charcoal Grey V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00121','Jack & Jones',2,2,
  1104,1400,499,20,24,
  'tshirt,top,casual,cotton',0,0.20,4.1,88,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Oversized T-Shirt',
  'Pure cotton Black Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00122','US Polo',2,2,
  715,1050,391,267,37,
  'tshirt,top,casual,cotton',0,0.20,4.7,422,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oversized T-Shirt',
  'Pure cotton White Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00123','Puma',2,2,
  509,670,329,74,33,
  'tshirt,top,casual,cotton',0,0.20,3.6,432,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Oversized T-Shirt',
  'Pure cotton Navy Blue Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00124','Jack & Jones',2,2,
  312,390,191,69,18,
  'tshirt,top,casual,cotton',0,0.20,3.6,204,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00125','Arrow',2,2,
  1062,1360,699,49,11,
  'tshirt,top,casual,cotton',0,0.20,3.7,158,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey Oversized T-Shirt',
  'Pure cotton Charcoal Grey Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00126','Roadster',2,2,
  671,910,423,245,17,
  'tshirt,top,casual,cotton',0,0.20,4.2,101,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Striped T-Shirt',
  'Pure cotton Black Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00127','Woodland',2,2,
  1252,1410,634,149,33,
  'tshirt,top,casual,cotton',0,0.20,4.3,107,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Striped T-Shirt',
  'Pure cotton White Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00128','Jack & Jones',2,2,
  708,840,369,71,27,
  'tshirt,top,casual,cotton',0,0.20,4.3,209,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Striped T-Shirt',
  'Pure cotton Navy Blue Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00129','Allen Solly',2,2,
  412,610,229,289,35,
  'tshirt,top,casual,cotton',0,0.20,3.6,401,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Striped T-Shirt',
  'Pure cotton Olive Green Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00130','Arrow',2,2,
  411,580,195,182,14,
  'tshirt,top,casual,cotton',0,0.20,3.7,186,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey Striped T-Shirt',
  'Pure cotton Charcoal Grey Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00131','Nike',2,2,
  1084,1430,707,251,39,
  'tshirt,top,casual,cotton',0,0.20,4.1,381,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Oxford Button-Down Shirt',
  'Black Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00132','Allen Solly',2,2,
  1157,1800,691,196,37,
  'shirt,formal,casual,top',0,0.28,4.0,276,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oxford Button-Down Shirt',
  'White Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00133','Puma',2,2,
  2043,2940,1342,92,13,
  'shirt,formal,casual,top',0,0.28,4.4,105,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Oxford Button-Down Shirt',
  'Navy Blue Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00134','Adidas',2,2,
  1718,2580,829,130,14,
  'shirt,formal,casual,top',0,0.28,4.4,269,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oxford Button-Down Shirt',
  'Olive Green Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00135','Woodland',2,2,
  767,1010,461,133,17,
  'shirt,formal,casual,top',0,0.28,3.7,308,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Casual Linen Shirt',
  'Black Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00136','Puma',2,2,
  1118,1680,573,153,35,
  'shirt,formal,casual,top',0,0.28,4.0,331,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Casual Linen Shirt',
  'White Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00137','Levi''s',2,2,
  1206,1910,708,164,24,
  'shirt,formal,casual,top',0,0.28,3.5,156,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Casual Linen Shirt',
  'Navy Blue Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00138','Van Heusen',2,2,
  848,1030,556,232,30,
  'shirt,formal,casual,top',0,0.28,4.5,153,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Casual Linen Shirt',
  'Olive Green Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00139','Woodland',2,2,
  756,1020,459,281,26,
  'shirt,formal,casual,top',0,0.28,4.9,306,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Formal Dress Shirt',
  'Black Formal Dress Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00140','HRX',2,2,
  865,950,594,213,40,
  'shirt,formal,casual,top',1,0.28,4.4,29,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Formal Dress Shirt',
  'White Formal Dress Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00141','Levi''s',2,2,
  877,1110,432,174,10,
  'shirt,formal,casual,top',0,0.28,3.5,50,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Formal Dress Shirt',
  'Navy Blue Formal Dress Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00142','H&M',2,2,
  1621,2370,850,226,30,
  'shirt,formal,casual,top',0,0.28,4.8,127,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Formal Dress Shirt',
  'Olive Green Formal Dress Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00143','HRX',2,2,
  2798,3670,1657,193,38,
  'shirt,formal,casual,top',0,0.28,4.9,6,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Flannel Check Shirt',
  'Black Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00144','Arrow',2,2,
  2260,2530,1086,10,22,
  'shirt,formal,casual,top',0,0.28,4.8,144,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Flannel Check Shirt',
  'White Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00145','Mango',2,2,
  2265,2940,1437,135,26,
  'shirt,formal,casual,top',0,0.28,4.2,259,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Flannel Check Shirt',
  'Navy Blue Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00146','Arrow',2,2,
  1435,1680,702,239,12,
  'shirt,formal,casual,top',0,0.28,4.6,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Flannel Check Shirt',
  'Olive Green Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00147','Roadster',2,2,
  2841,3840,1523,126,12,
  'shirt,formal,casual,top',0,0.28,4.0,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Quilted Jacket',
  'Black Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00148','Mango',2,2,
  4256,6090,2266,167,22,
  'jacket,outerwear,winter',0,0.65,4.5,445,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Quilted Jacket',
  'White Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00149','Adidas',2,2,
  1851,2240,1123,98,24,
  'jacket,outerwear,winter',0,0.65,4.4,234,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Quilted Jacket',
  'Navy Blue Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00150','Zara',2,2,
  2303,3060,1272,118,14,
  'jacket,outerwear,winter',0,0.65,4.4,344,1);
GO

-- Batch 4/20 (products 151–200)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Windbreaker',
  'Black Windbreaker — water-resistant and windproof for all-season wear.',
  'CLO-00151','Levi''s',2,2,
  2259,2640,1066,22,36,
  'jacket,outerwear,winter',0,0.65,4.7,301,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Windbreaker',
  'White Windbreaker — water-resistant and windproof for all-season wear.',
  'CLO-00152','Allen Solly',2,2,
  5129,6150,3466,66,32,
  'jacket,outerwear,winter',0,0.65,3.7,119,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Windbreaker',
  'Navy Blue Windbreaker — water-resistant and windproof for all-season wear.',
  'CLO-00153','HRX',2,2,
  4562,5790,2873,184,35,
  'jacket,outerwear,winter',0,0.65,4.0,136,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Hoodie Sweatshirt',
  'Black Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00154','Allen Solly',2,2,
  4897,6370,2263,146,22,
  'jacket,outerwear,winter',0,0.65,3.9,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00155','Van Heusen',2,2,
  2190,3180,1009,225,35,
  'jacket,outerwear,winter',0,0.65,3.9,440,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Hoodie Sweatshirt',
  'Navy Blue Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00156','Zara',2,2,
  4539,5580,3089,52,39,
  'jacket,outerwear,winter',0,0.65,4.1,135,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Zip-Up Fleece',
  'Black Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00157','Roadster',2,2,
  4029,6450,2631,217,40,
  'jacket,outerwear,winter',0,0.65,3.7,340,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Zip-Up Fleece',
  'White Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00158','Woodland',2,2,
  4624,5550,2807,76,27,
  'jacket,outerwear,winter',0,0.65,3.6,332,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Zip-Up Fleece',
  'Navy Blue Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00159','Puma',2,2,
  5051,5910,2335,58,10,
  'jacket,outerwear,winter',0,0.65,4.0,82,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Puffer Vest',
  'Black Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00160','US Polo',2,2,
  4455,5610,2481,118,28,
  'jacket,outerwear,winter',1,0.65,3.9,300,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Puffer Vest',
  'White Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00161','Van Heusen',2,2,
  4519,5920,3140,231,23,
  'jacket,outerwear,winter',0,0.65,4.5,53,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Puffer Vest',
  'Navy Blue Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00162','Zara',2,2,
  2409,3540,1645,212,32,
  'jacket,outerwear,winter',0,0.65,4.1,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bomber Jacket',
  'Black Bomber Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00163','Roadster',2,2,
  1088,1490,635,129,15,
  'jacket,outerwear,winter',0,0.65,4.6,340,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Bomber Jacket',
  'White Bomber Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00164','Puma',2,2,
  3329,4190,1698,287,40,
  'jacket,outerwear,winter',0,0.65,3.7,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Bomber Jacket',
  'Navy Blue Bomber Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00165','Woodland',2,2,
  1696,2360,1091,87,18,
  'jacket,outerwear,winter',0,0.65,4.8,316,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Denim Jacket',
  'Black Denim Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00166','Levi''s',2,2,
  5116,7010,3569,15,20,
  'jacket,outerwear,winter',0,0.65,4.4,332,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Denim Jacket',
  'White Denim Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00167','H&M',2,2,
  4745,5270,2629,144,18,
  'jacket,outerwear,winter',0,0.65,4.2,264,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Denim Jacket',
  'Navy Blue Denim Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00168','H&M',2,2,
  3035,4800,2005,174,40,
  'jacket,outerwear,winter',0,0.65,4.5,35,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Floral Maxi Dress',
  'Elegant Black Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00169','W for Woman',2,2,
  2462,3470,1433,186,13,
  'women,dress,ethnic,western',0,0.35,4.0,430,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Floral Maxi Dress',
  'Elegant White Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00170','Biba',2,2,
  1005,1310,488,167,29,
  'women,dress,ethnic,western',0,0.35,3.5,80,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Floral Maxi Dress',
  'Elegant Navy Blue Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00171','Biba',2,2,
  3823,6000,2352,124,15,
  'women,dress,ethnic,western',0,0.35,4.0,356,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Floral Maxi Dress',
  'Elegant Olive Green Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00172','Zara',2,2,
  3174,4350,1625,134,20,
  'women,dress,ethnic,western',0,0.35,3.9,206,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Wrap Midi Dress',
  'Elegant Black Wrap Midi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00173','W for Woman',2,2,
  2325,3650,1098,142,36,
  'women,dress,ethnic,western',0,0.35,4.5,64,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Wrap Midi Dress',
  'Elegant White Wrap Midi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00174','W for Woman',2,2,
  2504,3680,1673,65,14,
  'women,dress,ethnic,western',0,0.35,4.3,51,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Wrap Midi Dress',
  'Elegant Navy Blue Wrap Midi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00175','AND',2,2,
  3801,5660,1886,174,31,
  'women,dress,ethnic,western',0,0.35,4.8,9,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Wrap Midi Dress',
  'Elegant Olive Green Wrap Midi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00176','Mango',2,2,
  2737,3560,1301,169,30,
  'women,dress,ethnic,western',0,0.35,4.7,161,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bodycon Mini Dress',
  'Elegant Black Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00177','Mango',2,2,
  1746,2220,1163,212,29,
  'women,dress,ethnic,western',0,0.35,4.2,211,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Bodycon Mini Dress',
  'Elegant White Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00178','Zara',2,2,
  2722,4000,1397,184,26,
  'women,dress,ethnic,western',0,0.35,4.4,220,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Bodycon Mini Dress',
  'Elegant Navy Blue Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00179','AND',2,2,
  3324,3720,1785,171,31,
  'women,dress,ethnic,western',0,0.35,3.7,153,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Bodycon Mini Dress',
  'Elegant Olive Green Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00180','AND',2,2,
  855,1350,470,300,16,
  'women,dress,ethnic,western',1,0.35,3.5,351,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black A-Line Skirt',
  'Elegant Black A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00181','Zara',2,2,
  1230,1850,808,229,27,
  'women,dress,ethnic,western',0,0.35,4.7,242,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White A-Line Skirt',
  'Elegant White A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00182','Mango',2,2,
  3993,4990,2684,124,22,
  'women,dress,ethnic,western',0,0.35,4.9,416,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue A-Line Skirt',
  'Elegant Navy Blue A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00183','Zara',2,2,
  3982,5930,2020,74,21,
  'women,dress,ethnic,western',0,0.35,3.7,193,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00184','Zara',2,2,
  1814,2100,1265,53,13,
  'women,dress,ethnic,western',0,0.35,4.6,285,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black High-Waist Palazzo',
  'Elegant Black High-Waist Palazzo in breathable fabric. Perfect for all occasions.',
  'CLO-00185','Mango',2,2,
  1916,2130,1089,236,20,
  'women,dress,ethnic,western',0,0.35,4.9,246,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White High-Waist Palazzo',
  'Elegant White High-Waist Palazzo in breathable fabric. Perfect for all occasions.',
  'CLO-00186','Mango',2,2,
  1678,2080,999,104,20,
  'women,dress,ethnic,western',0,0.35,3.6,378,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue High-Waist Palazzo',
  'Elegant Navy Blue High-Waist Palazzo in breathable fabric. Perfect for all occasions.',
  'CLO-00187','Zara',2,2,
  3587,4810,1753,81,40,
  'women,dress,ethnic,western',0,0.35,4.0,176,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green High-Waist Palazzo',
  'Elegant Olive Green High-Waist Palazzo in breathable fabric. Perfect for all occasions.',
  'CLO-00188','Zara',2,2,
  3865,5640,2349,204,25,
  'women,dress,ethnic,western',0,0.35,4.4,78,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Straight Kurti',
  'Elegant Black Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00189','Biba',2,2,
  1984,2580,1020,66,40,
  'women,dress,ethnic,western',0,0.35,3.8,169,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Straight Kurti',
  'Elegant White Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00190','Biba',2,2,
  2556,2810,1328,134,26,
  'women,dress,ethnic,western',0,0.35,4.8,68,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Straight Kurti',
  'Elegant Navy Blue Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00191','Biba',2,2,
  1967,2180,1267,39,13,
  'women,dress,ethnic,western',0,0.35,4.4,283,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Straight Kurti',
  'Elegant Olive Green Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00192','Biba',2,2,
  2810,3600,1900,46,21,
  'women,dress,ethnic,western',0,0.35,4.1,75,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Anarkali Kurti',
  'Elegant Black Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00193','W for Woman',2,2,
  3232,4360,1775,286,33,
  'women,dress,ethnic,western',0,0.35,4.8,319,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Anarkali Kurti',
  'Elegant White Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00194','W for Woman',2,2,
  3446,5240,1736,121,36,
  'women,dress,ethnic,western',0,0.35,4.8,77,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Anarkali Kurti',
  'Elegant Navy Blue Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00195','Mango',2,2,
  837,1270,579,183,17,
  'women,dress,ethnic,western',0,0.35,4.9,342,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Anarkali Kurti',
  'Elegant Olive Green Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00196','Biba',2,2,
  3567,4420,1683,215,11,
  'women,dress,ethnic,western',0,0.35,3.6,19,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Athletic Running Shoes',
  'Comfortable and stylish Athletic Running Shoes for everyday wear.',
  'CLO-00197','Nike',2,2,
  4873,6870,2784,146,11,
  'shoes,footwear,casual',0,0.80,3.6,309,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Canvas Sneakers',
  'Comfortable and stylish Canvas Sneakers for everyday wear.',
  'CLO-00198','Bata',2,2,
  6171,6970,3473,267,37,
  'shoes,footwear,casual',0,0.80,4.9,420,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Leather Loafers',
  'Comfortable and stylish Leather Loafers for everyday wear.',
  'CLO-00199','Woodland',2,2,
  5664,8780,2754,162,33,
  'shoes,footwear,casual',0,0.80,4.5,309,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Ankle Chelsea Boots',
  'Comfortable and stylish Ankle Chelsea Boots for everyday wear.',
  'CLO-00200','Nike',2,2,
  1870,2410,906,227,34,
  'shoes,footwear,casual',1,0.80,3.7,264,1);
GO

-- Batch 5/20 (products 201–250)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Slip-On Espadrilles',
  'Comfortable and stylish Slip-On Espadrilles for everyday wear.',
  'CLO-00201','Clarks',2,2,
  4529,5120,2075,128,13,
  'shoes,footwear,casual',0,0.80,3.8,431,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Formal Derby Shoes',
  'Comfortable and stylish Formal Derby Shoes for everyday wear.',
  'CLO-00202','Clarks',2,2,
  4628,5550,2436,6,12,
  'shoes,footwear,casual',0,0.80,4.2,314,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Midnight Library — Paperback',
  'Internationally bestselling book by Matt Haig. This edition features a new introduction by the author.',
  'BOK-00203','Oxford University Press',3,3,
  334,490,209,24,37,
  'fiction,bestseller,novel',0,0.35,4.0,130,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Atomic Habits — Paperback',
  'Internationally bestselling book by James Clear. This edition features a new introduction by the author.',
  'BOK-00204','Pearson',3,3,
  238,320,145,278,37,
  'fiction,bestseller,novel',0,0.35,4.2,297,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Alchemist — Paperback',
  'Internationally bestselling book by Paulo Coelho. This edition features a new introduction by the author.',
  'BOK-00205','HarperCollins',3,3,
  695,1010,486,297,25,
  'fiction,bestseller,novel',0,0.35,4.5,380,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ikigai — Paperback',
  'Internationally bestselling book by Héctor García. This edition features a new introduction by the author.',
  'BOK-00206','Westland Books',3,3,
  206,240,99,41,16,
  'fiction,bestseller,novel',0,0.35,4.5,378,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Psychology of Money — Paperback',
  'Internationally bestselling book by Morgan Housel. This edition features a new introduction by the author.',
  'BOK-00207','Oxford University Press',3,3,
  653,760,438,286,12,
  'fiction,bestseller,novel',0,0.35,4.2,30,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sapiens — Paperback',
  'Internationally bestselling book by Yuval Noah Harari. This edition features a new introduction by the author.',
  'BOK-00208','Rupa Publications',3,3,
  370,450,182,166,30,
  'fiction,bestseller,novel',0,0.35,4.7,155,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rich Dad Poor Dad — Paperback',
  'Internationally bestselling book by Robert Kiyosaki. This edition features a new introduction by the author.',
  'BOK-00209','HarperCollins',3,3,
  316,410,180,255,23,
  'fiction,bestseller,novel',0,0.35,4.7,4,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Power of Now — Paperback',
  'Internationally bestselling book by Eckhart Tolle. This edition features a new introduction by the author.',
  'BOK-00210','Westland Books',3,3,
  640,810,296,248,13,
  'fiction,bestseller,novel',0,0.35,4.7,370,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Think and Grow Rich — Paperback',
  'Internationally bestselling book by Napoleon Hill. This edition features a new introduction by the author.',
  'BOK-00211','Juggernaut',3,3,
  338,440,206,41,10,
  'fiction,bestseller,novel',0,0.35,3.9,299,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00212','Rupa Publications',3,3,
  218,340,104,232,15,
  'fiction,bestseller,novel',0,0.35,4.9,252,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Subtle Art of Not Giving a F*ck — Paperback',
  'Internationally bestselling book by Mark Manson. This edition features a new introduction by the author.',
  'BOK-00213','Penguin Random House',3,3,
  543,620,366,87,37,
  'fiction,bestseller,novel',0,0.35,4.8,231,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Man''s Search for Meaning — Paperback',
  'Internationally bestselling book by Viktor Frankl. This edition features a new introduction by the author.',
  'BOK-00214','Penguin Random House',3,3,
  380,440,182,79,29,
  'fiction,bestseller,novel',0,0.35,4.8,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Educated — Paperback',
  'Internationally bestselling book by Tara Westover. This edition features a new introduction by the author.',
  'BOK-00215','Bloomsbury',3,3,
  644,930,313,227,32,
  'fiction,bestseller,novel',0,0.35,4.5,277,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Becoming — Paperback',
  'Internationally bestselling book by Michelle Obama. This edition features a new introduction by the author.',
  'BOK-00216','Penguin Random House',3,3,
  384,450,244,226,23,
  'fiction,bestseller,novel',0,0.35,4.9,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Book Thief — Paperback',
  'Internationally bestselling book by Markus Zusak. This edition features a new introduction by the author.',
  'BOK-00217','Juggernaut',3,3,
  289,460,139,59,14,
  'fiction,bestseller,novel',0,0.35,4.7,343,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'A Little Life — Paperback',
  'Internationally bestselling book by Hanya Yanagihara. This edition features a new introduction by the author.',
  'BOK-00218','HarperCollins',3,3,
  549,760,272,102,40,
  'fiction,bestseller,novel',0,0.35,4.5,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Normal People — Paperback',
  'Internationally bestselling book by Sally Rooney. This edition features a new introduction by the author.',
  'BOK-00219','Rupa Publications',3,3,
  501,720,227,15,18,
  'fiction,bestseller,novel',0,0.35,3.7,234,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Kite Runner — Paperback',
  'Internationally bestselling book by Khaled Hosseini. This edition features a new introduction by the author.',
  'BOK-00220','Oxford University Press',3,3,
  219,290,152,205,32,
  'fiction,bestseller,novel',1,0.35,4.1,66,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Where the Crawdads Sing — Paperback',
  'Internationally bestselling book by Delia Owens. This edition features a new introduction by the author.',
  'BOK-00221','McGraw Hill',3,3,
  348,470,163,170,25,
  'fiction,bestseller,novel',0,0.35,4.5,272,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'It Ends with Us — Paperback',
  'Internationally bestselling book by Colleen Hoover. This edition features a new introduction by the author.',
  'BOK-00222','Pearson',3,3,
  200,300,112,61,30,
  'fiction,bestseller,novel',0,0.35,3.7,341,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Dune — Paperback',
  'Internationally bestselling book by Frank Herbert. This edition features a new introduction by the author.',
  'BOK-00223','Rupa Publications',3,3,
  305,410,203,211,26,
  'fiction,bestseller,novel',0,0.35,3.5,379,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Project Hail Mary — Paperback',
  'Internationally bestselling book by Andy Weir. This edition features a new introduction by the author.',
  'BOK-00224','Westland Books',3,3,
  217,290,144,74,31,
  'fiction,bestseller,novel',0,0.35,4.9,339,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Martian — Paperback',
  'Internationally bestselling book by Andy Weir. This edition features a new introduction by the author.',
  'BOK-00225','Bloomsbury',3,3,
  672,810,440,9,19,
  'fiction,bestseller,novel',0,0.35,4.4,367,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ready Player One — Paperback',
  'Internationally bestselling book by Ernest Cline. This edition features a new introduction by the author.',
  'BOK-00226','Westland Books',3,3,
  563,840,298,278,40,
  'fiction,bestseller,novel',0,0.35,4.4,257,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hitchhiker''s Guide to the Galaxy — Paperback',
  'Internationally bestselling book by Douglas Adams. This edition features a new introduction by the author.',
  'BOK-00227','Bloomsbury',3,3,
  395,620,255,101,12,
  'fiction,bestseller,novel',0,0.35,3.6,140,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Zero to One — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00228','Juggernaut',3,3,
  762,1070,504,30,28,
  'self-help,business,nonfiction,hardcover',0,0.50,4.1,202,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Lean Startup — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00229','Bloomsbury',3,3,
  611,750,354,108,35,
  'self-help,business,nonfiction,hardcover',0,0.50,4.8,371,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Start with Why — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00230','Bloomsbury',3,3,
  547,840,259,185,30,
  'self-help,business,nonfiction,hardcover',0,0.50,3.7,215,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Good to Great — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00231','Juggernaut',3,3,
  878,1100,466,182,31,
  'self-help,business,nonfiction,hardcover',0,0.50,4.3,440,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Thinking, Fast and Slow — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00232','Bloomsbury',3,3,
  1003,1460,509,15,22,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,230,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Outliers — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00233','Oxford University Press',3,3,
  817,1230,406,66,13,
  'self-help,business,nonfiction,hardcover',0,0.50,4.3,301,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The 4-Hour Work Week — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00234','HarperCollins',3,3,
  846,1200,472,228,11,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,227,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Principles — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00235','Juggernaut',3,3,
  1087,1620,663,299,29,
  'self-help,business,nonfiction,hardcover',0,0.50,4.6,430,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Never Split the Difference — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00236','Westland Books',3,3,
  539,710,251,297,17,
  'self-help,business,nonfiction,hardcover',0,0.50,4.6,230,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Can''t Hurt Me — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00237','McGraw Hill',3,3,
  550,820,378,147,16,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,320,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The 48 Laws of Power — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00238','Juggernaut',3,3,
  620,690,423,154,13,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,203,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Essentialism — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00239','Pearson',3,3,
  729,1060,353,246,33,
  'self-help,business,nonfiction,hardcover',0,0.50,4.5,61,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital Minimalism — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00240','Juggernaut',3,3,
  1055,1530,621,19,28,
  'self-help,business,nonfiction,hardcover',1,0.50,4.3,188,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Flow — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00241','Pearson',3,3,
  622,860,303,237,11,
  'self-help,business,nonfiction,hardcover',0,0.50,4.5,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Grit — Hardcover',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00242','McGraw Hill',3,3,
  898,1160,511,148,16,
  'self-help,business,nonfiction,hardcover',0,0.50,4.8,106,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Clean Code — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00243','O''Reilly / Pearson',3,3,
  1686,2290,785,68,39,
  'programming,technology,reference,textbook',0,0.70,4.3,323,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Design Patterns — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00244','O''Reilly / Pearson',3,3,
  2241,3140,1409,148,29,
  'programming,technology,reference,textbook',0,0.70,4.9,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Pragmatic Programmer — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00245','O''Reilly / Pearson',3,3,
  1915,2280,1074,292,20,
  'programming,technology,reference,textbook',0,0.70,3.8,11,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Structure and Interpretation — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00246','O''Reilly / Pearson',3,3,
  2254,2930,1124,85,23,
  'programming,technology,reference,textbook',0,0.70,4.5,91,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Introduction to Algorithms — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00247','O''Reilly / Pearson',3,3,
  1073,1580,711,48,10,
  'programming,technology,reference,textbook',0,0.70,3.9,426,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'JavaScript: The Good Parts — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00248','O''Reilly / Pearson',3,3,
  2270,2970,1220,31,19,
  'programming,technology,reference,textbook',0,0.70,3.8,377,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'You Don''t Know JS — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00249','O''Reilly / Pearson',3,3,
  1527,1740,718,38,15,
  'programming,technology,reference,textbook',0,0.70,4.3,57,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Python Crash Course — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00250','O''Reilly / Pearson',3,3,
  1270,1790,680,149,19,
  'programming,technology,reference,textbook',0,0.70,4.6,137,1);
GO

-- Batch 6/20 (products 251–300)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Database Design for Mere Mortals — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00251','O''Reilly / Pearson',3,3,
  806,1010,514,140,35,
  'programming,technology,reference,textbook',0,0.70,4.9,301,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'System Design Interview — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00252','O''Reilly / Pearson',3,3,
  1677,2430,1172,234,20,
  'programming,technology,reference,textbook',0,0.70,3.7,35,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cracking the Coding Interview — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00253','O''Reilly / Pearson',3,3,
  663,910,455,68,12,
  'programming,technology,reference,textbook',0,0.70,3.9,49,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The DevOps Handbook — Technical Edition',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00254','O''Reilly / Pearson',3,3,
  1460,2310,775,32,28,
  'programming,technology,reference,textbook',0,0.70,4.8,76,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'NCERT Mathematics Class 10',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00255','McGraw Hill',3,3,
  1553,1790,755,95,18,
  'education,textbook,children,academic',0,0.60,3.6,178,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'NCERT Physics Class 12',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00256','Westland Books',3,3,
  1916,2590,1239,73,29,
  'education,textbook,children,academic',0,0.60,4.6,117,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'NCERT Chemistry Class 11',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00257','HarperCollins',3,3,
  1223,1860,832,65,21,
  'education,textbook,children,academic',0,0.60,3.6,439,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'R.D. Sharma Mathematics',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00258','Oxford University Press',3,3,
  1746,2790,1147,113,11,
  'education,textbook,children,academic',0,0.60,4.2,420,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'S.L. Arora Physics',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00259','Westland Books',3,3,
  1695,2470,995,250,10,
  'education,textbook,children,academic',0,0.60,4.7,415,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Arihant Practice Sets JEE',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00260','HarperCollins',3,3,
  1515,1830,909,273,11,
  'education,textbook,children,academic',1,0.60,4.3,344,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Objective NCERT at Your Fingertips',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00261','Penguin Random House',3,3,
  511,710,309,260,36,
  'education,textbook,children,academic',0,0.60,4.4,443,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MTG Complete NEET Guide',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00262','Rupa Publications',3,3,
  1976,2310,949,238,33,
  'education,textbook,children,academic',0,0.60,5.0,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wren and Martin Grammar',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00263','Penguin Random House',3,3,
  429,510,249,123,26,
  'education,textbook,children,academic',0,0.60,4.6,62,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Oxford Dictionary New Edition',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00264','McGraw Hill',3,3,
  1806,2730,971,36,37,
  'education,textbook,children,academic',0,0.60,4.5,109,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Geronimo Stilton Collection Box',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00265','HarperCollins',3,3,
  1185,1480,799,213,34,
  'education,textbook,children,academic',0,0.60,4.7,105,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wimpy Kid Diary Set',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00266','Penguin Random House',3,3,
  545,740,331,127,12,
  'education,textbook,children,academic',0,0.60,4.0,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Harry Potter Box Set',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00267','Westland Books',3,3,
  560,720,376,20,28,
  'education,textbook,children,academic',0,0.60,4.4,358,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Moleskine Classic Notebook A5',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00268','Moleskine',3,3,
  784,1020,451,166,35,
  'notebook,journal,stationery',0,0.30,3.8,328,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Leuchtturm1917 Bullet Journal',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00269','Moleskine',3,3,
  1368,1890,658,76,15,
  'notebook,journal,stationery',0,0.30,4.7,265,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Paperblanks Flexi Journal',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00270','Rhodia',3,3,
  1180,1530,566,69,19,
  'notebook,journal,stationery',0,0.30,4.8,207,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rhodia Webnotebook',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00271','Rhodia',3,3,
  1669,1890,853,297,40,
  'notebook,journal,stationery',0,0.30,4.7,147,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Life Planner 2025',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00272','Moleskine',3,3,
  878,1120,494,285,29,
  'notebook,journal,stationery',0,0.30,4.5,432,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Ceramic Table Vase',
  'Handcrafted White Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00273','Nilkamal',4,4,
  2182,2490,1013,41,19,
  'vase,decor,living-room',0,0.80,4.0,219,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Ceramic Table Vase',
  'Handcrafted Teal Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00274','Pepperfry',4,4,
  1289,1690,735,159,16,
  'vase,decor,living-room',0,0.80,3.7,431,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Ceramic Table Vase',
  'Handcrafted Beige Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00275','Nilkamal',4,4,
  2468,2890,1719,173,36,
  'vase,decor,living-room',0,0.80,4.1,116,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Ceramic Table Vase',
  'Handcrafted Blush Pink Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00276','The Label Life',4,4,
  2013,2420,1159,228,21,
  'vase,decor,living-room',0,0.80,3.6,154,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rust Brown Ceramic Table Vase',
  'Handcrafted Rust Brown Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00277','HomeTown',4,4,
  1221,1480,621,268,11,
  'vase,decor,living-room',0,0.80,3.8,113,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Glass Flower Vase',
  'Handcrafted White Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00278','Urban Ladder',4,4,
  520,640,285,113,25,
  'vase,decor,living-room',0,0.80,4.7,168,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Glass Flower Vase',
  'Handcrafted Teal Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00279','The Label Life',4,4,
  1622,2190,1089,17,19,
  'vase,decor,living-room',0,0.80,4.8,218,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Glass Flower Vase',
  'Handcrafted Beige Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00280','HomeTown',4,4,
  694,1050,432,292,21,
  'vase,decor,living-room',1,0.80,3.6,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Glass Flower Vase',
  'Handcrafted Blush Pink Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00281','Pepperfry',4,4,
  2028,2980,1058,168,34,
  'vase,decor,living-room',0,0.80,4.0,426,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rust Brown Glass Flower Vase',
  'Handcrafted Rust Brown Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00282','Pepperfry',4,4,
  2193,3110,1102,73,23,
  'vase,decor,living-room',0,0.80,4.9,52,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Rattan Woven Vase',
  'Handcrafted White Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00283','Nilkamal',4,4,
  1212,1550,569,123,25,
  'vase,decor,living-room',0,0.80,3.9,209,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Rattan Woven Vase',
  'Handcrafted Teal Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00284','Home Centre',4,4,
  1554,1960,1041,47,30,
  'vase,decor,living-room',0,0.80,3.7,152,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Rattan Woven Vase',
  'Handcrafted Beige Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00285','IKEA',4,4,
  2108,3370,1466,132,13,
  'vase,decor,living-room',0,0.80,3.9,270,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Rattan Woven Vase',
  'Handcrafted Blush Pink Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00286','HomeTown',4,4,
  959,1170,545,155,18,
  'vase,decor,living-room',0,0.80,5.0,200,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rust Brown Rattan Woven Vase',
  'Handcrafted Rust Brown Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00287','HomeTown',4,4,
  1601,2560,861,189,12,
  'vase,decor,living-room',0,0.80,4.6,287,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Terracotta Vase Set',
  'Handcrafted White Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00288','Home Centre',4,4,
  1827,2900,1270,50,18,
  'vase,decor,living-room',0,0.80,4.6,56,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Terracotta Vase Set',
  'Handcrafted Teal Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00289','Home Centre',4,4,
  1053,1240,616,102,23,
  'vase,decor,living-room',0,0.80,5.0,317,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Terracotta Vase Set',
  'Handcrafted Beige Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00290','Home Centre',4,4,
  2304,2970,1243,126,19,
  'vase,decor,living-room',0,0.80,4.3,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Terracotta Vase Set',
  'Handcrafted Blush Pink Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00291','IKEA',4,4,
  1524,1910,1015,29,26,
  'vase,decor,living-room',0,0.80,4.7,391,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rust Brown Terracotta Vase Set',
  'Handcrafted Rust Brown Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00292','Urban Ladder',4,4,
  2091,2550,1277,133,40,
  'vase,decor,living-room',0,0.80,4.1,89,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rose Scented Soy Candle Set',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00293','Iris',4,4,
  1340,1890,618,248,14,
  'candle,aroma,wellness,gifting',0,0.40,4.9,87,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sandalwood Reed Diffuser Set',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00294','Yankee Candle',4,4,
  595,890,367,167,19,
  'candle,aroma,wellness,gifting',0,0.40,4.2,93,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sandalwood Aromatherapy Candle Jar',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00295','Candlescapes',4,4,
  385,480,253,232,17,
  'candle,aroma,wellness,gifting',0,0.40,4.7,379,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Eucalyptus Beeswax Pillar Candle',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00296','Candlescapes',4,4,
  1318,1990,822,235,20,
  'candle,aroma,wellness,gifting',0,0.40,4.8,314,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vanilla Flameless LED Candle Set',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00297','Iris',4,4,
  725,1070,427,13,35,
  'candle,aroma,wellness,gifting',0,0.40,4.0,293,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Geometric Wall Clock',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00298','Urban Ladder',4,4,
  1543,2310,765,101,20,
  'clock,wall-decor,living-room',0,1.20,4.9,73,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wooden Antique Clock',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00299','IKEA',4,4,
  3101,3630,1938,95,40,
  'clock,wall-decor,living-room',0,1.20,4.3,241,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Minimalist Wall Clock',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00300','Nilkamal',4,4,
  2104,2970,1430,130,19,
  'clock,wall-decor,living-room',1,1.20,5.0,227,1);
GO

-- Batch 7/20 (products 301–350)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital LED Clock',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00301','Home Centre',4,4,
  3545,3930,2059,90,24,
  'clock,wall-decor,living-room',0,1.20,4.2,135,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Marble Effect Wall Clock',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00302','IKEA',4,4,
  1198,1670,588,15,35,
  'clock,wall-decor,living-room',0,1.20,4.5,272,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Wall Tapestry',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00303','IKEA',4,4,
  447,630,268,58,31,
  'wall-decor,art,living-room,bedroom',0,0.60,5.0,420,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Macramé Wall Hanging',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00304','The Label Life',4,4,
  2315,3660,1524,91,16,
  'wall-decor,art,living-room,bedroom',0,0.60,4.3,387,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Canvas Abstract Art Print',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00305','HomeTown',4,4,
  2270,2840,1414,24,37,
  'wall-decor,art,living-room,bedroom',0,0.60,4.2,304,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wooden Wall Shelf Floating',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00306','Nilkamal',4,4,
  1981,2710,1020,240,18,
  'wall-decor,art,living-room,bedroom',0,0.60,4.6,263,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hexagonal Mirror Set',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00307','Pepperfry',4,4,
  2720,3070,1456,280,32,
  'wall-decor,art,living-room,bedroom',0,0.60,3.6,256,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gallery Wall Frame Set',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00308','Nilkamal',4,4,
  2020,2750,1118,64,37,
  'wall-decor,art,living-room,bedroom',0,0.60,4.8,394,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Motivational Poster Set A3',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00309','The Label Life',4,4,
  1589,1860,1068,233,40,
  'wall-decor,art,living-room,bedroom',0,0.60,4.5,310,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Monstera Artificial Plant',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00310','Ugaoo',4,4,
  342,440,223,125,39,
  'plants,indoor,decor,greenery',0,0.50,4.5,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Succulent Arrangement Pot',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00311','Nurserylive',4,4,
  1531,1840,823,41,39,
  'plants,indoor,decor,greenery',0,0.50,3.8,377,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bamboo Desktop Plant',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00312','Nurserylive',4,4,
  1906,2400,1200,26,34,
  'plants,indoor,decor,greenery',0,0.50,4.5,299,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Air Plant Tillandsia Set',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00313','Ugaoo',4,4,
  2599,4080,1436,181,28,
  'plants,indoor,decor,greenery',0,0.50,4.2,316,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ceramic Planter with Stand',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00314','Nurserylive',4,4,
  1563,2300,958,62,11,
  'plants,indoor,decor,greenery',0,0.50,3.6,138,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cotton Throw Blanket',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00315','The Label Life',4,4,
  2244,3160,1438,163,28,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.9,37,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knitted Chunky Throw',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00316','Home Centre',4,4,
  2417,3530,1355,294,38,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,3.8,199,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sherpa Fleece Throw',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00317','Urban Ladder',4,4,
  1088,1560,707,132,10,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.9,255,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Linen Cushion Cover Set 5',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00318','Urban Ladder',4,4,
  2593,3340,1376,143,20,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.3,65,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Velvet Cushion Cover Pack',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00319','IKEA',4,4,
  5687,8810,2999,80,35,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.6,403,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00320','Nilkamal',4,4,
  4484,5200,2333,201,32,
  'soft-furnishing,living-room,bedroom,textile',1,1.00,3.7,274,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jute Braided Rug',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00321','Pepperfry',4,4,
  2492,3810,1581,96,13,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.1,70,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shaggy Bedroom Rug',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00322','HomeTown',4,4,
  1036,1300,552,237,34,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.1,336,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bamboo Tray Decorative',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00323','IKEA',4,4,
  1618,2480,1014,271,27,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.9,357,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wicker Basket Set 3',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00324','Pepperfry',4,4,
  4439,6970,2564,108,10,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,3.8,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Photo Frame Collage 6-in-1',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00325','Ikea',4,4,
  544,860,348,256,16,
  'photo-frame,decor,gifting',0,0.40,4.3,364,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bamboo Photo Frame A4',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00326','Furlenco',4,4,
  1180,1820,635,25,30,
  'photo-frame,decor,gifting',0,0.40,3.8,438,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00327','Furlenco',4,4,
  816,990,529,217,10,
  'photo-frame,decor,gifting',0,0.40,3.7,187,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Instax Mini Frame Set',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00328','Ikea',4,4,
  1362,1730,654,174,18,
  'photo-frame,decor,gifting',0,0.40,4.1,262,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 750W 2J',
  '2-jar mixer grinder with Mixer Grinder 750W motor. SS blades, 5-year warranty.',
  'APL-00329','Bajaj',5,8,
  2768,3540,1508,198,11,
  'kitchen,mixer,grinder',0,4.50,4.9,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 750W 3J',
  '3-jar mixer grinder with Mixer Grinder 750W motor. SS blades, 5-year warranty.',
  'APL-00330','Inalsa',5,8,
  3408,4770,1902,26,30,
  'kitchen,mixer,grinder',0,4.50,4.6,198,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 750W 4J',
  '4-jar mixer grinder with Mixer Grinder 750W motor. SS blades, 5-year warranty.',
  'APL-00331','Philips',5,8,
  5909,8330,3552,123,36,
  'kitchen,mixer,grinder',0,4.50,4.6,129,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 2J',
  '2-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00332','Bajaj',5,8,
  5055,6930,2891,232,38,
  'kitchen,mixer,grinder',0,4.50,4.6,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 3J',
  '3-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00333','Philips',5,8,
  5753,7590,3424,248,16,
  'kitchen,mixer,grinder',0,4.50,3.6,270,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 4J',
  '4-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00334','Prestige',5,8,
  5016,7670,2918,93,35,
  'kitchen,mixer,grinder',0,4.50,4.3,185,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 2J',
  '2-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00335','Inalsa',5,8,
  2810,3960,1733,258,14,
  'kitchen,mixer,grinder',0,4.50,4.9,108,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 3J',
  '3-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00336','Prestige',5,8,
  4591,7120,2505,198,34,
  'kitchen,mixer,grinder',0,4.50,4.9,82,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 4J',
  '4-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00337','Bajaj',5,8,
  5285,6390,3227,279,40,
  'kitchen,mixer,grinder',0,4.50,4.7,367,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Air Fryer 4L',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00338','Havells',5,8,
  8009,11530,3979,69,20,
  'air-fryer,kitchen,healthy-cooking',0,3.50,4.1,289,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Air Fryer 5.5L',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00339','Philips',5,8,
  4679,6780,3038,226,33,
  'air-fryer,kitchen,healthy-cooking',0,3.50,3.5,41,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Dual Basket Air Fryer 8L',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00340','Inalsa',5,8,
  9353,11690,5645,121,25,
  'air-fryer,kitchen,healthy-cooking',1,3.50,3.8,421,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Induction Cooktop 2000W',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00341','LG',5,8,
  10989,16700,6623,117,32,
  'kitchen,cooking,countertop',0,2.00,3.5,258,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Cooktop Dual Burner',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00342','Whirlpool',5,8,
  13873,19980,8641,245,12,
  'kitchen,cooking,countertop',0,2.00,4.7,215,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00343','Havells',5,8,
  10104,12530,5411,58,26,
  'kitchen,cooking,countertop',0,2.00,4.3,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 40L',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00344','Philips',5,8,
  833,1260,565,248,36,
  'kitchen,cooking,countertop',0,2.00,4.3,61,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Solo 20L',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00345','Inalsa',5,8,
  10616,12100,4942,85,21,
  'kitchen,cooking,countertop',0,2.00,4.9,17,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Convection 28L',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00346','Bajaj',5,8,
  7939,9370,3971,139,24,
  'kitchen,cooking,countertop',0,2.00,5.0,297,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sandwich Maker Grill',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00347','IFB',5,8,
  8883,13500,6140,283,14,
  'kitchen,cooking,countertop',0,2.00,4.9,83,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Waffle Maker',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00348','LG',5,8,
  11812,18430,6771,231,23,
  'kitchen,cooking,countertop',0,2.00,4.7,172,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Kettle 1.7L',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00349','Bajaj',5,8,
  6016,7820,3558,60,20,
  'kitchen,cooking,countertop',0,2.00,3.8,200,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'French Press Coffee Maker',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00350','IFB',5,8,
  4922,7240,3089,121,33,
  'kitchen,cooking,countertop',0,2.00,4.4,253,1);
GO

-- Batch 8/20 (products 351–400)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Drip Coffee Machine',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00351','Havells',5,8,
  11602,18560,7289,215,27,
  'kitchen,cooking,countertop',0,2.00,4.6,420,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Espresso Machine Semi-Auto',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00352','Morphy Richards',5,8,
  4979,5970,3078,294,39,
  'kitchen,cooking,countertop',0,2.00,3.7,151,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ceiling Fan 1200mm Midnight Black',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00353','Usha',5,8,
  5284,7340,2728,66,18,
  'fan,cooling,home',0,3.50,3.6,106,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pedestal Fan 400mm White',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00354','Bajaj',5,8,
  6383,7720,3456,255,14,
  'fan,cooling,home',0,3.50,4.8,320,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tower Fan 55" White',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00355','Usha',5,8,
  6354,7240,3295,136,19,
  'fan,cooling,home',0,3.50,4.9,289,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wall Fan 300mm White',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00356','Havells',5,8,
  1139,1570,774,168,31,
  'fan,cooling,home',0,3.50,3.6,165,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00357','Usha',5,8,
  6931,8110,3964,157,31,
  'fan,cooling,home',0,3.50,3.9,82,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Room Heater 2000W',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00358','Morphy Richards',5,8,
  7542,10180,5131,214,19,
  'heater,winter,home',0,2.80,4.0,392,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Oil-Filled Radiator 11-Fin',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00359','Havells',5,8,
  4716,6980,2236,218,24,
  'heater,winter,home',0,2.80,4.8,192,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Halogen Room Heater',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00360','Usha',5,8,
  5823,7340,3259,284,31,
  'heater,winter,home',1,2.80,4.3,216,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tower Room Heater PTC',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00361','Usha',5,8,
  3103,4160,1599,116,36,
  'heater,winter,home',0,2.80,4.9,138,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Water Purifier RO+UV 7L',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00362','Pureit',5,8,
  14143,20080,7352,113,36,
  'water-purifier,kitchen,health',0,6.00,3.7,146,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Water Purifier RO+UV+UF 10L',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00363','Havells',5,8,
  9131,14430,5034,20,27,
  'water-purifier,kitchen,health',0,6.00,4.4,210,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gravity Water Purifier 15L',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00364','Aquaguard',5,8,
  8026,9710,5253,195,37,
  'water-purifier,kitchen,health',0,6.00,3.9,16,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Front Load Washing Machine 7kg',
  'IntelliWash technology with 15 wash programs and in-built heater.',
  'APL-00365','Samsung',5,8,
  43080,56000,23825,169,17,
  'washing-machine,laundry,home',0,65.0,4.8,214,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Top Load Washing Machine 6.5kg',
  'IntelliWash technology with 15 wash programs and in-built heater.',
  'APL-00366','IFB',5,8,
  21739,30000,10869,104,14,
  'washing-machine,laundry,home',0,65.0,3.7,191,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Semi-Automatic 8kg',
  'IntelliWash technology with 15 wash programs and in-built heater.',
  'APL-00367','IFB',5,8,
  44923,70530,23454,234,29,
  'washing-machine,laundry,home',0,65.0,3.9,357,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fully Automatic 8kg',
  'IntelliWash technology with 15 wash programs and in-built heater.',
  'APL-00368','Whirlpool',5,8,
  35717,53580,21791,28,31,
  'washing-machine,laundry,home',0,65.0,3.9,309,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vacuum Cleaner 2200W',
  'Powerful suction with HEPA filtration — removes allergens and fine dust.',
  'APL-00369','Inalsa',5,8,
  7234,11360,3898,125,13,
  'vacuum,cleaning,home',0,3.00,3.7,417,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Robot Vacuum Cleaner',
  'Powerful suction with HEPA filtration — removes allergens and fine dust.',
  'APL-00370','Eureka Forbes',5,8,
  4048,6070,1969,256,30,
  'vacuum,cleaning,home',0,3.00,4.1,154,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet & Dry Vacuum 30L',
  'Powerful suction with HEPA filtration — removes allergens and fine dust.',
  'APL-00371','Inalsa',5,8,
  3638,5020,1693,129,29,
  'vacuum,cleaning,home',0,3.00,3.6,239,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Handheld Cordless Vacuum',
  'Powerful suction with HEPA filtration — removes allergens and fine dust.',
  'APL-00372','Inalsa',5,8,
  22599,27340,14944,172,35,
  'vacuum,cleaning,home',0,3.00,4.1,430,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Steam Iron 2400W',
  'Non-stick soleplate with auto temperature control. 360° cord rotation.',
  'APL-00373','Usha',5,8,
  2486,2860,1578,164,22,
  'iron,laundry,home',0,1.10,4.0,313,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Dry Iron 1100W',
  'Non-stick soleplate with auto temperature control. 360° cord rotation.',
  'APL-00374','Bajaj',5,8,
  1635,2040,929,106,28,
  'iron,laundry,home',0,1.10,3.9,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Garment Steamer 1500W',
  'Non-stick soleplate with auto temperature control. 360° cord rotation.',
  'APL-00375','Bajaj',5,8,
  579,680,347,128,37,
  'iron,laundry,home',0,1.10,4.0,432,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Adjustable Dumbbell Set 20kg',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00376','Vector X',6,5,
  1256,1650,754,71,25,
  'dumbbell,weights,strength',0,10.0,4.8,430,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 5kg',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00377','Kobo',6,5,
  2304,2630,1514,136,16,
  'dumbbell,weights,strength',0,10.0,4.7,369,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 10kg',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00378','Adidas',6,5,
  4043,4690,2132,234,31,
  'dumbbell,weights,strength',0,10.0,4.4,6,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 15kg',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00379','Adidas',6,5,
  3207,4460,2222,213,16,
  'dumbbell,weights,strength',0,10.0,4.6,163,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Neoprene Dumbbell Set 3kg',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00380','Adidas',6,5,
  3584,4950,1951,154,10,
  'dumbbell,weights,strength',1,10.0,4.6,375,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cast Iron Dumbbell 7.5kg Pair',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00381','Boldfit',6,5,
  7007,9110,4304,115,30,
  'dumbbell,weights,strength',0,10.0,4.6,435,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Barbell Rod 6ft Olympic',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00382','Boldfit',6,5,
  4780,6640,2749,187,26,
  'barbell,weights,powerlifting',0,7.00,4.1,120,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'EZ Curl Bar',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00383','Nike',6,5,
  5780,8270,2790,86,12,
  'barbell,weights,powerlifting',0,7.00,4.9,299,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tricep Bar',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00384','Nike',6,5,
  1474,2120,856,176,11,
  'barbell,weights,powerlifting',0,7.00,4.7,242,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 5kg Pair',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00385','RitFit',6,5,
  4397,6600,2443,147,32,
  'barbell,weights,powerlifting',0,7.00,4.1,265,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 10kg Pair',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00386','Nike',6,5,
  10702,16910,5464,99,33,
  'barbell,weights,powerlifting',0,7.00,4.0,87,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 20kg Pair',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00387','Nike',6,5,
  4508,6490,2425,35,38,
  'barbell,weights,powerlifting',0,7.00,3.8,36,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Barbell Collar Clamp',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00388','Boldfit',6,5,
  1349,1850,684,176,19,
  'barbell,weights,powerlifting',0,7.00,4.2,420,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Resistance Band Set 5pcs',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00389','Boldfit',6,5,
  1068,1580,597,229,21,
  'resistance-band,stretching,yoga,home-workout',0,0.50,3.6,210,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull-Up Assist Band',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00390','Decathlon',6,5,
  603,920,337,94,17,
  'resistance-band,stretching,yoga,home-workout',0,0.50,3.8,434,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Loop Resistance Band 4pcs',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00391','Decathlon',6,5,
  1289,1830,790,88,20,
  'resistance-band,stretching,yoga,home-workout',0,0.50,4.5,325,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Figure 8 Resistance Band',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00392','Boldfit',6,5,
  420,540,232,85,25,
  'resistance-band,stretching,yoga,home-workout',0,0.50,4.2,394,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fabric Hip Band Set',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00393','Fit Simplify',6,5,
  356,410,215,10,31,
  'resistance-band,stretching,yoga,home-workout',0,0.50,4.9,142,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 6mm NBR',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00394','Strauss',6,5,
  1127,1420,607,281,25,
  'yoga-mat,yoga,pilates,exercise',0,1.20,3.8,119,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 4mm TPE',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00395','Decathlon',6,5,
  1021,1290,512,38,27,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.9,443,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Non-Slip Yoga Mat 5mm',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00396','Kobo',6,5,
  2503,3580,1335,201,11,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.5,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Foam Exercise Mat',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00397','Strauss',6,5,
  2869,3390,1347,138,11,
  'yoga-mat,yoga,pilates,exercise',0,1.20,3.8,174,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Interlocking Foam Floor Tiles 6pcs',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00398','Decathlon',6,5,
  889,1140,459,191,15,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.9,276,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 1kg Chocolate',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00399','MyProtein',6,5,
  1609,2240,740,56,37,
  'supplements,protein,nutrition,fitness',0,1.00,3.5,332,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 2kg Vanilla',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00400','MuscleBlaze',6,5,
  4319,6350,2994,41,22,
  'supplements,protein,nutrition,fitness',1,1.00,3.9,171,1);
GO

-- Batch 9/20 (products 401–450)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mass Gainer 3kg',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00401','MyProtein',6,5,
  739,1060,407,210,30,
  'supplements,protein,nutrition,fitness',0,1.00,3.6,335,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'BCAA 250g Watermelon',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00402','Dymatize',6,5,
  3768,5090,2614,34,26,
  'supplements,protein,nutrition,fitness',0,1.00,4.7,264,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Creatine Monohydrate 300g',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00403','HealthKart',6,5,
  786,970,439,49,37,
  'supplements,protein,nutrition,fitness',0,1.00,4.9,43,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pre-Workout 300g',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00404','Optimum Nutrition',6,5,
  1347,1540,862,66,23,
  'supplements,protein,nutrition,fitness',0,1.00,4.5,165,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Multivitamin for Men 60 tabs',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00405','MuscleBlaze',6,5,
  3288,4730,1900,293,36,
  'supplements,protein,nutrition,fitness',0,1.00,4.9,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Omega-3 Capsules 90pcs',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00406','MyProtein',6,5,
  3658,5340,2237,93,23,
  'supplements,protein,nutrition,fitness',0,1.00,4.2,418,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ab Roller Wheel',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00407','Boldfit',6,5,
  2258,3340,1568,279,15,
  'gym-accessory,fitness,workout',0,0.60,4.9,403,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull-Up Bar Doorway',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00408','RitFit',6,5,
  1464,1950,707,14,16,
  'gym-accessory,fitness,workout',0,0.60,4.8,157,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Push-Up Handles Rotating',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00409','Nike',6,5,
  380,520,256,93,28,
  'gym-accessory,fitness,workout',0,0.60,3.7,382,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Foam Roller 60cm',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00410','RitFit',6,5,
  965,1110,484,156,27,
  'gym-accessory,fitness,workout',0,0.60,4.5,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Massage Ball Lacrosse',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00411','Nike',6,5,
  2392,3660,1591,240,16,
  'gym-accessory,fitness,workout',0,0.60,3.7,103,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jump Rope Speed Cable',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00412','Decathlon',6,5,
  1444,1650,995,118,19,
  'gym-accessory,fitness,workout',0,0.60,4.6,357,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gym Gloves Padded',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00413','Nike',6,5,
  1305,1840,638,289,25,
  'gym-accessory,fitness,workout',0,0.60,4.7,199,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Wraps Support',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00414','RitFit',6,5,
  1625,2580,868,206,22,
  'gym-accessory,fitness,workout',0,0.60,3.7,215,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00415','Nike',6,5,
  920,1440,448,107,11,
  'gym-accessory,fitness,workout',0,0.60,3.5,51,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weightlifting Belt Leather',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00416','Adidas',6,5,
  835,1260,576,123,29,
  'gym-accessory,fitness,workout',0,0.60,3.5,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ankle Weights 5kg Pair',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00417','Kobo',6,5,
  452,630,212,138,32,
  'gym-accessory,fitness,workout',0,0.60,4.0,40,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Adjustable Weight Bench',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00418','PowerFit',6,5,
  24209,37280,13856,65,24,
  'gym-equipment,cardio,strength,home-gym',0,25.0,3.7,12,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folding Treadmill 3HP',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00419','Lifeline',6,5,
  23500,36660,14372,134,37,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.9,134,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Stationary Bike Magnetic',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00420','PowerFit',6,5,
  22334,28810,11051,5,29,
  'gym-equipment,cardio,strength,home-gym',1,25.0,4.4,80,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rowing Machine Air',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00421','Kobo',6,5,
  12351,16300,8193,287,37,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.5,57,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull-Up Station Multi-Grip',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00422','Kobo',6,5,
  46223,58700,22960,208,34,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.5,416,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Power Rack Half Rack',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00423','Body Solid',6,5,
  42984,61040,23693,119,36,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.0,366,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00424','Gunn & Moore',7,7,
  7153,10300,4391,266,10,
  'cricket,bat,outdoor',0,1.20,4.5,358,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'English Willow Cricket Bat Grade 1',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00425','SS',7,7,
  2037,2970,1318,229,40,
  'cricket,bat,outdoor',0,1.20,4.3,349,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Ball Cricket Bat Tape',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00426','Kookaburra',7,7,
  7762,11640,4807,214,11,
  'cricket,bat,outdoor',0,1.20,4.3,428,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Bat Cover Full Length',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00427','Gunn & Moore',7,7,
  2644,4070,1472,190,38,
  'cricket,bat,outdoor',0,1.20,4.0,272,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'SG Cricket Ball Red Leather',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00428','SS',7,7,
  1933,2320,1061,289,27,
  'cricket,gear,protective',0,0.80,4.6,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kookaburra Pink Ball',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00429','Kookaburra',7,7,
  2577,3090,1297,222,15,
  'cricket,gear,protective',0,0.80,4.5,261,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Helmet Senior',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00430','Kookaburra',7,7,
  647,720,406,44,35,
  'cricket,gear,protective',0,0.80,3.8,265,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Batting Gloves',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00431','Kookaburra',7,7,
  3069,3740,1797,41,17,
  'cricket,gear,protective',0,0.80,4.0,38,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Batting Pads',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00432','SG',7,7,
  3683,4640,1795,295,20,
  'cricket,gear,protective',0,0.80,4.6,11,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Wicket Keeping Gloves',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00433','SS',7,7,
  5995,7670,3166,295,32,
  'cricket,gear,protective',0,0.80,3.5,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Thigh Guard',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00434','SS',7,7,
  1932,2980,1042,289,27,
  'cricket,gear,protective',0,0.80,4.6,352,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Chest Guard',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00435','SG',7,7,
  2271,3180,1060,69,23,
  'cricket,gear,protective',0,0.80,4.7,164,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Kitbag Wheelie',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00436','SS',7,7,
  961,1430,647,212,17,
  'cricket,gear,protective',0,0.80,4.2,405,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'FIFA Quality Pro Football',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00437','Cosco',7,7,
  2527,3390,1358,270,36,
  'football,soccer,outdoor',0,0.45,3.9,218,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Futsal Ball Size 4',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00438','Nivia',7,7,
  1321,1520,712,220,33,
  'football,soccer,outdoor',0,0.45,3.8,34,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Goalkeeper Gloves',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00439','Cosco',7,7,
  1287,1480,724,260,21,
  'football,soccer,outdoor',0,0.45,3.7,185,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Shin Guards',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00440','Nivia',7,7,
  3786,5300,2318,256,29,
  'football,soccer,outdoor',1,0.45,4.3,236,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00441','Puma',7,7,
  590,820,319,35,13,
  'football,soccer,outdoor',0,0.45,4.5,15,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Badminton Racket Graphite',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00442','Victor',7,7,
  369,550,194,282,29,
  'badminton,racket,sport',0,0.25,4.0,155,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shuttlecock Feather 6pcs',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00443','Apacs',7,7,
  747,840,385,30,39,
  'badminton,racket,sport',0,0.25,3.6,306,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shuttlecock Nylon 6pcs',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00444','Yonex',7,7,
  4963,6650,3333,214,40,
  'badminton,racket,sport',0,0.25,4.2,21,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Badminton Bag Backpack',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00445','Victor',7,7,
  1757,2070,1115,216,29,
  'badminton,racket,sport',0,0.25,4.3,382,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Badminton Net Standard',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00446','Yonex',7,7,
  4217,5520,2075,290,12,
  'badminton,racket,sport',0,0.25,4.7,224,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Grip Tape 3pcs',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00447','Apacs',7,7,
  3681,4600,2576,258,36,
  'badminton,racket,sport',0,0.25,3.8,91,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Racket Beginner',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00448','Head',7,7,
  2608,2970,1725,279,21,
  'tennis,table-tennis,racket',0,0.30,4.8,160,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Balls 3 Tin',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00449','Stiga',7,7,
  4543,7090,2465,54,20,
  'tennis,table-tennis,racket',0,0.30,4.1,26,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Bat Set',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00450','Wilson',7,7,
  3626,4610,2324,216,12,
  'tennis,table-tennis,racket',0,0.30,3.5,362,1);
GO

-- Batch 10/20 (products 451–500)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Balls 40mm 6pcs',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00451','Decathlon',7,7,
  628,910,292,248,36,
  'tennis,table-tennis,racket',0,0.30,3.9,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ping Pong Net & Post',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00452','Butterfly',7,7,
  6623,7420,4030,37,10,
  'tennis,table-tennis,racket',0,0.30,4.0,217,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Basketball Size 7 Indoor',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00453','Cosco',7,7,
  2651,3050,1680,226,27,
  'basketball,volleyball,outdoor',0,0.65,4.2,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Basketball Size 5',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00454','Mikasa',7,7,
  5875,8750,3659,100,28,
  'basketball,volleyball,outdoor',0,0.65,4.0,20,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Volleyball Mikasa',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00455','Cosco',7,7,
  3172,4920,2200,179,26,
  'basketball,volleyball,outdoor',0,0.65,4.5,208,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Basketball Hoop Portable',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00456','Mikasa',7,7,
  725,990,461,266,24,
  'basketball,volleyball,outdoor',0,0.65,5.0,28,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Volleyball Net Standard',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00457','Mikasa',7,7,
  8695,13040,4343,249,19,
  'basketball,volleyball,outdoor',0,0.65,4.0,43,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bicycle Helmet Adult',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00458','Decathlon',7,7,
  3222,4350,1901,136,29,
  'cycling,skating,outdoor,safety',0,0.50,4.2,115,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Pads Skating Set',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00459','Scott',7,7,
  2368,3480,1261,224,16,
  'cycling,skating,outdoor,safety',0,0.50,3.6,419,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Inline Skates Adult',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00460','Trek',7,7,
  2381,3620,1536,51,15,
  'cycling,skating,outdoor,safety',1,0.50,3.6,302,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cycling Gloves Padded',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00461','Trek',7,7,
  2768,4120,1854,63,12,
  'cycling,skating,outdoor,safety',0,0.50,4.9,15,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cycle Water Bottle Cage',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00462','Btwin',7,7,
  3573,3930,1974,78,18,
  'cycling,skating,outdoor,safety',0,0.50,4.4,302,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Swimming Goggles Anti-Fog',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00463','Speedo',7,7,
  563,630,383,86,18,
  'swimming,pool,sport',0,0.20,4.9,422,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Silicone Swim Cap',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00464','Speedo',7,7,
  1193,1380,703,290,35,
  'swimming,pool,sport',0,0.20,4.5,301,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kickboard Swimming',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00465','Speedo',7,7,
  1772,2390,1207,243,40,
  'swimming,pool,sport',0,0.20,3.9,171,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull Buoy Float',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00466','Arena',7,7,
  2416,2970,1641,257,15,
  'swimming,pool,sport',0,0.20,3.5,424,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Swimming Fins Fins Pair',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00467','Decathlon',7,7,
  624,950,411,10,35,
  'swimming,pool,sport',0,0.20,4.4,190,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vitamin C 1000mg 60 Tablets',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00468','Cipla OTC',8,6,
  1412,1570,728,219,20,
  'vitamins,supplements,health,nutrition',0,0.15,3.7,320,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vitamin D3 2000 IU 90 Capsules',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00469','Dr. Morepen',8,6,
  810,1220,504,185,16,
  'vitamins,supplements,health,nutrition',0,0.15,4.7,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vitamin B12 500mcg 60 Tabs',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00470','Himalaya',8,6,
  1156,1570,766,196,11,
  'vitamins,supplements,health,nutrition',0,0.15,4.8,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Biotin 10000mcg 60 Caps',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00471','Cipla OTC',8,6,
  401,620,223,106,14,
  'vitamins,supplements,health,nutrition',0,0.15,4.6,268,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Zinc 50mg 90 Tablets',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00472','Setu',8,6,
  683,870,414,270,18,
  'vitamins,supplements,health,nutrition',0,0.15,3.7,37,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Magnesium 400mg 60 Caps',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00473','Setu',8,6,
  601,790,377,94,18,
  'vitamins,supplements,health,nutrition',0,0.15,3.7,73,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Iron 45mg + Vitamin C 60 Tabs',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00474','Himalaya',8,6,
  1060,1390,641,75,35,
  'vitamins,supplements,health,nutrition',0,0.15,4.6,218,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Calcium + D3 60 Tablets',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00475','Dr. Morepen',8,6,
  548,680,342,21,18,
  'vitamins,supplements,health,nutrition',0,0.15,4.8,338,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folic Acid 5mg 30 Tablets',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00476','Patanjali',8,6,
  1227,1570,713,90,27,
  'vitamins,supplements,health,nutrition',0,0.15,3.8,364,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vitamin E 400 IU 30 Softgels',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00477','Cipla OTC',8,6,
  290,410,152,54,24,
  'vitamins,supplements,health,nutrition',0,0.15,5.0,192,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'CoQ10 100mg 30 Capsules',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00478','Patanjali',8,6,
  637,1000,389,102,29,
  'vitamins,supplements,health,nutrition',0,0.15,3.6,11,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fish Oil Omega-3 1000mg 90 Softgels',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00479','Setu',8,6,
  1478,1860,1023,249,36,
  'vitamins,supplements,health,nutrition',0,0.15,3.8,365,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Probiotics 50 Billion CFU 30 Caps',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00480','Cipla OTC',8,6,
  1366,1640,630,285,31,
  'vitamins,supplements,health,nutrition',1,0.15,4.2,225,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ashwagandha KSM-66 500mg 60 Caps',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00481','Patanjali',8,6,
  807,1110,512,192,30,
  'vitamins,supplements,health,nutrition',0,0.15,4.2,75,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Turmeric Curcumin 500mg 60 Tabs',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00482','Dabur',8,6,
  362,570,238,170,36,
  'vitamins,supplements,health,nutrition',0,0.15,4.7,62,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Moringa 500mg 60 Capsules',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00483','HealthKart',8,6,
  1446,1660,850,190,39,
  'vitamins,supplements,health,nutrition',0,0.15,4.9,46,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Antiseptic Cream 20g',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00484','Himalaya',8,6,
  638,850,296,233,32,
  'otc,skincare,first-aid,health',0,0.12,4.7,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Antifungal Cream 15g',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00485','Patanjali',8,6,
  627,950,438,34,39,
  'otc,skincare,first-aid,health',0,0.12,3.7,27,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Moisturising Lotion 200ml',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00486','Cipla OTC',8,6,
  521,640,249,125,12,
  'otc,skincare,first-aid,health',0,0.12,4.4,113,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sunscreen SPF 50 100ml',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00487','Manforce',8,6,
  183,270,90,128,26,
  'otc,skincare,first-aid,health',0,0.12,4.9,268,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Lip Balm SPF 30',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00488','Manforce',8,6,
  534,630,306,123,13,
  'otc,skincare,first-aid,health',0,0.12,4.0,54,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cold Relief Balm 50g',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00489','Patanjali',8,6,
  226,270,135,29,32,
  'otc,skincare,first-aid,health',0,0.12,4.0,54,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Muscle Pain Relief Gel 100g',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00490','Boroline',8,6,
  381,580,232,140,31,
  'otc,skincare,first-aid,health',0,0.12,4.5,341,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Herbal Cough Syrup 200ml',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00491','Boroline',8,6,
  526,680,310,99,14,
  'otc,skincare,first-aid,health',0,0.12,3.6,115,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Glucose D Orange 500g',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00492','Boroline',8,6,
  443,570,200,293,20,
  'otc,skincare,first-aid,health',0,0.12,4.6,424,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ORS Electrolyte Sachets 20pcs',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00493','Cipla OTC',8,6,
  433,560,272,105,29,
  'otc,skincare,first-aid,health',0,0.12,3.5,49,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Activated Charcoal Capsules 60pcs',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00494','Boroline',8,6,
  510,700,285,97,38,
  'otc,skincare,first-aid,health',0,0.12,3.8,336,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digestive Enzyme Tablets 60pcs',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00495','Himalaya',8,6,
  339,490,194,131,10,
  'otc,skincare,first-aid,health',0,0.12,5.0,297,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital Thermometer',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00496','AccuSure',8,6,
  1399,2240,810,57,25,
  'medical-device,health-monitor,first-aid',0,0.35,4.2,229,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Contact Thermometer Infrared',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00497','AccuSure',8,6,
  4082,4780,2107,180,18,
  'medical-device,health-monitor,first-aid',0,0.35,4.3,419,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blood Pressure Monitor Automatic',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00498','Omron',8,6,
  3712,5120,2477,231,33,
  'medical-device,health-monitor,first-aid',0,0.35,4.5,294,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pulse Oximeter Finger Clip',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00499','Beurer',8,6,
  4589,6610,2274,64,16,
  'medical-device,health-monitor,first-aid',0,0.35,4.0,282,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blood Glucose Monitor Kit',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00500','Sahyog Wellness',8,6,
  3592,4630,2181,221,25,
  'medical-device,health-monitor,first-aid',1,0.35,4.6,327,1);
GO

-- Batch 11/20 (products 501–550)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Peak Flow Meter',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00501','Beurer',8,6,
  2402,3150,1613,5,40,
  'medical-device,health-monitor,first-aid',0,0.35,3.9,40,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Nebulizer Machine Compressor',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00502','Omron',8,6,
  4019,5470,2527,226,39,
  'medical-device,health-monitor,first-aid',0,0.35,4.3,38,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'TENS Machine Pain Relief',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00503','AccuSure',8,6,
  4870,6230,3265,244,37,
  'medical-device,health-monitor,first-aid',0,0.35,4.5,54,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Heating Pad Electric',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00504','AccuSure',8,6,
  473,660,292,115,37,
  'medical-device,health-monitor,first-aid',0,0.35,4.9,181,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ice Gel Pack Reusable',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00505','Sahyog Wellness',8,6,
  3723,4690,2512,261,19,
  'medical-device,health-monitor,first-aid',0,0.35,4.1,41,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cervical Collar Soft',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00506','Sahyog Wellness',8,6,
  1694,2570,848,75,22,
  'medical-device,health-monitor,first-aid',0,0.35,3.8,88,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Lumbar Support Belt',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00507','Beurer',8,6,
  776,1060,474,51,22,
  'medical-device,health-monitor,first-aid',0,0.35,5.0,322,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Cap Medium',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00508','Dr. Morepen',8,6,
  4446,6140,2166,152,11,
  'medical-device,health-monitor,first-aid',0,0.35,4.9,367,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ankle Brace Support',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00509','AccuSure',8,6,
  4120,5730,2719,116,36,
  'medical-device,health-monitor,first-aid',0,0.35,4.5,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Splint Carpal',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00510','Beurer',8,6,
  3323,4850,1698,277,10,
  'medical-device,health-monitor,first-aid',0,0.35,3.6,43,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Chyawanprash 500g',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00511','Zandu',8,6,
  162,220,92,30,17,
  'ayurveda,herbal,natural,wellness',0,0.50,3.8,435,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Triphala Churna 500g',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00512','Himalaya',8,6,
  839,1280,483,35,23,
  'ayurveda,herbal,natural,wellness',0,0.50,4.2,193,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Aloe Vera Juice 1L',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00513','Dabur',8,6,
  114,180,79,260,19,
  'ayurveda,herbal,natural,wellness',0,0.50,3.7,274,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Neem Capsules 60pcs',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00514','Himalaya',8,6,
  803,1280,371,31,19,
  'ayurveda,herbal,natural,wellness',0,0.50,4.4,374,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Giloy Juice 500ml',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00515','Baidyanath',8,6,
  483,540,274,145,15,
  'ayurveda,herbal,natural,wellness',0,0.50,3.8,310,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Amla Juice 500ml',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00516','Patanjali',8,6,
  629,940,357,88,36,
  'ayurveda,herbal,natural,wellness',0,0.50,4.9,81,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shilajit Resin 30g',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00517','Patanjali',8,6,
  1079,1630,699,87,37,
  'ayurveda,herbal,natural,wellness',0,0.50,4.1,88,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Brahmi Churna 100g',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00518','Zandu',8,6,
  778,1070,466,13,23,
  'ayurveda,herbal,natural,wellness',0,0.50,4.6,261,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shatavari Powder 200g',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00519','Zandu',8,6,
  477,750,284,230,29,
  'ayurveda,herbal,natural,wellness',0,0.50,3.7,205,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Panchakarma Kit Basic',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00520','Baidyanath',8,6,
  1211,1720,787,278,34,
  'ayurveda,herbal,natural,wellness',1,0.50,4.0,12,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Neem Face Wash 150ml',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00521','Dabur',8,6,
  121,150,76,99,18,
  'ayurveda,herbal,natural,wellness',0,0.50,4.1,363,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tulsi Green Tea 25 Bags',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00522','Baidyanath',8,6,
  381,530,200,226,19,
  'ayurveda,herbal,natural,wellness',0,0.50,4.0,435,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'First Aid Kit 85-piece',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00523','Lifebuoy',8,6,
  492,620,281,270,15,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.8,101,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Elastic Adhesive Bandage Roll',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00524','Himalaya',8,6,
  940,1420,626,14,21,
  'first-aid,hygiene,personal-care,baby',0,0.25,3.7,424,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Crepe Bandage 10cm',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00525','Himalaya',8,6,
  804,1060,473,33,16,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.7,57,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sterile Gloves Box 50',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00526','Cipla OTC',8,6,
  437,550,250,289,30,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.6,201,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Face Mask N95 10pcs',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00527','Cipla OTC',8,6,
  144,230,71,114,35,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.8,78,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Alcohol Hand Sanitiser 500ml',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00528','Lifebuoy',8,6,
  623,700,418,175,36,
  'first-aid,hygiene,personal-care,baby',0,0.25,3.7,75,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hydrogen Peroxide 3% 100ml',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00529','Himalaya',8,6,
  180,250,122,262,38,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.6,406,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Povidone Iodine Solution 100ml',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00530','Lifebuoy',8,6,
  748,1090,468,19,38,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.8,69,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital Baby Weighing Scale',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00531','Lifebuoy',8,6,
  912,1410,424,198,22,
  'first-aid,hygiene,personal-care,baby',0,0.25,3.5,48,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pregnancy Test Kit 2pcs',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00532','Lifebuoy',8,6,
  818,1170,457,289,25,
  'first-aid,hygiene,personal-care,baby',0,0.25,3.9,38,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt Advanced',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00533','Van Heusen',2,2,
  1970,2210,1351,54,35,
  'jacket,outerwear,winter',0,0.65,4.2,150,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Galaxy Buds Wireless Earbuds Lite',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00534','Acer',1,1,
  8370,9630,5731,16,21,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.1,295,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Track Pants Elite',
  'Olive Green Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00535','H&M',2,2,
  3130,4040,2083,269,10,
  'bottom,trousers,casual',0,0.45,4.9,34,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Barbell Rod 6ft Olympic Pro',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00536','Boldfit',6,5,
  5190,6330,2954,77,18,
  'barbell,weights,powerlifting',0,7.00,4.1,317,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Ceramic Table Vase Pro',
  'Handcrafted Beige Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00537','Nilkamal',4,4,
  2580,3920,1327,50,13,
  'vase,decor,living-room',0,0.80,4.5,189,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Garment Steamer 1500W Elite',
  'Non-stick soleplate with auto temperature control. 360° cord rotation.',
  'APL-00538','Bajaj',5,8,
  610,720,318,167,23,
  'iron,laundry,home',0,1.10,3.9,341,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Rattan Woven Vase Pro',
  'Handcrafted Beige Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00539','IKEA',4,4,
  2230,2990,1384,109,18,
  'vase,decor,living-room',0,0.80,4.3,373,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Windbreaker Premium',
  'White Windbreaker — water-resistant and windproof for all-season wear.',
  'CLO-00540','Allen Solly',2,2,
  4620,5310,2741,121,20,
  'jacket,outerwear,winter',1,0.65,3.8,144,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Basketball Size 5 Premium',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00541','Mikasa',7,7,
  5570,8360,3729,251,31,
  'basketball,volleyball,outdoor',0,0.65,4.8,153,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull-Up Assist Band Pro',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00542','Decathlon',6,5,
  620,690,332,290,36,
  'resistance-band,stretching,yoga,home-workout',0,0.50,3.9,440,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Momentum 4 Over-Ear Headphones Pro',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00543','Bose',1,1,
  6370,7200,3043,175,37,
  'headphones,anc,audio,hi-fi',0,0.25,4.4,429,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Swimming Goggles Anti-Fog Plus',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00544','Speedo',7,7,
  600,770,342,275,14,
  'swimming,pool,sport',0,0.20,4.5,271,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'CoQ10 100mg 30 Capsules Lite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00545','Patanjali',8,6,
  590,700,288,153,29,
  'vitamins,supplements,health,nutrition',0,0.15,4.9,257,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Zip-Up Fleece Pro',
  'White Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00546','Woodland',2,2,
  4370,4890,3044,252,36,
  'jacket,outerwear,winter',0,0.65,4.8,204,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L Max',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00547','Havells',5,8,
  10430,14290,7148,21,36,
  'kitchen,cooking,countertop',0,2.00,3.9,310,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oxford Button-Down Shirt Advanced',
  'Olive Green Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00548','Woodland',2,2,
  800,920,484,88,38,
  'shirt,formal,casual,top',0,0.28,4.0,186,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Floral Maxi Dress Max',
  'Elegant Black Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00549','W for Woman',2,2,
  2610,4120,1358,244,17,
  'women,dress,ethnic,western',0,0.35,4.4,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Rattan Woven Vase Plus',
  'Handcrafted Blush Pink Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00550','HomeTown',4,4,
  1010,1320,557,280,28,
  'vase,decor,living-room',0,0.80,3.5,93,1);
GO

-- Batch 12/20 (products 551–600)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Boat Airdopes 441 Wireless Earbuds Max',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00551','Dell',1,1,
  3420,4240,1937,138,22,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.9,263,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt Elite',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00552','Arrow',2,2,
  1000,1450,569,7,24,
  'tshirt,top,casual,cotton',0,0.20,3.6,319,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 10kg Pair Pro',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00553','Nike',6,5,
  11400,15620,5483,31,14,
  'barbell,weights,powerlifting',0,7.00,3.5,442,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Face Mask N95 10pcs Pro',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00554','Cipla OTC',8,6,
  160,180,79,102,29,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.2,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'FreeBuds Pro Wireless Earbuds Pro',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00555','Philips',1,1,
  7820,10090,5371,248,20,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.6,220,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Wrap Midi Dress Max',
  'Elegant White Wrap Midi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00556','W for Woman',2,2,
  2590,2950,1333,195,18,
  'women,dress,ethnic,western',0,0.35,3.7,156,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt Neo',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00557','Zara',2,2,
  1780,2760,923,190,35,
  'women,dress,ethnic,western',0,0.35,4.5,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ping Pong Net & Post Max',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00558','Butterfly',7,7,
  6700,9250,4620,125,22,
  'tennis,table-tennis,racket',0,0.30,4.0,412,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The DevOps Handbook — Technical Edition Advanced',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00559','O''Reilly / Pearson',3,3,
  1420,2220,884,114,25,
  'programming,technology,reference,textbook',0,0.70,4.0,285,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Samsung Ultra 5G Plus',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00560','Xiaomi',1,1,
  9620,11540,6640,217,26,
  'smartphone,5g,mobile',1,0.22,4.7,418,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Becoming — Paperback Max',
  'Internationally bestselling book by Michelle Obama. This edition features a new introduction by the author.',
  'BOK-00561','Penguin Random House',3,3,
  410,460,215,257,10,
  'fiction,bestseller,novel',0,0.35,5.0,418,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Goalkeeper Gloves Premium',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00562','Cosco',7,7,
  1390,1580,703,212,31,
  'football,soccer,outdoor',0,0.45,4.7,162,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Hoodie Sweatshirt Neo',
  'Black Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00563','Allen Solly',2,2,
  4260,6390,2795,141,40,
  'jacket,outerwear,winter',0,0.65,4.7,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Nebulizer Machine Compressor Elite',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00564','Omron',8,6,
  4330,5280,2659,162,32,
  'medical-device,health-monitor,first-aid',0,0.35,3.9,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Elite',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00565','Sennheiser',1,1,
  9230,10430,6227,161,34,
  'headphones,anc,audio,hi-fi',0,0.25,4.3,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'TENS Machine Pain Relief Max',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00566','AccuSure',8,6,
  4560,6250,3077,42,24,
  'medical-device,health-monitor,first-aid',0,0.35,4.9,362,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Regular Fit Jeans Lite',
  'Olive Green Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00567','HRX',2,2,
  2070,2710,1179,131,39,
  'bottom,trousers,casual',0,0.45,4.5,87,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft Lite',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00568','Nilkamal',4,4,
  4260,6650,2906,16,11,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.7,200,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fabric Hip Band Set Plus',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00569','Fit Simplify',6,5,
  370,450,247,191,20,
  'resistance-band,stretching,yoga,home-workout',0,0.50,3.8,328,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Lite',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00570','Rupa Publications',3,3,
  230,370,105,5,29,
  'fiction,bestseller,novel',0,0.35,4.1,200,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Barbell Rod 6ft Olympic Plus',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00571','Boldfit',6,5,
  4980,6370,2588,40,33,
  'barbell,weights,powerlifting',0,7.00,4.7,377,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Striped T-Shirt Premium',
  'Pure cotton Olive Green Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00572','Arrow',2,2,
  430,480,231,119,30,
  'tshirt,top,casual,cotton',0,0.20,3.7,336,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Terracotta Vase Set Lite',
  'Handcrafted Teal Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00573','Home Centre',4,4,
  940,1130,658,163,12,
  'vase,decor,living-room',0,0.80,3.6,145,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '27" QHD Monitor Advanced',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00574','LG',1,1,
  35830,51950,17598,16,23,
  'monitor,display,screen',0,3.50,3.5,264,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Cooktop Dual Burner Lite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00575','Whirlpool',5,8,
  12570,17850,8363,47,23,
  'kitchen,cooking,countertop',0,2.00,4.7,20,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cervical Collar Soft Neo',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00576','Sahyog Wellness',8,6,
  1690,2380,1168,288,25,
  'medical-device,health-monitor,first-aid',0,0.35,4.7,236,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shuttlecock Feather 6pcs Premium',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00577','Apacs',7,7,
  840,1230,438,216,27,
  'badminton,racket,sport',0,0.25,4.5,117,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Triphala Churna 500g Advanced',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00578','Himalaya',8,6,
  720,840,335,50,12,
  'ayurveda,herbal,natural,wellness',0,0.50,3.6,326,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'IdeaPad 3 Laptop Plus',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00579','Microsoft',1,1,
  69300,77620,35572,156,13,
  'laptop,computer,notebook,work',0,1.60,4.1,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rhodia Webnotebook Advanced',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00580','Rhodia',3,3,
  1460,2310,713,296,12,
  'notebook,journal,stationery',1,0.30,3.6,235,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair Neo',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00581','Nike',6,5,
  860,1030,408,290,33,
  'gym-accessory,fitness,workout',0,0.60,3.9,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Flow — Hardcover Neo',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00582','Pearson',3,3,
  700,1070,386,294,25,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,64,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants Premium',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00583','Levi''s',2,2,
  1080,1330,627,109,25,
  'bottom,trousers,casual',0,0.45,4.4,320,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Realme Neo 5G Max',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00584','Samsung',1,1,
  20310,24370,9483,244,40,
  'smartphone,5g,mobile',0,0.22,4.0,434,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Wraps Support Elite',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00585','RitFit',6,5,
  1820,2490,1004,208,30,
  'gym-accessory,fitness,workout',0,0.60,4.5,265,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Boat Airdopes 441 Wireless Earbuds Plus',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00586','Dell',1,1,
  2810,3620,1344,149,23,
  'earbuds,wireless,bluetooth,audio',0,0.06,3.6,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gigabit Switch 8-Port Elite',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00587','Tenda',1,1,
  6070,9470,3716,176,25,
  'networking,router,wifi,internet',0,0.40,4.5,160,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Pragmatic Programmer — Technical Edition Lite',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00588','O''Reilly / Pearson',3,3,
  2030,2840,1409,217,39,
  'programming,technology,reference,textbook',0,0.70,3.6,124,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants Neo',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00589','Levi''s',2,2,
  1100,1330,734,242,16,
  'bottom,trousers,casual',0,0.45,4.2,306,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Plus',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00590','Rupa Publications',3,3,
  240,360,159,257,24,
  'fiction,bestseller,novel',0,0.35,5.0,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt Advanced',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00591','Van Heusen',2,2,
  1990,2710,1216,171,32,
  'jacket,outerwear,winter',0,0.65,3.7,345,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 4J Plus',
  '4-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00592','Prestige',5,8,
  4520,6060,2597,199,13,
  'kitchen,mixer,grinder',0,4.50,3.5,365,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack Pro',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00593','Puma',7,7,
  540,680,322,233,31,
  'football,soccer,outdoor',0,0.45,4.1,120,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'DualSense Controller Lite',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00594','Logitech',1,1,
  24280,36420,12682,252,36,
  'gaming,peripheral,esports',0,0.80,3.8,357,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Capture Card 4K Max',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00595','Microsoft',1,1,
  40190,59480,18243,150,28,
  'gaming,peripheral,esports',0,0.80,4.8,399,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'TENS Machine Pain Relief Pro',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00596','AccuSure',8,6,
  4810,7550,3285,52,10,
  'medical-device,health-monitor,first-aid',0,0.35,5.0,302,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rhodia Webnotebook Advanced',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00597','Rhodia',3,3,
  1820,2750,943,173,19,
  'notebook,journal,stationery',0,0.30,4.9,158,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Goalkeeper Gloves Plus',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00598','Cosco',7,7,
  1280,1780,620,180,36,
  'football,soccer,outdoor',0,0.45,5.0,358,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants Pro',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00599','Levi''s',2,2,
  1070,1610,511,86,28,
  'bottom,trousers,casual',0,0.45,4.0,93,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Momentum 4 Over-Ear Headphones Lite',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00600','Bose',1,1,
  6510,9700,3559,157,39,
  'headphones,anc,audio,hi-fi',1,0.25,3.5,449,1);
GO

-- Batch 13/20 (products 601–650)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wi-Fi 6 Router Premium',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00601','TP-Link',1,1,
  4360,6100,2615,226,33,
  'networking,router,wifi,internet',0,0.40,4.9,184,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Velvet Cushion Cover Pack Plus',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00602','IKEA',4,4,
  4860,5930,2573,253,32,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,3.8,65,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'System Design Interview — Technical Edition Advanced',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00603','O''Reilly / Pearson',3,3,
  1610,2430,798,19,27,
  'programming,technology,reference,textbook',0,0.70,3.9,66,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Striped T-Shirt Plus',
  'Pure cotton Navy Blue Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00604','Allen Solly',2,2,
  390,590,254,82,10,
  'tshirt,top,casual,cotton',0,0.20,4.4,175,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The 48 Laws of Power — Hardcover Plus',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00605','Juggernaut',3,3,
  550,840,268,120,31,
  'self-help,business,nonfiction,hardcover',0,0.50,4.8,384,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Design Patterns — Technical Edition Premium',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00606','O''Reilly / Pearson',3,3,
  2160,2380,1471,245,18,
  'programming,technology,reference,textbook',0,0.70,3.7,278,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Neo',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00607','Sennheiser',1,1,
  8260,10330,5405,117,36,
  'headphones,anc,audio,hi-fi',0,0.25,3.8,444,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Inline Skates Adult Elite',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00608','Trek',7,7,
  2130,2940,1006,104,19,
  'cycling,skating,outdoor,safety',0,0.50,4.6,108,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Wraps Support Premium',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00609','RitFit',6,5,
  2000,2920,1019,159,30,
  'gym-accessory,fitness,workout',0,0.60,3.8,225,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Premium',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00610','Furlenco',4,4,
  830,1160,539,171,17,
  'photo-frame,decor,gifting',0,0.40,4.7,257,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WH-1000XM5 Over-Ear Headphones Neo',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00611','Bose',1,1,
  18530,27980,12623,294,20,
  'headphones,anc,audio,hi-fi',0,0.25,3.7,75,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Balls 3 Tin Premium',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00612','Stiga',7,7,
  4790,5600,2775,266,34,
  'tennis,table-tennis,racket',0,0.30,3.6,272,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Photo Frame Collage 6-in-1 Elite',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00613','Ikea',4,4,
  550,810,351,248,36,
  'photo-frame,decor,gifting',0,0.40,4.2,33,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Advanced',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00614','Sony',1,1,
  36970,51760,22909,28,22,
  'camera,photography,mirrorless',0,0.40,4.1,298,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bicycle Helmet Adult Premium',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00615','Decathlon',7,7,
  3010,4480,1421,289,22,
  'cycling,skating,outdoor,safety',0,0.50,3.6,101,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Monstera Artificial Plant Pro',
  'Low-maintenance decorative plant — brings life and freshness to your home.',
  'DEC-00616','Ugaoo',4,4,
  310,350,144,110,18,
  'plants,indoor,decor,greenery',0,0.50,4.6,52,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull Buoy Float Elite',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00617','Arena',7,7,
  2340,3000,1291,81,34,
  'swimming,pool,sport',0,0.20,3.7,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 5kg Plus',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00618','Kobo',6,5,
  2410,3420,1369,229,23,
  'dumbbell,weights,strength',0,10.0,4.0,298,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Panchakarma Kit Basic Neo',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00619','Baidyanath',8,6,
  1090,1220,565,48,10,
  'ayurveda,herbal,natural,wellness',0,0.50,3.5,41,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xiaomi 5G Lite',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00620','Realme',1,1,
  20430,24110,13175,269,29,
  'smartphone,5g,mobile',1,0.22,4.6,39,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Basketball Hoop Portable Advanced',
  'Deep channel design for easy grip. Indoor/outdoor use.',
  'SPT-00621','Mikasa',7,7,
  810,970,400,298,11,
  'basketball,volleyball,outdoor',0,0.65,5.0,267,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair Max',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00622','Nike',6,5,
  930,1290,501,86,33,
  'gym-accessory,fitness,workout',0,0.60,3.5,436,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Voice-Controlled Smart Strip Max',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00623','Honeywell',1,1,
  4680,6790,2255,84,32,
  'smarthome,iot,alexa',0,0.35,4.3,120,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Principles — Hardcover Max',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00624','Juggernaut',3,3,
  1040,1230,558,147,30,
  'self-help,business,nonfiction,hardcover',0,0.50,4.3,121,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Quilted Jacket Lite',
  'Navy Blue Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00625','Zara',2,2,
  2290,2840,1342,287,32,
  'jacket,outerwear,winter',0,0.65,3.6,3,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oxford Button-Down Shirt Pro',
  'White Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00626','Puma',2,2,
  2260,3300,1270,32,32,
  'shirt,formal,casual,top',0,0.28,4.4,18,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Splint Carpal Neo',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00627','Beurer',8,6,
  3140,4710,2155,128,36,
  'medical-device,health-monitor,first-aid',0,0.35,4.2,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Man''s Search for Meaning — Paperback Pro',
  'Internationally bestselling book by Viktor Frankl. This edition features a new introduction by the author.',
  'BOK-00628','Penguin Random House',3,3,
  380,560,220,206,24,
  'fiction,bestseller,novel',0,0.35,3.6,78,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt Elite',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00629','Arrow',2,2,
  1090,1740,508,167,17,
  'tshirt,top,casual,cotton',0,0.20,4.6,76,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Premium',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00630','Gunn & Moore',7,7,
  6700,9920,4059,263,22,
  'cricket,bat,outdoor',0,1.20,4.4,252,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Magnesium 400mg 60 Caps Lite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00631','Setu',8,6,
  520,790,314,265,20,
  'vitamins,supplements,health,nutrition',0,0.15,4.7,370,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Denim Jacket Premium',
  'Navy Blue Denim Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00632','H&M',2,2,
  2920,4670,1364,226,10,
  'jacket,outerwear,winter',0,0.65,4.2,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Casual Linen Shirt Pro',
  'Black Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00633','Puma',2,2,
  1250,1380,836,142,21,
  'shirt,formal,casual,top',0,0.28,4.7,195,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt Advanced',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00634','Van Heusen',2,2,
  1820,2730,1085,47,33,
  'jacket,outerwear,winter',0,0.65,4.9,332,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt Lite',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00635','Zara',2,2,
  1750,2010,842,292,13,
  'women,dress,ethnic,western',0,0.35,4.4,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Hoodie Sweatshirt Pro',
  'Black Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00636','Allen Solly',2,2,
  4310,4740,2424,115,17,
  'jacket,outerwear,winter',0,0.65,4.2,412,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Adjustable Dumbbell Set 20kg Lite',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00637','Vector X',6,5,
  1310,2000,777,209,40,
  'dumbbell,weights,strength',0,10.0,4.9,188,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Plus',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00638','Sennheiser',1,1,
  8220,11590,4275,257,27,
  'headphones,anc,audio,hi-fi',0,0.25,4.7,438,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Balls 3 Tin Premium',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00639','Stiga',7,7,
  4320,6000,2357,69,10,
  'tennis,table-tennis,racket',0,0.30,4.8,165,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Dual Basket Air Fryer 8L Elite',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00640','Inalsa',5,8,
  8350,11860,3999,99,31,
  'air-fryer,kitchen,healthy-cooking',1,3.50,4.7,86,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oversized T-Shirt Premium',
  'Pure cotton White Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00641','Puma',2,2,
  530,660,300,232,34,
  'tshirt,top,casual,cotton',0,0.20,3.8,179,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black V-Neck T-Shirt Max',
  'Pure cotton Black V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00642','Adidas',2,2,
  850,1270,401,154,15,
  'tshirt,top,casual,cotton',0,0.20,4.0,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Non-Slip Yoga Mat 5mm Max',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00643','Kobo',6,5,
  2220,3200,1053,121,25,
  'yoga-mat,yoga,pilates,exercise',0,1.20,3.9,23,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Linen Cushion Cover Set 5 Lite',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00644','Urban Ladder',4,4,
  2440,2760,1140,113,36,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.4,185,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'R.D. Sharma Mathematics Neo',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00645','Oxford University Press',3,3,
  1750,2010,989,173,23,
  'education,textbook,children,academic',0,0.60,4.5,222,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Ankle Chelsea Boots Lite',
  'Comfortable and stylish Ankle Chelsea Boots for everyday wear.',
  'CLO-00646','Nike',2,2,
  1770,2500,1057,190,25,
  'shoes,footwear,casual',0,0.80,3.9,221,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rich Dad Poor Dad — Paperback Neo',
  'Internationally bestselling book by Robert Kiyosaki. This edition features a new introduction by the author.',
  'BOK-00647','HarperCollins',3,3,
  360,450,206,284,28,
  'fiction,bestseller,novel',0,0.35,4.7,347,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Cooktop Dual Burner Pro',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00648','Whirlpool',5,8,
  12280,16950,6237,5,27,
  'kitchen,cooking,countertop',0,2.00,3.9,170,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Striped T-Shirt Premium',
  'Pure cotton Olive Green Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00649','Arrow',2,2,
  440,700,238,211,16,
  'tshirt,top,casual,cotton',0,0.20,4.2,68,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Polo T-Shirt Premium',
  'Pure cotton Black Polo T-Shirt — breathable, soft and easy-care.',
  'CLO-00650','Levi''s',2,2,
  850,1280,544,97,35,
  'tshirt,top,casual,cotton',0,0.20,5.0,99,1);
GO

-- Batch 14/20 (products 651–700)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Balls 3 Tin Plus',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00651','Stiga',7,7,
  3800,5740,1787,256,30,
  'tennis,table-tennis,racket',0,0.30,4.2,377,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sterile Gloves Box 50 Elite',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00652','Cipla OTC',8,6,
  490,760,330,16,20,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.5,290,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Quilted Jacket Elite',
  'Navy Blue Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00653','Zara',2,2,
  2370,3010,1305,77,11,
  'jacket,outerwear,winter',0,0.65,3.9,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Balls 40mm 6pcs Premium',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00654','Decathlon',7,7,
  650,830,358,53,11,
  'tennis,table-tennis,racket',0,0.30,4.9,288,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 1kg Chocolate Neo',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00655','MyProtein',6,5,
  1450,1620,780,100,12,
  'supplements,protein,nutrition,fitness',0,1.00,4.2,65,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folding Treadmill 3HP Elite',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00656','Lifeline',6,5,
  26420,32500,17507,190,17,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.3,18,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Premium',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00657','Sennheiser',1,1,
  7500,10950,4333,199,32,
  'headphones,anc,audio,hi-fi',0,0.25,3.9,107,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Iron 45mg + Vitamin C 60 Tabs Neo',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00658','Himalaya',8,6,
  940,1490,632,27,32,
  'vitamins,supplements,health,nutrition',0,0.15,4.7,27,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Plus',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00659','Gunn & Moore',7,7,
  7270,11560,3936,214,14,
  'cricket,bat,outdoor',0,1.20,4.9,262,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WH-1000XM5 Over-Ear Headphones Max',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00660','Bose',1,1,
  19770,26290,11485,153,31,
  'headphones,anc,audio,hi-fi',1,0.25,3.9,178,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Elite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00661','Gunn & Moore',7,7,
  6170,8330,2952,232,32,
  'cricket,bat,outdoor',0,1.20,4.3,384,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cervical Collar Soft Advanced',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00662','Sahyog Wellness',8,6,
  1820,2240,1091,165,15,
  'medical-device,health-monitor,first-aid',0,0.35,4.5,359,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Loop Resistance Band 4pcs Neo',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00663','Decathlon',6,5,
  1380,1840,832,251,32,
  'resistance-band,stretching,yoga,home-workout',0,0.50,3.5,47,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Ceramic Table Vase Premium',
  'Handcrafted Blush Pink Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00664','The Label Life',4,4,
  2290,2770,1304,97,38,
  'vase,decor,living-room',0,0.80,3.9,261,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Can''t Hurt Me — Hardcover Pro',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00665','McGraw Hill',3,3,
  580,810,396,270,26,
  'self-help,business,nonfiction,hardcover',0,0.50,4.0,125,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Zip-Up Fleece Premium',
  'Black Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00666','Roadster',2,2,
  3950,4700,2551,147,38,
  'jacket,outerwear,winter',0,0.65,4.0,241,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Chyawanprash 500g Neo',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00667','Zandu',8,6,
  170,230,106,41,33,
  'ayurveda,herbal,natural,wellness',0,0.50,4.8,203,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Z30 Mirrorless Camera Max',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00668','Canon',1,1,
  61690,84520,31585,77,24,
  'camera,photography,mirrorless',0,0.40,4.8,157,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Neoprene Dumbbell Set 3kg Premium',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00669','Adidas',6,5,
  3260,3780,2023,177,35,
  'dumbbell,weights,strength',0,10.0,4.4,426,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 4mm TPE Premium',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00670','Decathlon',6,5,
  1000,1100,591,132,32,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.8,244,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Max',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00671','Furlenco',4,4,
  880,1140,402,185,38,
  'photo-frame,decor,gifting',0,0.40,4.4,444,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 6mm NBR Elite',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00672','Strauss',6,5,
  960,1340,642,263,36,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.2,392,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oxford Button-Down Shirt Premium',
  'Olive Green Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00673','Woodland',2,2,
  800,940,557,264,37,
  'shirt,formal,casual,top',0,0.28,4.7,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Windbreaker Premium',
  'White Windbreaker — water-resistant and windproof for all-season wear.',
  'CLO-00674','Allen Solly',2,2,
  4430,6420,2797,116,18,
  'jacket,outerwear,winter',0,0.65,4.1,155,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Advanced',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00675','Gunn & Moore',7,7,
  6630,8950,3179,143,22,
  'cricket,bat,outdoor',0,1.20,3.6,311,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Premium',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00676','Sony',1,1,
  39770,56870,27802,245,15,
  'camera,photography,mirrorless',0,0.40,3.6,190,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Slim Fit Chinos Plus',
  'Navy Blue Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00677','Allen Solly',2,2,
  1740,2660,875,174,31,
  'bottom,trousers,casual',0,0.45,4.8,328,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sherpa Fleece Throw Premium',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00678','Urban Ladder',4,4,
  1020,1480,516,217,28,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.6,85,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt Neo',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00679','Arrow',2,2,
  1020,1320,462,97,35,
  'tshirt,top,casual,cotton',0,0.20,5.0,47,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Cargo Pants Pro',
  'Black Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00680','Zara',2,2,
  1070,1530,672,231,26,
  'bottom,trousers,casual',1,0.45,3.6,152,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown Elite',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00681','Usha',5,8,
  6020,7770,2923,45,23,
  'fan,cooling,home',0,3.50,4.5,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Slim Fit Chinos Pro',
  'Black Slim Fit Chinos in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00682','Zara',2,2,
  2440,3510,1571,279,37,
  'bottom,trousers,casual',0,0.45,4.7,319,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Boat Airdopes 441 Wireless Earbuds Premium',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00683','Dell',1,1,
  3280,4000,2278,286,17,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.1,102,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mass Gainer 3kg Lite',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00684','MyProtein',6,5,
  690,1000,469,140,33,
  'supplements,protein,nutrition,fitness',0,1.00,3.7,244,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Start with Why — Hardcover Neo',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00685','Bloomsbury',3,3,
  520,720,321,38,17,
  'self-help,business,nonfiction,hardcover',0,0.50,4.9,337,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Advanced',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00686','Sennheiser',1,1,
  8460,12860,5465,182,22,
  'headphones,anc,audio,hi-fi',0,0.25,3.9,81,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Drip Coffee Machine Lite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00687','Havells',5,8,
  10770,14750,5706,6,36,
  'kitchen,cooking,countertop',0,2.00,4.1,204,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folding Treadmill 3HP Pro',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00688','Lifeline',6,5,
  24810,32000,15076,214,13,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.6,152,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Plus',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00689','Rupa Publications',3,3,
  260,320,144,24,29,
  'fiction,bestseller,novel',0,0.35,4.9,269,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Turmeric Curcumin 500mg 60 Tabs Plus',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00690','Dabur',8,6,
  320,350,184,18,10,
  'vitamins,supplements,health,nutrition',0,0.15,4.5,121,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 1kg Chocolate Max',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00691','MyProtein',6,5,
  1480,2340,940,255,32,
  'supplements,protein,nutrition,fitness',0,1.00,4.0,309,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tower Room Heater PTC Neo',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00692','Usha',5,8,
  3140,4710,1845,138,17,
  'heater,winter,home',0,2.80,3.6,396,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digestive Enzyme Tablets 60pcs Max',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00693','Himalaya',8,6,
  350,540,239,242,10,
  'otc,skincare,first-aid,health',0,0.12,4.1,248,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Face Mask N95 10pcs Neo',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00694','Cipla OTC',8,6,
  130,200,86,211,20,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.4,45,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Premium',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00695','Sony',1,1,
  36120,57430,23080,35,32,
  'camera,photography,mirrorless',0,0.40,3.5,443,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Z30 Mirrorless Camera Neo',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00696','Canon',1,1,
  59120,70940,37453,71,29,
  'camera,photography,mirrorless',0,0.40,4.7,270,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Figure 8 Resistance Band Advanced',
  'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
  'GYM-00697','Boldfit',6,5,
  380,590,178,180,21,
  'resistance-band,stretching,yoga,home-workout',0,0.50,4.6,299,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Striped T-Shirt Premium',
  'Pure cotton Olive Green Striped T-Shirt — breathable, soft and easy-care.',
  'CLO-00698','Arrow',2,2,
  410,630,285,281,31,
  'tshirt,top,casual,cotton',0,0.20,4.5,20,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Galaxy Buds Wireless Earbuds Advanced',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00699','Acer',1,1,
  7420,10240,4853,284,23,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.8,256,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft Plus',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00700','Nilkamal',4,4,
  3710,5750,1879,187,38,
  'soft-furnishing,living-room,bedroom,textile',1,1.00,4.5,410,1);
GO

-- Batch 15/20 (products 701–750)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gram 16 Laptop Pro',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00701','HP',1,1,
  52580,74660,26428,175,38,
  'laptop,computer,notebook,work',0,1.60,3.7,94,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Neo',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00702','Furlenco',4,4,
  760,1080,506,97,32,
  'photo-frame,decor,gifting',0,0.40,4.0,81,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Anarkali Kurti Max',
  'Elegant Black Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00703','W for Woman',2,2,
  2840,4520,1364,240,27,
  'women,dress,ethnic,western',0,0.35,4.6,254,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Interlocking Foam Floor Tiles 6pcs Lite',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00704','Decathlon',6,5,
  890,1240,423,193,32,
  'yoga-mat,yoga,pilates,exercise',0,1.20,3.6,365,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Track Pants Neo',
  'Navy Blue Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00705','Adidas',2,2,
  1010,1370,524,222,36,
  'bottom,trousers,casual',0,0.45,3.8,191,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Sapiens — Paperback Elite',
  'Internationally bestselling book by Yuval Noah Harari. This edition features a new introduction by the author.',
  'BOK-00706','Rupa Publications',3,3,
  420,550,210,205,35,
  'fiction,bestseller,novel',0,0.35,3.8,310,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Zip-Up Fleece Plus',
  'White Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00707','Woodland',2,2,
  4430,4960,2941,254,12,
  'jacket,outerwear,winter',0,0.65,4.2,342,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Goalkeeper Gloves Lite',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00708','Cosco',7,7,
  1230,1620,750,142,37,
  'football,soccer,outdoor',0,0.45,3.8,265,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'NCERT Mathematics Class 10 Advanced',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00709','McGraw Hill',3,3,
  1710,2430,1094,15,20,
  'education,textbook,children,academic',0,0.60,4.4,160,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Straight Kurti Advanced',
  'Elegant White Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00710','Biba',2,2,
  2620,3120,1616,235,10,
  'women,dress,ethnic,western',0,0.35,4.0,112,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Puffer Vest Premium',
  'Black Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00711','US Polo',2,2,
  4360,6500,2677,97,34,
  'jacket,outerwear,winter',0,0.65,4.5,112,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 750W 2J Pro',
  '2-jar mixer grinder with Mixer Grinder 750W motor. SS blades, 5-year warranty.',
  'APL-00712','Bajaj',5,8,
  3060,3700,2002,174,18,
  'kitchen,mixer,grinder',0,4.50,3.8,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Wall Tapestry Advanced',
  'Statement wall décor piece — transforms any blank wall instantly.',
  'DEC-00713','IKEA',4,4,
  420,500,211,108,22,
  'wall-decor,art,living-room,bedroom',0,0.60,4.9,278,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ready Player One — Paperback Pro',
  'Internationally bestselling book by Ernest Cline. This edition features a new introduction by the author.',
  'BOK-00714','Westland Books',3,3,
  570,850,344,164,24,
  'fiction,bestseller,novel',0,0.35,4.2,237,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WH-1000XM5 Over-Ear Headphones Pro',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00715','Bose',1,1,
  18950,25580,9115,233,16,
  'headphones,anc,audio,hi-fi',0,0.25,4.8,152,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Face Mask N95 10pcs Premium',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00716','Cipla OTC',8,6,
  130,150,70,238,35,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.1,185,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Elite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00717','Gunn & Moore',7,7,
  6490,9930,3109,88,32,
  'cricket,bat,outdoor',0,1.20,3.6,253,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'R.D. Sharma Mathematics Lite',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00718','Oxford University Press',3,3,
  1820,2730,1029,177,31,
  'education,textbook,children,academic',0,0.60,4.7,399,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MTG Complete NEET Guide Max',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00719','Rupa Publications',3,3,
  2080,3310,1264,293,18,
  'education,textbook,children,academic',0,0.60,4.7,237,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Joggers Lite',
  'White Joggers in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00720','Levi''s',2,2,
  690,860,464,229,21,
  'bottom,trousers,casual',1,0.45,3.8,422,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Ceramic Table Vase Elite',
  'Handcrafted Beige Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00721','Nilkamal',4,4,
  2650,4030,1472,111,23,
  'vase,decor,living-room',0,0.80,4.0,202,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ThinkPad E14 Laptop Plus',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00722','Apple',1,1,
  43950,48780,22899,287,20,
  'laptop,computer,notebook,work',0,1.60,4.8,71,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Straight Kurti Max',
  'Elegant Black Straight Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00723','Biba',2,2,
  2210,2870,1064,234,14,
  'women,dress,ethnic,western',0,0.35,4.7,121,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Anarkali Kurti Elite',
  'Elegant Olive Green Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00724','Biba',2,2,
  3290,3980,2251,46,25,
  'women,dress,ethnic,western',0,0.35,3.8,433,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mechanical Keyboard RGB Lite',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00725','HyperX',1,1,
  7020,9200,4517,219,25,
  'gaming,peripheral,esports',0,0.80,4.6,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 20kg Pair Elite',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00726','Nike',6,5,
  5130,5850,3159,291,15,
  'barbell,weights,powerlifting',0,7.00,4.9,39,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Creatine Monohydrate 300g Advanced',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00727','HealthKart',6,5,
  770,1040,360,218,25,
  'supplements,protein,nutrition,fitness',0,1.00,4.2,421,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L Elite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00728','Havells',5,8,
  11030,12460,5186,283,40,
  'kitchen,cooking,countertop',0,2.00,3.9,138,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bodycon Mini Dress Premium',
  'Elegant Black Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00729','Mango',2,2,
  1690,2210,976,48,39,
  'women,dress,ethnic,western',0,0.35,4.1,341,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve2 85 Over-Ear Headphones Lite',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00730','Sennheiser',1,1,
  7210,11390,3960,142,39,
  'headphones,anc,audio,hi-fi',0,0.25,4.2,15,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MTG Complete NEET Guide Pro',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00731','Rupa Publications',3,3,
  1940,3010,967,70,34,
  'education,textbook,children,academic',0,0.60,4.0,30,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Alchemist — Paperback Lite',
  'Internationally bestselling book by Paulo Coelho. This edition features a new introduction by the author.',
  'BOK-00732','HarperCollins',3,3,
  700,860,467,10,27,
  'fiction,bestseller,novel',0,0.35,3.9,405,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Premium',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00733','Tenda',1,1,
  12560,15570,7689,117,40,
  'networking,router,wifi,internet',0,0.40,4.0,167,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Moisturising Lotion 200ml Plus',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00734','Cipla OTC',8,6,
  570,840,312,98,13,
  'otc,skincare,first-aid,health',0,0.12,4.4,415,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Power Rack Half Rack Max',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00735','Body Solid',6,5,
  43710,62510,24921,20,33,
  'gym-equipment,cardio,strength,home-gym',0,25.0,3.6,115,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Rattan Woven Vase Neo',
  'Handcrafted Blush Pink Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00736','HomeTown',4,4,
  860,1130,534,50,37,
  'vase,decor,living-room',0,0.80,4.2,25,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Voice-Controlled Smart Strip Pro',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00737','Honeywell',1,1,
  3640,4220,1831,256,38,
  'smarthome,iot,alexa',0,0.35,4.8,255,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack Plus',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00738','Puma',7,7,
  670,760,352,246,28,
  'football,soccer,outdoor',0,0.45,4.8,336,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Nebulizer Machine Compressor Plus',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00739','Omron',8,6,
  4300,6490,2784,13,30,
  'medical-device,health-monitor,first-aid',0,0.35,4.6,328,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack Neo',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00740','Puma',7,7,
  600,750,295,295,34,
  'football,soccer,outdoor',1,0.45,3.9,196,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Lean Startup — Hardcover Max',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00741','Bloomsbury',3,3,
  680,1010,313,158,26,
  'self-help,business,nonfiction,hardcover',0,0.50,4.9,109,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Marble Effect Wall Clock Elite',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00742','IKEA',4,4,
  1070,1360,539,150,12,
  'clock,wall-decor,living-room',0,1.20,4.3,156,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Neo',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00743','Rupa Publications',3,3,
  250,320,118,128,29,
  'fiction,bestseller,novel',0,0.35,4.7,148,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Where the Crawdads Sing — Paperback Neo',
  'Internationally bestselling book by Delia Owens. This edition features a new introduction by the author.',
  'BOK-00744','McGraw Hill',3,3,
  390,510,202,91,37,
  'fiction,bestseller,novel',0,0.35,4.9,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xiaomi 5G Elite',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00745','Realme',1,1,
  18730,21160,12607,215,20,
  'smartphone,5g,mobile',0,0.22,4.0,89,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown Advanced',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00746','Usha',5,8,
  5830,8690,3957,117,38,
  'fan,cooling,home',0,3.50,3.9,428,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gigabit Switch 8-Port Lite',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00747','Tenda',1,1,
  5320,8350,3156,224,17,
  'networking,router,wifi,internet',0,0.40,3.9,291,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Structure and Interpretation — Technical Edition Max',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00748','O''Reilly / Pearson',3,3,
  2360,3520,1544,269,20,
  'programming,technology,reference,textbook',0,0.70,4.2,136,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'WH-1000XM5 Over-Ear Headphones Pro',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00749','Bose',1,1,
  18690,21310,11423,132,18,
  'headphones,anc,audio,hi-fi',0,0.25,4.3,209,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 2kg Vanilla Max',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00750','MuscleBlaze',6,5,
  4690,6380,2465,62,24,
  'supplements,protein,nutrition,fitness',0,1.00,4.7,341,1);
GO

-- Batch 16/20 (products 751–800)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kickboard Swimming Advanced',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00751','Speedo',7,7,
  2040,2690,968,34,33,
  'swimming,pool,sport',0,0.20,3.7,282,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Momentum 4 Over-Ear Headphones Neo',
  'Premium over-ear headphones with best-in-class noise cancellation.',
  'ELC-00752','Bose',1,1,
  6950,9040,4322,79,18,
  'headphones,anc,audio,hi-fi',0,0.25,3.5,137,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shatavari Powder 200g Premium',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00753','Zandu',8,6,
  550,610,314,88,28,
  'ayurveda,herbal,natural,wellness',0,0.50,4.2,108,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Ceramic Table Vase Lite',
  'Handcrafted Beige Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00754','Nilkamal',4,4,
  2730,3580,1523,128,13,
  'vase,decor,living-room',0,0.80,3.6,34,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '24" FHD IPS Monitor Neo',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00755','Asus',1,1,
  31000,41540,21024,254,19,
  'monitor,display,screen',0,3.50,5.0,356,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Harry Potter Box Set Advanced',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00756','Westland Books',3,3,
  600,840,287,171,17,
  'education,textbook,children,academic',0,0.60,3.8,121,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Pro',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00757','Gunn & Moore',7,7,
  7120,9830,4119,201,19,
  'cricket,bat,outdoor',0,1.20,4.7,317,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Structure and Interpretation — Technical Edition Neo',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00758','O''Reilly / Pearson',3,3,
  2070,2750,1024,179,32,
  'programming,technology,reference,textbook',0,0.70,4.2,241,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey V-Neck T-Shirt Plus',
  'Pure cotton Charcoal Grey V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00759','Jack & Jones',2,2,
  980,1470,619,219,18,
  'tshirt,top,casual,cotton',0,0.20,4.9,114,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Ikigai — Paperback Elite',
  'Internationally bestselling book by Héctor García. This edition features a new introduction by the author.',
  'BOK-00760','Westland Books',3,3,
  210,260,105,73,20,
  'fiction,bestseller,novel',1,0.35,3.8,342,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Max',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00761','Sony',1,1,
  40670,57750,22084,191,27,
  'camera,photography,mirrorless',0,0.40,4.7,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Balls 3 Tin Premium',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00762','Stiga',7,7,
  5210,7400,2943,30,38,
  'tennis,table-tennis,racket',0,0.30,3.9,395,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shatavari Powder 200g Neo',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00763','Zandu',8,6,
  620,710,346,161,32,
  'ayurveda,herbal,natural,wellness',0,0.50,4.3,235,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack Neo',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00764','Puma',7,7,
  650,1030,315,12,10,
  'football,soccer,outdoor',0,0.45,4.3,141,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown Lite',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00765','Usha',5,8,
  5540,7870,2905,10,22,
  'fan,cooling,home',0,3.50,4.0,34,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair Premium',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00766','Nike',6,5,
  930,1260,497,99,25,
  'gym-accessory,fitness,workout',0,0.60,4.3,404,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 4J Plus',
  '4-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00767','Prestige',5,8,
  4130,5530,2178,249,36,
  'kitchen,mixer,grinder',0,4.50,3.9,183,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt Premium',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00768','Zara',2,2,
  2030,2250,1364,159,27,
  'women,dress,ethnic,western',0,0.35,4.8,186,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Samsung Smart SE Smartwatch Plus',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00769','boAt',1,1,
  15860,25380,9895,293,12,
  'smartwatch,fitness,wearable',0,0.08,3.7,312,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 6mm NBR Pro',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00770','Strauss',6,5,
  1260,1580,704,202,12,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.1,315,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Quilted Jacket Max',
  'White Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00771','Adidas',2,2,
  1630,1870,1013,114,10,
  'jacket,outerwear,winter',0,0.65,4.5,165,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Rust Brown Ceramic Table Vase Neo',
  'Handcrafted Rust Brown Ceramic Table Vase — adds a touch of elegance to any space.',
  'DEC-00772','HomeTown',4,4,
  1260,1860,650,172,38,
  'vase,decor,living-room',0,0.80,4.0,130,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Push-Up Handles Rotating Max',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00773','Nike',6,5,
  350,460,173,249,19,
  'gym-accessory,fitness,workout',0,0.60,4.0,388,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Lite',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00774','Sony',1,1,
  39440,56790,20241,90,29,
  'camera,photography,mirrorless',0,0.40,3.6,0,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'LED Desk Lamp Smart Lite',
  'Essential everyday tech accessory built to last.',
  'ELC-00775','Xiaomi',1,1,
  530,610,329,64,16,
  'accessory,charger,gadget',0,0.30,4.9,388,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt Neo',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00776','Arrow',2,2,
  1160,1590,577,117,29,
  'tshirt,top,casual,cotton',0,0.20,4.4,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 3J Max',
  '3-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00777','Philips',5,8,
  5530,6800,2514,245,38,
  'kitchen,mixer,grinder',0,4.50,4.2,316,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Galaxy Buds Wireless Earbuds Plus',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00778','Acer',1,1,
  7930,10230,3616,152,24,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.4,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Aspire 5 Laptop Elite',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00779','Asus',1,1,
  92240,124520,54325,185,33,
  'laptop,computer,notebook,work',0,1.60,3.8,208,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L Elite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00780','Havells',5,8,
  9010,10630,5344,209,40,
  'kitchen,cooking,countertop',1,2.00,4.0,130,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull Buoy Float Elite',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00781','Arena',7,7,
  2730,3960,1281,153,30,
  'swimming,pool,sport',0,0.20,4.6,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 5kg Elite',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00782','Kobo',6,5,
  2630,4000,1274,138,24,
  'dumbbell,weights,strength',0,10.0,4.2,151,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Elite',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00783','Tenda',1,1,
  13750,16780,6895,208,18,
  'networking,router,wifi,internet',0,0.40,3.6,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tennis Ball Cricket Bat Tape Lite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00784','Kookaburra',7,7,
  7360,9490,4429,247,29,
  'cricket,bat,outdoor',0,1.20,4.8,47,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Quilted Jacket Advanced',
  'White Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00785','Adidas',2,2,
  2020,2830,916,117,16,
  'jacket,outerwear,winter',0,0.65,4.0,32,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bodycon Mini Dress Neo',
  'Elegant Black Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00786','Mango',2,2,
  1720,2490,1202,150,33,
  'women,dress,ethnic,western',0,0.35,3.6,105,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Oversized T-Shirt Elite',
  'Pure cotton Black Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00787','US Polo',2,2,
  630,990,352,290,39,
  'tshirt,top,casual,cotton',0,0.20,4.7,228,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Balls 40mm 6pcs Elite',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00788','Decathlon',7,7,
  550,680,333,207,35,
  'tennis,table-tennis,racket',0,0.30,4.5,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Structure and Interpretation — Technical Edition Max',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00789','O''Reilly / Pearson',3,3,
  2260,2510,1199,5,38,
  'programming,technology,reference,textbook',0,0.70,3.5,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black High-Waist Palazzo Elite',
  'Elegant Black High-Waist Palazzo in breathable fabric. Perfect for all occasions.',
  'CLO-00790','Mango',2,2,
  1660,2620,800,32,22,
  'women,dress,ethnic,western',0,0.35,3.7,14,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '20000mAh Power Bank Max',
  'Essential everyday tech accessory built to last.',
  'ELC-00791','Lenovo',1,1,
  1210,1840,827,20,38,
  'accessory,charger,gadget',0,0.30,4.5,24,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Glucose D Orange 500g Premium',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00792','Boroline',8,6,
  500,580,301,287,26,
  'otc,skincare,first-aid,health',0,0.12,4.1,14,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Voice-Controlled Smart Strip Lite',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00793','Honeywell',1,1,
  3670,4220,2195,264,23,
  'smarthome,iot,alexa',0,0.35,4.2,417,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Glass Flower Vase Neo',
  'Handcrafted Blush Pink Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00794','Pepperfry',4,4,
  1930,2490,1331,194,40,
  'vase,decor,living-room',0,0.80,3.6,428,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Paperblanks Flexi Journal Neo',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00795','Rhodia',3,3,
  1130,1450,664,211,12,
  'notebook,journal,stationery',0,0.30,3.5,94,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Track Pants Pro',
  'White Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00796','Nike',2,2,
  1500,1970,1005,246,26,
  'bottom,trousers,casual',0,0.45,3.8,285,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Zero to One — Hardcover Pro',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00797','Juggernaut',3,3,
  860,1010,418,69,18,
  'self-help,business,nonfiction,hardcover',0,0.50,3.7,7,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital LED Clock Plus',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00798','Home Centre',4,4,
  3820,4550,2084,267,15,
  'clock,wall-decor,living-room',0,1.20,3.6,320,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Cargo Pants Advanced',
  'White Cargo Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00799','Van Heusen',2,2,
  3490,4290,2012,243,39,
  'bottom,trousers,casual',0,0.45,3.6,386,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'English Willow Cricket Bat Grade 1 Elite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00800','SS',7,7,
  1860,2060,886,129,37,
  'cricket,bat,outdoor',1,1.20,5.0,243,1);
GO

-- Batch 17/20 (products 801–850)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 4J Lite',
  '4-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00801','Bajaj',5,8,
  5880,7410,3142,7,35,
  'kitchen,mixer,grinder',0,4.50,3.8,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Marble Effect Wall Clock Premium',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00802','IKEA',4,4,
  1360,1890,762,249,32,
  'clock,wall-decor,living-room',0,1.20,4.8,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The Alchemist — Paperback Pro',
  'Internationally bestselling book by Paulo Coelho. This edition features a new introduction by the author.',
  'BOK-00803','HarperCollins',3,3,
  620,770,397,39,32,
  'fiction,bestseller,novel',0,0.35,4.1,271,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Bodycon Mini Dress Lite',
  'Elegant Olive Green Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00804','AND',2,2,
  920,1350,436,103,22,
  'women,dress,ethnic,western',0,0.35,4.5,45,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vitamin B12 500mcg 60 Tabs Elite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00805','Himalaya',8,6,
  1140,1610,517,234,34,
  'vitamins,supplements,health,nutrition',0,0.15,3.7,151,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'boAt FitPro Ultra Smartwatch Elite',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00806','Noise',1,1,
  14150,20230,9431,69,36,
  'smartwatch,fitness,wearable',0,0.08,4.9,102,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Neo',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00807','Tenda',1,1,
  13320,18120,6999,142,32,
  'networking,router,wifi,internet',0,0.40,4.1,292,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Z30 Mirrorless Camera Elite',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00808','Canon',1,1,
  49710,71580,26308,144,25,
  'camera,photography,mirrorless',0,0.40,4.2,333,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Pro',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00809','Tenda',1,1,
  11570,13070,6271,130,17,
  'networking,router,wifi,internet',0,0.40,3.7,224,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'NCERT Mathematics Class 10 Pro',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00810','McGraw Hill',3,3,
  1460,1930,710,101,23,
  'education,textbook,children,academic',0,0.60,4.7,89,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Elastic Adhesive Bandage Roll Max',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00811','Himalaya',8,6,
  860,1110,489,187,40,
  'first-aid,hygiene,personal-care,baby',0,0.25,4.0,259,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt Premium',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00812','Van Heusen',2,2,
  2030,3050,994,252,14,
  'jacket,outerwear,winter',0,0.65,4.6,352,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Rattan Woven Vase Premium',
  'Handcrafted Blush Pink Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00813','HomeTown',4,4,
  970,1080,493,193,10,
  'vase,decor,living-room',0,0.80,3.9,150,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Swimming Goggles Anti-Fog Premium',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00814','Speedo',7,7,
  620,910,288,24,29,
  'swimming,pool,sport',0,0.20,4.0,274,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'FIFA Quality Pro Football Advanced',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00815','Cosco',7,7,
  2220,3000,1029,79,28,
  'football,soccer,outdoor',0,0.45,3.5,21,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Hex Dumbbell Pair 10kg Elite',
  'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
  'GYM-00816','Adidas',6,5,
  4590,5690,2763,131,14,
  'dumbbell,weights,strength',0,10.0,3.9,194,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Beige Rattan Woven Vase Pro',
  'Handcrafted Beige Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00817','IKEA',4,4,
  1870,2970,1245,158,32,
  'vase,decor,living-room',0,0.80,4.8,414,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Track Pants Premium',
  'White Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00818','Nike',2,2,
  1580,1850,927,140,15,
  'bottom,trousers,casual',0,0.45,4.4,274,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Moringa 500mg 60 Capsules Lite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00819','HealthKart',8,6,
  1230,1940,715,257,11,
  'vitamins,supplements,health,nutrition',0,0.15,3.8,295,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Floral Maxi Dress Max',
  'Elegant White Floral Maxi Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00820','Biba',2,2,
  920,1380,476,289,27,
  'women,dress,ethnic,western',1,0.35,3.7,108,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Contact Thermometer Infrared Elite',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00821','AccuSure',8,6,
  3500,3890,1941,63,36,
  'medical-device,health-monitor,first-aid',0,0.35,4.5,141,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Face Mask N95 10pcs Plus',
  'Essential healthcare product for home use. Meets all regulatory quality standards.',
  'MED-00822','Cipla OTC',8,6,
  170,240,101,253,27,
  'first-aid,hygiene,personal-care,baby',0,0.25,3.9,343,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Where the Crawdads Sing — Paperback Max',
  'Internationally bestselling book by Delia Owens. This edition features a new introduction by the author.',
  'BOK-00823','McGraw Hill',3,3,
  410,600,283,106,34,
  'fiction,bestseller,novel',0,0.35,5.0,363,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gravity Water Purifier 15L Lite',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00824','Aquaguard',5,8,
  7440,8560,5075,240,15,
  'water-purifier,kitchen,health',0,6.00,3.8,3,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folic Acid 5mg 30 Tablets Pro',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00825','Patanjali',8,6,
  1170,1830,598,46,18,
  'vitamins,supplements,health,nutrition',0,0.15,3.9,445,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants Neo',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00826','Levi''s',2,2,
  1090,1490,526,184,35,
  'bottom,trousers,casual',0,0.45,3.6,334,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Max',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00827','Sony',1,1,
  39040,44900,21986,178,27,
  'camera,photography,mirrorless',0,0.40,3.6,348,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Solo 20L Neo',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00828','Inalsa',5,8,
  9350,13930,5627,97,22,
  'kitchen,cooking,countertop',0,2.00,3.7,263,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wall Fan 300mm White Elite',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00829','Havells',5,8,
  1200,1790,578,6,13,
  'fan,cooling,home',0,3.50,4.7,238,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Barbell Rod 6ft Olympic Pro',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00830','Boldfit',6,5,
  5570,6180,3072,116,33,
  'barbell,weights,powerlifting',0,7.00,4.3,448,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Quilted Jacket Plus',
  'White Quilted Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00831','Adidas',2,2,
  1780,2190,1039,58,36,
  'jacket,outerwear,winter',0,0.65,4.3,170,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Plus',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00832','Furlenco',4,4,
  920,1070,566,29,17,
  'photo-frame,decor,gifting',0,0.40,3.9,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Elite',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00833','Rupa Publications',3,3,
  230,290,121,62,11,
  'fiction,bestseller,novel',0,0.35,4.7,362,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Advanced',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00834','Sony',1,1,
  36820,44180,25383,236,33,
  'camera,photography,mirrorless',0,0.40,4.9,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L Elite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00835','Havells',5,8,
  12100,13790,6291,272,25,
  'kitchen,cooking,countertop',0,2.00,4.4,327,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tricep Bar Lite',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00836','Nike',6,5,
  1440,2100,822,121,12,
  'barbell,weights,powerlifting',0,7.00,3.8,68,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Dual Basket Air Fryer 8L Neo',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00837','Inalsa',5,8,
  8610,10250,5929,129,39,
  'air-fryer,kitchen,healthy-cooking',0,3.50,3.6,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ORS Electrolyte Sachets 20pcs Lite',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00838','Cipla OTC',8,6,
  420,550,209,67,37,
  'otc,skincare,first-aid,health',0,0.12,4.9,32,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Canvas Sneakers Plus',
  'Comfortable and stylish Canvas Sneakers for everyday wear.',
  'CLO-00839','Bata',2,2,
  5720,6640,3450,48,31,
  'shoes,footwear,casual',0,0.80,3.6,43,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Goalkeeper Gloves Max',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00840','Cosco',7,7,
  1100,1230,524,141,14,
  'football,soccer,outdoor',1,0.45,4.5,387,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mixer Grinder 1000W 4J Advanced',
  '4-jar mixer grinder with Mixer Grinder 1000W motor. SS blades, 5-year warranty.',
  'APL-00841','Prestige',5,8,
  5150,7880,2569,158,14,
  'kitchen,mixer,grinder',0,4.50,3.7,111,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'CoQ10 100mg 30 Capsules Pro',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00842','Patanjali',8,6,
  520,730,269,51,22,
  'vitamins,supplements,health,nutrition',0,0.15,3.7,300,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Athletic Running Shoes Plus',
  'Comfortable and stylish Athletic Running Shoes for everyday wear.',
  'CLO-00843','Nike',2,2,
  4390,5180,2173,36,15,
  'shoes,footwear,casual',0,0.80,4.2,392,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Eucalyptus Beeswax Pillar Candle Premium',
  'Long-burn aromatherapy candle made with natural wax and essential oils.',
  'DEC-00844','Candlescapes',4,4,
  1360,1880,652,277,10,
  'candle,aroma,wellness,gifting',0,0.40,4.0,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Water Purifier RO+UV 7L Advanced',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00845','Pureit',5,8,
  15420,24670,9508,175,12,
  'water-purifier,kitchen,health',0,6.00,4.6,5,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Cooktop Dual Burner Advanced',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00846','Whirlpool',5,8,
  12320,17740,6951,96,22,
  'kitchen,cooking,countertop',0,2.00,4.2,79,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Denim Jacket Neo',
  'Black Denim Jacket — water-resistant and windproof for all-season wear.',
  'CLO-00847','Levi''s',2,2,
  4690,7080,2190,237,17,
  'jacket,outerwear,winter',0,0.65,4.7,210,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Solo 20L Premium',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00848','Inalsa',5,8,
  9980,11780,6041,283,26,
  'kitchen,cooking,countertop',0,2.00,3.6,67,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Graphic Tee Advanced',
  'Pure cotton Black Graphic Tee — breathable, soft and easy-care.',
  'CLO-00849','Zara',2,2,
  860,1250,473,214,36,
  'tshirt,top,casual,cotton',0,0.20,4.0,45,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ThinkPad E14 Laptop Pro',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00850','Apple',1,1,
  39540,62470,19968,209,14,
  'laptop,computer,notebook,work',0,1.60,4.9,201,1);
GO

-- Batch 18/20 (products 851–900)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pull-Up Bar Doorway Plus',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00851','RitFit',6,5,
  1320,1560,767,235,19,
  'gym-accessory,fitness,workout',0,0.60,4.9,382,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Inline Skates Adult Lite',
  'CE certified protective gear for cycling and skating enthusiasts.',
  'SPT-00852','Trek',7,7,
  2720,4350,1805,123,24,
  'cycling,skating,outdoor,safety',0,0.50,4.3,433,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Neo',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00853','Sony',1,1,
  38390,46450,22389,48,28,
  'camera,photography,mirrorless',0,0.40,3.6,27,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt Pro',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00854','Zara',2,2,
  1740,2120,1218,62,13,
  'women,dress,ethnic,western',0,0.35,4.2,17,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cotton Throw Blanket Advanced',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00855','The Label Life',4,4,
  2060,2390,1206,95,31,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.2,213,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fire HD 10 Tablet Elite',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00856','Lenovo',1,1,
  29790,42300,13994,63,30,
  'tablet,android,ipad',0,0.55,4.7,406,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The 48 Laws of Power — Hardcover Pro',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00857','Juggernaut',3,3,
  630,740,379,132,27,
  'self-help,business,nonfiction,hardcover',0,0.50,4.8,126,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gram 16 Laptop Pro',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00858','HP',1,1,
  48630,66620,28964,245,37,
  'laptop,computer,notebook,work',0,1.60,4.3,96,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Casual Linen Shirt Lite',
  'Olive Green Casual Linen Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00859','Woodland',2,2,
  660,990,365,232,24,
  'shirt,formal,casual,top',0,0.28,4.2,295,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Introduction to Algorithms — Technical Edition Max',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00860','O''Reilly / Pearson',3,3,
  1170,1300,665,77,20,
  'programming,technology,reference,textbook',1,0.70,5.0,84,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folic Acid 5mg 30 Tablets Elite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00861','Patanjali',8,6,
  1020,1170,473,31,10,
  'vitamins,supplements,health,nutrition',0,0.15,4.2,438,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green A-Line Skirt Max',
  'Elegant Olive Green A-Line Skirt in breathable fabric. Perfect for all occasions.',
  'CLO-00862','Zara',2,2,
  1720,2600,943,87,12,
  'women,dress,ethnic,western',0,0.35,3.9,345,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Neem Face Wash 150ml Pro',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00863','Dabur',8,6,
  110,170,72,11,14,
  'ayurveda,herbal,natural,wellness',0,0.50,4.7,293,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pre-Workout 300g Premium',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00864','Optimum Nutrition',6,5,
  1370,1810,840,70,20,
  'supplements,protein,nutrition,fitness',0,1.00,4.3,118,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Hoodie Sweatshirt Plus',
  'White Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00865','Van Heusen',2,2,
  1940,2700,1164,91,30,
  'jacket,outerwear,winter',0,0.65,3.5,332,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '24" FHD IPS Monitor Elite',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00866','Asus',1,1,
  34940,42630,17571,226,34,
  'monitor,display,screen',0,3.50,4.1,223,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oversized T-Shirt Plus',
  'Pure cotton White Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00867','Puma',2,2,
  520,700,362,121,38,
  'tshirt,top,casual,cotton',0,0.20,4.7,425,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Boat Airdopes 441 Wireless Earbuds Advanced',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00868','Dell',1,1,
  3730,4510,2030,287,32,
  'earbuds,wireless,bluetooth,audio',0,0.06,4.7,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Jabra Evolve Wireless Earbuds Elite',
  'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
  'ELC-00869','Realme',1,1,
  13590,20390,8388,69,25,
  'earbuds,wireless,bluetooth,audio',0,0.06,3.7,231,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pavilion 15 Laptop Max',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00870','Asus',1,1,
  127670,144270,76979,86,40,
  'laptop,computer,notebook,work',0,1.60,4.7,393,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Elite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00871','Gunn & Moore',7,7,
  7440,10860,4715,94,20,
  'cricket,bat,outdoor',0,1.20,4.9,254,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Samsung Smart SE Smartwatch Elite',
  'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
  'ELC-00872','boAt',1,1,
  18700,21320,12776,253,38,
  'smartwatch,fitness,wearable',0,0.08,4.5,297,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folic Acid 5mg 30 Tablets Elite',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00873','Patanjali',8,6,
  890,1140,510,132,23,
  'vitamins,supplements,health,nutrition',0,0.15,4.0,132,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Harry Potter Box Set Max',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00874','Westland Books',3,3,
  600,880,380,54,38,
  'education,textbook,children,academic',0,0.60,4.5,17,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mass Gainer 3kg Advanced',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00875','MyProtein',6,5,
  650,850,370,244,35,
  'supplements,protein,nutrition,fitness',0,1.00,4.0,232,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown Pro',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00876','Usha',5,8,
  4850,7080,2802,12,20,
  'fan,cooling,home',0,3.50,4.8,228,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Design Patterns — Technical Edition Neo',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00877','O''Reilly / Pearson',3,3,
  2480,2850,1234,34,29,
  'programming,technology,reference,textbook',0,0.70,4.3,173,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Non-Slip Yoga Mat 5mm Advanced',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00878','Kobo',6,5,
  2360,2900,1524,102,36,
  'yoga-mat,yoga,pilates,exercise',0,1.20,4.4,413,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Anarkali Kurti Lite',
  'Elegant Olive Green Anarkali Kurti in breathable fabric. Perfect for all occasions.',
  'CLO-00879','Biba',2,2,
  3400,4560,1815,39,14,
  'women,dress,ethnic,western',0,0.35,3.6,15,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair Advanced',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00880','Nike',6,5,
  860,1030,403,242,19,
  'gym-accessory,fitness,workout',1,0.60,4.9,2,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pedestal Fan 400mm White Neo',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00881','Bajaj',5,8,
  6650,9780,3876,58,10,
  'fan,cooling,home',0,3.50,3.8,98,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Terracotta Vase Set Advanced',
  'Handcrafted Blush Pink Terracotta Vase Set — adds a touch of elegance to any space.',
  'DEC-00882','IKEA',4,4,
  1410,1820,835,29,27,
  'vase,decor,living-room',0,0.80,3.5,161,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Elite',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00883','Sony',1,1,
  39730,56810,25800,40,27,
  'camera,photography,mirrorless',0,0.40,4.1,160,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Leuchtturm1917 Bullet Journal Plus',
  'Premium quality paper journal for notes, journaling and sketching.',
  'BOK-00884','Moleskine',3,3,
  1540,1970,917,269,26,
  'notebook,journal,stationery',0,0.30,4.7,290,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Puffer Vest Advanced',
  'Navy Blue Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00885','Zara',2,2,
  2380,3070,1072,124,26,
  'jacket,outerwear,winter',0,0.65,4.4,92,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Regular Fit Jeans Advanced',
  'Black Regular Fit Jeans in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00886','Zara',2,2,
  980,1420,614,250,19,
  'bottom,trousers,casual',0,0.45,4.1,257,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Vivo Pro Advanced',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00887','OnePlus',1,1,
  17950,22260,12527,105,29,
  'smartphone,5g,mobile',0,0.22,4.9,237,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ZenBook 14 Laptop Advanced',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00888','Lenovo',1,1,
  87050,121000,42276,74,28,
  'laptop,computer,notebook,work',0,1.60,4.3,322,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 5kg Pair Max',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00889','RitFit',6,5,
  4640,5890,2819,297,32,
  'barbell,weights,powerlifting',0,7.00,3.8,371,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft Premium',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00890','Nilkamal',4,4,
  4110,5260,2144,82,31,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.0,32,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pavilion 15 Laptop Elite',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00891','Asus',1,1,
  146760,171710,88611,177,38,
  'laptop,computer,notebook,work',0,1.60,3.6,267,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 4J Neo',
  '4-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00892','Bajaj',5,8,
  5270,7330,3494,137,38,
  'kitchen,mixer,grinder',0,4.50,4.9,217,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MatePad Pro Tablet Neo',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00893','Samsung',1,1,
  41730,52160,24709,189,10,
  'tablet,android,ipad',0,0.55,4.5,230,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blood Pressure Monitor Automatic Advanced',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00894','Omron',8,6,
  3290,4540,1576,228,16,
  'medical-device,health-monitor,first-aid',0,0.35,3.7,427,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Where the Crawdads Sing — Paperback Max',
  'Internationally bestselling book by Delia Owens. This edition features a new introduction by the author.',
  'BOK-00895','McGraw Hill',3,3,
  460,550,316,173,26,
  'fiction,bestseller,novel',0,0.35,3.9,51,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Teal Glass Flower Vase Pro',
  'Handcrafted Teal Glass Flower Vase — adds a touch of elegance to any space.',
  'DEC-00896','The Label Life',4,4,
  1610,2170,916,105,11,
  'vase,decor,living-room',0,0.80,4.6,56,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Track Pants Elite',
  'Navy Blue Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00897','Adidas',2,2,
  870,1380,572,34,34,
  'bottom,trousers,casual',0,0.45,4.1,202,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mechanical Keyboard RGB Plus',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00898','HyperX',1,1,
  7780,12370,5093,112,23,
  'gaming,peripheral,esports',0,0.80,3.8,128,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'OTG 25L Pro',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00899','Havells',5,8,
  11880,17110,7148,201,39,
  'kitchen,cooking,countertop',0,2.00,4.5,245,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Multivitamin for Men 60 tabs Max',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00900','MuscleBlaze',6,5,
  2810,3540,1688,189,19,
  'supplements,protein,nutrition,fitness',1,1.00,3.8,83,1);
GO

-- Batch 19/20 (products 901–950)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cricket Kitbag Wheelie Advanced',
  'International standard cricket equipment meeting all safety requirements.',
  'SPT-00901','SS',7,7,
  960,1130,664,19,15,
  'cricket,gear,protective',0,0.80,3.7,158,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Thinking, Fast and Slow — Hardcover Advanced',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00902','Bloomsbury',3,3,
  980,1440,581,228,12,
  'self-help,business,nonfiction,hardcover',0,0.50,3.6,261,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Blush Pink Rattan Woven Vase Advanced',
  'Handcrafted Blush Pink Rattan Woven Vase — adds a touch of elegance to any space.',
  'DEC-00903','HomeTown',4,4,
  1020,1390,623,125,30,
  'vase,decor,living-room',0,0.80,4.8,434,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  '24" FHD IPS Monitor Max',
  'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
  'ELC-00904','Asus',1,1,
  33580,41980,23174,10,15,
  'monitor,display,screen',0,3.50,4.5,178,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oxford Button-Down Shirt Pro',
  'Olive Green Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00905','Woodland',2,2,
  800,1090,525,200,40,
  'shirt,formal,casual,top',0,0.28,4.6,82,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Lite',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00906','Furlenco',4,4,
  790,1180,550,39,29,
  'photo-frame,decor,gifting',0,0.40,3.7,83,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bodycon Mini Dress Lite',
  'Elegant Black Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00907','Mango',2,2,
  1780,2510,806,158,16,
  'women,dress,ethnic,western',0,0.35,3.7,12,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Turmeric Curcumin 500mg 60 Tabs Max',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00908','Dabur',8,6,
  330,520,152,61,13,
  'vitamins,supplements,health,nutrition',0,0.15,4.4,62,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Fish Oil Omega-3 1000mg 90 Softgels Advanced',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00909','Setu',8,6,
  1510,1830,930,90,31,
  'vitamins,supplements,health,nutrition',0,0.15,3.8,312,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Pro',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00910','Tenda',1,1,
  12170,16670,8234,95,32,
  'networking,router,wifi,internet',0,0.40,4.7,392,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Folding Treadmill 3HP Plus',
  'Commercial-grade home gym equipment with 2-year structural warranty.',
  'GYM-00911','Lifeline',6,5,
  24990,38480,14755,239,14,
  'gym-equipment,cardio,strength,home-gym',0,25.0,4.7,171,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart Door Lock Plus',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00912','Yale',1,1,
  7330,10410,4163,82,12,
  'smarthome,iot,alexa',0,0.35,4.5,54,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'The DevOps Handbook — Technical Edition Max',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00913','O''Reilly / Pearson',3,3,
  1600,2100,834,10,38,
  'programming,technology,reference,textbook',0,0.70,3.5,141,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 3J Neo',
  '3-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00914','Prestige',5,8,
  4690,7180,3256,131,22,
  'kitchen,mixer,grinder',0,4.50,4.5,352,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Bodycon Mini Dress Pro',
  'Elegant Black Bodycon Mini Dress in breathable fabric. Perfect for all occasions.',
  'CLO-00915','Mango',2,2,
  1740,2210,873,81,29,
  'women,dress,ethnic,western',0,0.35,4.2,379,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Flannel Check Shirt Lite',
  'White Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00916','Mango',2,2,
  2190,3110,1461,178,10,
  'shirt,formal,casual,top',0,0.28,3.6,42,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Track Pants Advanced',
  'Black Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00917','Levi''s',2,2,
  1140,1430,781,60,15,
  'bottom,trousers,casual',0,0.45,3.7,241,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Bat Set Plus',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00918','Wilson',7,7,
  3920,5920,2237,244,15,
  'tennis,table-tennis,racket',0,0.30,4.6,133,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gaming Mouse Advanced',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00919','Microsoft',1,1,
  26400,35110,13490,148,10,
  'gaming,peripheral,esports',0,0.80,4.7,96,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Introduction to Algorithms — Technical Edition Elite',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00920','O''Reilly / Pearson',3,3,
  1000,1580,503,167,13,
  'programming,technology,reference,textbook',1,0.70,3.7,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Extreme 3 Bluetooth Speaker Premium',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00921','Anker',1,1,
  1780,2740,871,205,14,
  'speaker,bluetooth,portable,audio',0,0.50,3.8,388,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Formal Dress Shirt Pro',
  'Black Formal Dress Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00922','HRX',2,2,
  860,1140,563,145,20,
  'shirt,formal,casual,top',0,0.28,4.7,278,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'MatePad Pro Tablet Neo',
  '10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
  'ELC-00923','Samsung',1,1,
  37370,50080,19662,37,39,
  'tablet,android,ipad',0,0.55,4.3,64,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Elite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00924','Gunn & Moore',7,7,
  6220,8150,3770,253,38,
  'cricket,bat,outdoor',0,1.20,4.5,129,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Calcium + D3 60 Tablets Max',
  'Third-party tested dietary supplement. GMP certified manufacturing facility.',
  'MED-00925','Dr. Morepen',8,6,
  600,680,327,164,17,
  'vitamins,supplements,health,nutrition',0,0.15,4.1,363,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Xiaomi 5G Pro',
  '5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
  'ELC-00926','Realme',1,1,
  20700,24840,12579,195,29,
  'smartphone,5g,mobile',0,0.22,4.8,27,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Exhaust Fan 6 Inch Brown Advanced',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00927','Usha',5,8,
  6070,7160,3372,77,35,
  'fan,cooling,home',0,3.50,3.7,105,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Convection 28L Pro',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00928','Bajaj',5,8,
  7860,11630,4636,199,22,
  'kitchen,cooking,countertop',0,2.00,4.9,380,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pavilion 15 Laptop Advanced',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00929','Asus',1,1,
  144110,210400,76946,269,39,
  'laptop,computer,notebook,work',0,1.60,4.1,378,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft Plus',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00930','Nilkamal',4,4,
  4150,5980,2405,178,19,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.9,377,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Plus',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00931','Furlenco',4,4,
  880,1340,601,261,23,
  'photo-frame,decor,gifting',0,0.40,3.9,425,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Start with Why — Hardcover Advanced',
  'A definitive guide for personal and professional growth. Includes index and notes.',
  'BOK-00932','Bloomsbury',3,3,
  490,780,282,239,22,
  'self-help,business,nonfiction,hardcover',0,0.50,4.7,44,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Bohemian Rug 5x7 ft Premium',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00933','Nilkamal',4,4,
  4440,6300,2519,159,24,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,4.5,35,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Introduction to Algorithms — Technical Edition Max',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00934','O''Reilly / Pearson',3,3,
  1130,1380,678,14,18,
  'programming,technology,reference,textbook',0,0.70,5.0,259,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Hoodie Sweatshirt Plus',
  'Black Hoodie Sweatshirt — water-resistant and windproof for all-season wear.',
  'CLO-00935','Allen Solly',2,2,
  4410,6570,2198,18,23,
  'jacket,outerwear,winter',0,0.65,4.2,65,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Deep Work — Paperback Plus',
  'Internationally bestselling book by Cal Newport. This edition features a new introduction by the author.',
  'BOK-00936','Rupa Publications',3,3,
  230,360,153,165,17,
  'fiction,bestseller,novel',0,0.35,4.7,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Water Purifier RO+UV+UF 10L Pro',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00937','Havells',5,8,
  9870,14710,5486,246,36,
  'water-purifier,kitchen,health',0,6.00,4.4,91,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Table Tennis Balls 40mm 6pcs Max',
  'ITTF approved equipment for recreational and competitive play.',
  'SPT-00938','Decathlon',7,7,
  700,990,411,205,23,
  'tennis,table-tennis,racket',0,0.30,4.3,58,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Athletic Running Shoes Max',
  'Comfortable and stylish Athletic Running Shoes for everyday wear.',
  'CLO-00939','Nike',2,2,
  4750,5460,3044,158,30,
  'shoes,footwear,casual',0,0.80,4.9,281,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Premium',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00940','Tenda',1,1,
  13160,17370,6972,213,34,
  'networking,router,wifi,internet',1,0.40,3.7,337,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Smart Door Lock Plus',
  'Voice assistant compatible smart home device for effortless automation.',
  'ELC-00941','Yale',1,1,
  6380,7530,3800,208,29,
  'smarthome,iot,alexa',0,0.35,4.4,296,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Charcoal Grey V-Neck T-Shirt Elite',
  'Pure cotton Charcoal Grey V-Neck T-Shirt — breathable, soft and easy-care.',
  'CLO-00942','Jack & Jones',2,2,
  910,1220,461,95,37,
  'tshirt,top,casual,cotton',0,0.20,4.3,294,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Cracking the Coding Interview — Technical Edition Plus',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00943','O''Reilly / Pearson',3,3,
  760,1070,355,276,37,
  'programming,technology,reference,textbook',0,0.70,4.8,55,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ThinkPad E14 Laptop Neo',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00944','Apple',1,1,
  34460,45140,17553,277,31,
  'laptop,computer,notebook,work',0,1.60,4.2,311,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 20kg Pair Elite',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00945','Nike',6,5,
  4810,6970,2199,202,37,
  'barbell,weights,powerlifting',0,7.00,4.6,292,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Water Purifier RO+UV 7L Elite',
  '7-stage purification with mineral retention technology. 1-year free service.',
  'APL-00946','Pureit',5,8,
  15170,22450,8780,236,39,
  'water-purifier,kitchen,health',0,6.00,3.8,447,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Microwave Solo 20L Lite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00947','Inalsa',5,8,
  10420,12820,7103,193,18,
  'kitchen,cooking,countertop',0,2.00,3.8,246,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Oxford Button-Down Shirt Max',
  'White Oxford Button-Down Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00948','Puma',2,2,
  2380,3090,1077,20,13,
  'shirt,formal,casual,top',0,0.28,3.6,394,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Leather Loafers Max',
  'Comfortable and stylish Leather Loafers for everyday wear.',
  'CLO-00949','Woodland',2,2,
  5570,7350,3866,113,27,
  'shoes,footwear,casual',0,0.80,4.1,409,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Zip-Up Fleece Pro',
  'Black Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00950','Roadster',2,2,
  3650,5370,1666,289,12,
  'jacket,outerwear,winter',0,0.65,4.7,123,1);
GO

-- Batch 20/20 (products 951–1000)
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mivi Roam 2 Bluetooth Speaker Advanced',
  '360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
  'ELC-00951','Mivi',1,1,
  10780,15740,6885,199,32,
  'speaker,bluetooth,portable,audio',0,0.50,4.7,166,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Flannel Check Shirt Lite',
  'Navy Blue Flannel Check Shirt in wrinkle-resistant fabric. Machine washable.',
  'CLO-00952','Arrow',2,2,
  1230,1670,817,203,39,
  'shirt,formal,casual,top',0,0.28,3.7,274,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Linen Cushion Cover Set 5 Pro',
  'Premium quality home textile — adds warmth, texture and personality to your space.',
  'DEC-00953','Urban Ladder',4,4,
  2270,3160,1217,175,38,
  'soft-furnishing,living-room,bedroom,textile',0,1.00,3.9,194,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tricep Bar Lite',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00954','Nike',6,5,
  1320,1570,775,102,31,
  'barbell,weights,powerlifting',0,7.00,3.9,65,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Capture Card 4K Neo',
  'High-performance gaming peripheral engineered for competitive play.',
  'ELC-00955','Microsoft',1,1,
  31720,36480,15635,111,34,
  'gaming,peripheral,esports',0,0.80,3.7,437,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Weight Plates 20kg Pair Max',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-00956','Nike',6,5,
  4870,7160,3160,282,22,
  'barbell,weights,powerlifting',0,7.00,4.6,8,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Man''s Search for Meaning — Paperback Plus',
  'Internationally bestselling book by Viktor Frankl. This edition features a new introduction by the author.',
  'BOK-00957','Penguin Random House',3,3,
  340,400,192,117,36,
  'fiction,bestseller,novel',0,0.35,3.6,443,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pedestal Fan 400mm White Lite',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00958','Bajaj',5,8,
  6060,9270,3237,59,33,
  'fan,cooling,home',0,3.50,4.0,143,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wi-Fi 6 Router Plus',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00959','TP-Link',1,1,
  4380,5960,2904,111,37,
  'networking,router,wifi,internet',0,0.40,4.9,190,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Gym Gloves Padded Plus',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00960','Nike',6,5,
  1280,1630,778,261,19,
  'gym-accessory,fitness,workout',1,0.60,3.9,428,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tower Room Heater PTC Elite',
  'Overheating protection with tip-over safety switch. Silent operation.',
  'APL-00961','Usha',5,8,
  3500,4940,2059,287,34,
  'heater,winter,home',0,2.80,4.0,322,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Grip Tape 3pcs Elite',
  'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
  'SPT-00962','Apacs',7,7,
  3220,3770,1516,195,39,
  'badminton,racket,sport',0,0.25,4.5,43,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Splint Carpal Max',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00963','Beurer',8,6,
  3160,3570,1803,168,30,
  'medical-device,health-monitor,first-aid',0,0.35,4.7,18,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Creatine Monohydrate 300g Lite',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00964','HealthKart',6,5,
  890,1110,545,23,32,
  'supplements,protein,nutrition,fitness',0,1.00,4.3,314,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Olive Green Oversized T-Shirt Neo',
  'Pure cotton Olive Green Oversized T-Shirt — breathable, soft and easy-care.',
  'CLO-00965','Arrow',2,2,
  1030,1630,685,123,24,
  'tshirt,top,casual,cotton',0,0.20,4.5,117,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Knee Sleeves Pair Lite',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00966','Nike',6,5,
  860,1060,601,191,26,
  'gym-accessory,fitness,workout',0,0.60,3.9,325,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Yoga Mat 6mm NBR Lite',
  'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
  'GYM-00967','Strauss',6,5,
  820,930,508,235,31,
  'yoga-mat,yoga,pilates,exercise',0,1.20,3.9,415,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'White Track Pants Lite',
  'White Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00968','Nike',2,2,
  1480,2030,760,151,15,
  'bottom,trousers,casual',0,0.45,4.3,117,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'A Little Life — Paperback Pro',
  'Internationally bestselling book by Hanya Yanagihara. This edition features a new introduction by the author.',
  'BOK-00969','HarperCollins',3,3,
  580,790,385,135,29,
  'fiction,bestseller,novel',0,0.35,4.5,444,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Zip-Up Fleece Elite',
  'Black Zip-Up Fleece — water-resistant and windproof for all-season wear.',
  'CLO-00970','Roadster',2,2,
  4030,5360,2740,230,22,
  'jacket,outerwear,winter',0,0.65,4.4,85,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Activated Charcoal Capsules 60pcs Max',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00971','Boroline',8,6,
  540,860,376,74,37,
  'otc,skincare,first-aid,health',0,0.12,3.8,290,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Graphic Tee Neo',
  'Pure cotton Navy Blue Graphic Tee — breathable, soft and easy-care.',
  'CLO-00972','Woodland',2,2,
  620,820,323,50,21,
  'tshirt,top,casual,cotton',0,0.20,3.8,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Football Ankle Socks 3-Pack Plus',
  'Machine-stitched PU football with butyl bladder. FIFA approved.',
  'SPT-00973','Puma',7,7,
  570,750,359,87,25,
  'football,soccer,outdoor',0,0.45,3.8,260,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Pro',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00974','Gunn & Moore',7,7,
  7500,11920,3516,155,38,
  'cricket,bat,outdoor',0,1.20,4.8,318,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Electric Cooktop Dual Burner Elite',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00975','Whirlpool',5,8,
  14010,21580,7028,73,17,
  'kitchen,cooking,countertop',0,2.00,4.2,183,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Swimming Goggles Anti-Fog Premium',
  'FINA approved swimming accessory for training and recreational swimming.',
  'SPT-00976','Speedo',7,7,
  550,610,325,188,34,
  'swimming,pool,sport',0,0.20,4.5,312,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Kashmir Willow Cricket Bat Lite',
  'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
  'SPT-00977','Gunn & Moore',7,7,
  7570,10900,3995,260,11,
  'cricket,bat,outdoor',0,1.20,4.8,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Splint Carpal Pro',
  'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
  'MED-00978','Beurer',8,6,
  3090,4570,2122,46,34,
  'medical-device,health-monitor,first-aid',0,0.35,3.8,387,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Introduction to Algorithms — Technical Edition Lite',
  'Industry-standard technical reference. Includes code examples and exercises.',
  'BOK-00979','O''Reilly / Pearson',3,3,
  900,1410,612,179,23,
  'programming,technology,reference,textbook',0,0.70,5.0,86,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Z30 Mirrorless Camera Premium',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00980','Canon',1,1,
  57740,80840,29716,209,16,
  'camera,photography,mirrorless',1,0.40,4.6,383,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'GoPro Hero 12 Camera Plus',
  'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
  'ELC-00981','Sony',1,1,
  44640,69640,22861,150,17,
  'camera,photography,mirrorless',0,0.40,4.5,360,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Chyawanprash 500g Neo',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00982','Zandu',8,6,
  190,220,105,259,24,
  'ayurveda,herbal,natural,wellness',0,0.50,3.9,136,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Air Fryer 5.5L Plus',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00983','Philips',5,8,
  5310,5890,3340,295,10,
  'air-fryer,kitchen,healthy-cooking',0,3.50,4.0,292,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Activated Charcoal Capsules 60pcs Advanced',
  'Clinically tested over-the-counter product. Dermatologically tested formula.',
  'MED-00984','Boroline',8,6,
  550,700,267,207,10,
  'otc,skincare,first-aid,health',0,0.12,3.9,269,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Mesh System 3-Pack Pro',
  'High-speed networking device for home and office with easy setup.',
  'ELC-00985','Tenda',1,1,
  13440,17740,7579,33,29,
  'networking,router,wifi,internet',0,0.40,4.0,41,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Espresso Machine Semi-Auto Premium',
  'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
  'APL-00986','Morphy Richards',5,8,
  4790,6510,2397,167,19,
  'kitchen,cooking,countertop',0,2.00,4.1,290,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wrist Wraps Support Advanced',
  'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
  'GYM-00987','RitFit',6,5,
  1640,2350,983,79,22,
  'gym-accessory,fitness,workout',0,0.60,4.0,375,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Pedestal Fan 400mm White Lite',
  'Energy Star rated fan with 5-speed settings and remote control option.',
  'APL-00988','Bajaj',5,8,
  5550,6940,3599,35,33,
  'fan,cooling,home',0,3.50,4.3,67,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Black Puffer Vest Max',
  'Black Puffer Vest — water-resistant and windproof for all-season wear.',
  'CLO-00989','US Polo',2,2,
  4540,5220,2675,187,10,
  'jacket,outerwear,winter',0,0.65,3.8,434,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'ZenBook 14 Laptop Advanced',
  'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
  'ELC-00990','Lenovo',1,1,
  85300,130510,57980,136,37,
  'laptop,computer,notebook,work',0,1.60,3.8,179,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Navy Blue Track Pants Lite',
  'Navy Blue Track Pants in premium stretch fabric. Available in XS, S, M, L, XL, XXL.',
  'CLO-00991','Adidas',2,2,
  990,1260,504,204,25,
  'bottom,trousers,casual',0,0.45,4.5,139,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Whey Protein 1kg Chocolate Max',
  'Lab-tested sports nutrition supplement. Informed Sport certified.',
  'GYM-00992','MyProtein',6,5,
  1510,2360,890,176,17,
  'supplements,protein,nutrition,fitness',0,1.00,4.7,170,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Digital LED Clock Neo',
  'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
  'DEC-00993','Home Centre',4,4,
  3440,4090,2010,267,22,
  'clock,wall-decor,living-room',0,1.20,4.7,389,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Shilajit Resin 30g Premium',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00994','Patanjali',8,6,
  980,1310,448,151,17,
  'ayurveda,herbal,natural,wellness',0,0.50,3.8,353,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Wet Grinder 2L 4J Pro',
  '4-jar mixer grinder with Wet Grinder 2L motor. SS blades, 5-year warranty.',
  'APL-00995','Bajaj',5,8,
  5720,8410,3131,179,33,
  'kitchen,mixer,grinder',0,4.50,3.9,48,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Giloy Juice 500ml Lite',
  '100% natural Ayurvedic formulation. No artificial colours or preservatives.',
  'MED-00996','Baidyanath',8,6,
  430,600,295,133,20,
  'ayurveda,herbal,natural,wellness',0,0.50,4.6,398,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Acrylic Floating Frame Plus',
  'Display your favourite memories beautifully. Easy hanging hardware included.',
  'DEC-00997','Furlenco',4,4,
  660,900,361,205,35,
  'photo-frame,decor,gifting',0,0.40,4.0,226,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Harry Potter Box Set Lite',
  'Curriculum-aligned edition with solved examples, practice questions and answer key.',
  'BOK-00998','Westland Books',3,3,
  520,810,313,266,38,
  'education,textbook,children,academic',0,0.60,4.1,321,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Air Fryer 5.5L Premium',
  'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
  'APL-00999','Philips',5,8,
  4900,7200,2587,54,32,
  'air-fryer,kitchen,healthy-cooking',0,3.50,5.0,45,1);
INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,
  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)
VALUES(
  'Tricep Bar Max',
  'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
  'GYM-01000','Nike',6,5,
  1460,1620,693,230,35,
  'barbell,weights,powerlifting',1,7.00,4.8,419,1);
GO

-- Verification
SELECT c.CategoryName, COUNT(*) AS ProductCount
FROM Products p INNER JOIN Categories c ON c.CategoryID=p.CategoryID
WHERE p.IsActive=1 GROUP BY c.CategoryName ORDER BY ProductCount DESC;
GO