-- ═══════════════════════════════════════════════════════════════════
-- Amazon-style Categories & Products for Deemona
-- Run this AFTER your existing seed_mysql.sql
-- ═══════════════════════════════════════════════════════════════════

USE deemona;

-- ── New Categories ──────────────────────────────────────────────────
INSERT IGNORE INTO Categories (CategoryName, Description) VALUES
('Electronics',        'Mobiles, Laptops, Cameras, Audio & more'),
('Clothing',           'Men, Women & Kids Fashion'),
('Books',              'Books, eBooks & Audiobooks'),
('Home Decor',         'Furniture, Decor & Lighting'),
('Home Appliances',    'Kitchen, Washing, Cooling & Heating'),
('Gym Accessories',    'Fitness Equipment & Supplements'),
('Sports',             'Cricket, Football, Badminton & more'),
('Medicines',          'Health, Wellness & Personal Care'),
('Mobiles',            'Smartphones & Accessories'),
('Computers',          'Laptops, Desktops, Monitors & Peripherals'),
('Cameras',            'DSLR, Mirrorless, Action & Accessories'),
('Audio',              'Headphones, Speakers, Earphones & more'),
('TVs',                'Smart TVs, OLEDs, Projectors & Accessories'),
('Kitchen',            'Cookware, Appliances & Dining'),
('Furniture',          'Sofas, Beds, Tables & Storage'),
('Baby Products',      'Diapers, Toys, Clothing & Feeding'),
('Toys & Games',       'Board Games, Action Figures, Outdoor Toys'),
('Automotive',         'Car & Bike Accessories, Tools'),
('Office Supplies',    'Stationery, Printers & Office Equipment'),
('Beauty',             'Skincare, Haircare, Makeup & Fragrances'),
('Groceries',          'Staples, Snacks, Beverages & Fresh'),
('Pet Supplies',       'Dog, Cat, Bird & Fish Products'),
('Musical Instruments','Guitars, Keyboards, Drums & Accessories'),
('Garden',             'Plants, Tools, Seeds & Outdoor Living'),
('Watches',            'Smartwatches, Analog & Digital Watches'),
('Bags & Luggage',     'Backpacks, Trolleys, Handbags & Wallets'),
('Jewellery',          'Gold, Silver, Diamond & Fashion Jewellery'),
('Footwear',           'Shoes, Sandals, Boots & Sports Footwear'),
('Personal Care',      'Grooming, Hygiene & Wellness'),
('Stationery',         'Pens, Notebooks, Art Supplies & Craft');


-- ── Helper to get category IDs ──────────────────────────────────────
SET @mob  = (SELECT CategoryID FROM Categories WHERE CategoryName='Mobiles' LIMIT 1);
SET @comp = (SELECT CategoryID FROM Categories WHERE CategoryName='Computers' LIMIT 1);
SET @cam  = (SELECT CategoryID FROM Categories WHERE CategoryName='Cameras' LIMIT 1);
SET @aud  = (SELECT CategoryID FROM Categories WHERE CategoryName='Audio' LIMIT 1);
SET @tv   = (SELECT CategoryID FROM Categories WHERE CategoryName='TVs' LIMIT 1);
SET @kit  = (SELECT CategoryID FROM Categories WHERE CategoryName='Kitchen' LIMIT 1);
SET @fur  = (SELECT CategoryID FROM Categories WHERE CategoryName='Furniture' LIMIT 1);
SET @bab  = (SELECT CategoryID FROM Categories WHERE CategoryName='Baby Products' LIMIT 1);
SET @toy  = (SELECT CategoryID FROM Categories WHERE CategoryName='Toys & Games' LIMIT 1);
SET @aut  = (SELECT CategoryID FROM Categories WHERE CategoryName='Automotive' LIMIT 1);
SET @off  = (SELECT CategoryID FROM Categories WHERE CategoryName='Office Supplies' LIMIT 1);
SET @bty  = (SELECT CategoryID FROM Categories WHERE CategoryName='Beauty' LIMIT 1);
SET @gro  = (SELECT CategoryID FROM Categories WHERE CategoryName='Groceries' LIMIT 1);
SET @pet  = (SELECT CategoryID FROM Categories WHERE CategoryName='Pet Supplies' LIMIT 1);
SET @mus  = (SELECT CategoryID FROM Categories WHERE CategoryName='Musical Instruments' LIMIT 1);
SET @gar  = (SELECT CategoryID FROM Categories WHERE CategoryName='Garden' LIMIT 1);
SET @wat  = (SELECT CategoryID FROM Categories WHERE CategoryName='Watches' LIMIT 1);
SET @bag  = (SELECT CategoryID FROM Categories WHERE CategoryName='Bags & Luggage' LIMIT 1);
SET @jew  = (SELECT CategoryID FROM Categories WHERE CategoryName='Jewellery' LIMIT 1);
SET @fot  = (SELECT CategoryID FROM Categories WHERE CategoryName='Footwear' LIMIT 1);
SET @prc  = (SELECT CategoryID FROM Categories WHERE CategoryName='Personal Care' LIMIT 1);
SET @sta  = (SELECT CategoryID FROM Categories WHERE CategoryName='Stationery' LIMIT 1);
SET @clo  = (SELECT CategoryID FROM Categories WHERE CategoryName='Clothing' LIMIT 1);
SET @spt  = (SELECT CategoryID FROM Categories WHERE CategoryName='Sports' LIMIT 1);
SET @elc  = (SELECT CategoryID FROM Categories WHERE CategoryName='Electronics' LIMIT 1);
SET @gym  = (SELECT CategoryID FROM Categories WHERE CategoryName='Gym Accessories' LIMIT 1);
SET @med  = (SELECT CategoryID FROM Categories WHERE CategoryName='Medicines' LIMIT 1);
SET @boo  = (SELECT CategoryID FROM Categories WHERE CategoryName='Books' LIMIT 1);
SET @hom  = (SELECT CategoryID FROM Categories WHERE CategoryName='Home Decor' LIMIT 1);
SET @app  = (SELECT CategoryID FROM Categories WHERE CategoryName='Home Appliances' LIMIT 1);

-- ═══════════════════════════════════════════════════════════════════
-- MOBILES (20 products)
-- ═══════════════════════════════════════════════════════════════════
INSERT INTO Products (Name,Description,SKU,Brand,CategoryID,Price,MRP,CostPrice,StockQuantity,ReorderLevel,IsFeatured,IsActive,ShowPublicly,Tags,ImageURLs) VALUES
('Samsung Galaxy S24 Ultra','200MP camera, S-Pen, 12GB RAM, 256GB','MOB-001','Samsung',@mob,124999,134999,89999,49,10,1,1,1,'samsung,mobile,flagship,android','["https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500"]'),
('iPhone 15 Pro Max','A17 Pro chip, 48MP, Titanium, 256GB','MOB-002','Apple',@mob,159900,169900,119999,35,5,1,1,1,'iphone,apple,ios,flagship','["https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?w=500"]'),
('OnePlus 12','Snapdragon 8 Gen 3, 50MP, 16GB RAM','MOB-003','OnePlus',@mob,64999,69999,49999,60,10,1,1,1,'oneplus,android,5g,flagship','["https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?w=500"]'),
('Google Pixel 8 Pro','Google AI camera, 7 years updates, 128GB','MOB-004','Google',@mob,84999,92999,64999,40,8,0,1,1,'google,pixel,android,camera','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Xiaomi 14 Ultra','Leica camera, Snapdragon 8 Gen 3, 512GB','MOB-005','Xiaomi',@mob,99999,109999,74999,30,5,1,1,1,'xiaomi,leica,camera,flagship','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Realme GT 5 Pro','Snapdragon 8 Gen 3, 144Hz, 50MP','MOB-006','Realme',@mob,39999,44999,28999,80,15,0,1,1,'realme,gaming,5g,fast','["https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500"]'),
('Vivo X100 Pro','V3 chip, Zeiss camera, 5000mAh','MOB-007','Vivo',@mob,89999,94999,67999,25,5,0,1,1,'vivo,zeiss,camera,5g','["https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?w=500"]'),
('Samsung Galaxy A55','50MP OIS, 5000mAh, 8GB RAM, IP67','MOB-008','Samsung',@mob,34999,38999,24999,100,20,0,1,1,'samsung,midrange,5g,battery','["https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?w=500"]'),
('iPhone 15','A16 Bionic, 48MP, Dynamic Island, 128GB','MOB-009','Apple',@mob,79900,84900,59999,45,8,1,1,1,'iphone,apple,ios,camera','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('Redmi Note 13 Pro+','200MP, 120W charging, 12GB RAM','MOB-010','Xiaomi',@mob,29999,32999,19999,120,25,0,1,1,'redmi,budget,camera,fast','["https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500"]'),
('OPPO Reno 11 Pro','50MP portrait, Hasselblad tuning, 256GB','MOB-011','OPPO',@mob,39999,44999,29999,55,10,0,1,1,'oppo,camera,portrait,5g','["https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?w=500"]'),
('Motorola Edge 50 Pro','125W turbocharging, 50MP, 144Hz','MOB-012','Motorola',@mob,31999,34999,22999,70,12,0,1,1,'motorola,fast,5g,battery','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Samsung Galaxy Z Fold 5','Foldable, 12GB RAM, S-Pen support','MOB-013','Samsung',@mob,154999,164999,119999,15,3,1,1,1,'samsung,foldable,flagship,5g','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Nothing Phone 2a','Glyph interface, Dimensity 7200 Pro','MOB-014','Nothing',@mob,24999,27999,17999,90,18,0,1,1,'nothing,design,android,unique','["https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500"]'),
('iQOO 12','Snapdragon 8 Gen 3, 50W wireless, gaming','MOB-015','iQOO',@mob,52999,57999,38999,40,8,0,1,1,'iqoo,gaming,5g,fast','["https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- COMPUTERS & LAPTOPS (15 products)
-- ═══════════════════════════════════════════════════════════════════
('MacBook Air M3','Apple M3, 8GB, 256GB SSD, 13.6 inch','LAP-001','Apple',@comp,114900,119900,89999,30,5,1,1,1,'macbook,apple,m3,laptop','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Dell XPS 15','Intel i9, 32GB, RTX 4060, 15.6 inch OLED','LAP-002','Dell',@comp,189900,199900,149999,15,3,1,1,1,'dell,xps,laptop,gaming','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),
('HP Spectre x360','Intel i7, 16GB, 512GB, 2-in-1, 14 inch','LAP-003','HP',@comp,129900,139900,99999,20,4,0,1,1,'hp,spectre,2in1,laptop','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Lenovo ThinkPad X1 Carbon','i7, 16GB, 512GB, 14 inch, Business','LAP-004','Lenovo',@comp,139900,149900,104999,18,4,0,1,1,'lenovo,thinkpad,business,laptop','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),
('ASUS ROG Strix G16','Ryzen 9, 32GB, RTX 4070, 16 inch 240Hz','LAP-005','ASUS',@comp,164900,174900,124999,12,3,1,1,1,'asus,rog,gaming,laptop','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Acer Swift X','AMD Ryzen 7, RTX 3050, 16GB, 14 inch','LAP-006','Acer',@comp,74900,79900,56999,35,7,0,1,1,'acer,swift,laptop,creator','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),
('MacBook Pro 14 M3 Pro','M3 Pro, 18GB, 512GB, Liquid Retina XDR','LAP-007','Apple',@comp,199900,209900,159999,10,2,1,1,1,'macbook,pro,apple,m3','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Samsung Galaxy Book4 Pro','Intel Ultra 7, 16GB, AMOLED, 14 inch','LAP-008','Samsung',@comp,129900,139900,99999,22,5,0,1,1,'samsung,galaxy,laptop,amoled','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),
('Logitech MX Master 3S','Wireless mouse, 8K DPI, ergonomic','PER-001','Logitech',@comp,8995,9995,5999,150,30,0,1,1,'logitech,mouse,wireless,ergonomic','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Keychron K2 Pro','Mechanical keyboard, RGB, wireless, QMK','PER-002','Keychron',@comp,11999,13999,8999,80,15,0,1,1,'keychron,mechanical,keyboard,wireless','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),
('Dell UltraSharp 27 4K','IPS, 4K, USB-C, 60Hz, sRGB 99%','MON-001','Dell',@comp,49999,54999,37999,25,5,0,1,1,'dell,monitor,4k,ultrasharp','["https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500"]'),
('Samsung 970 EVO Plus 1TB','NVMe SSD, 3500 MB/s read speed','STO-001','Samsung',@comp,8999,9999,5999,200,40,0,1,1,'samsung,ssd,nvme,storage','["https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- CAMERAS (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Sony Alpha A7 IV','33MP full-frame, 4K60, IBIS, mirrorless','CAM-001','Sony',@cam,249990,264990,199999,8,2,1,1,1,'sony,mirrorless,fullframe,camera','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('Canon EOS R6 Mark II','24.2MP, 4K60, IBIS, full-frame','CAM-002','Canon',@cam,229990,244990,184999,10,2,1,1,1,'canon,eos,mirrorless,camera','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('Nikon Z6 III','24.5MP, 6K RAW, EXPEED 7, hybrid camera','CAM-003','Nikon',@cam,249990,264990,199999,6,2,0,1,1,'nikon,mirrorless,fullframe,6k','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('GoPro Hero 12 Black','5.3K60, HyperSmooth 6.0, waterproof','CAM-004','GoPro',@cam,39999,44999,28999,50,10,1,1,1,'gopro,action,waterproof,adventure','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('DJI Mini 4 Pro','4K60 HDR drone, 34 min, obstacle sensing','CAM-005','DJI',@cam,94999,104999,74999,15,3,1,1,1,'dji,drone,4k,aerial','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('Fujifilm X100VI','40MP, retro design, IBIS, 6.2K video','CAM-006','Fujifilm',@cam,174990,184990,139999,12,2,0,1,1,'fujifilm,retro,compact,camera','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('Sony 85mm F1.4 GM Lens','Prime portrait lens, ultra sharp','LEN-001','Sony',@cam,169990,179990,134999,5,1,0,1,1,'sony,lens,portrait,prime','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),
('Canon EF 50mm F1.8 STM','Nifty fifty, versatile prime lens','LEN-002','Canon',@cam,9999,11999,6999,100,20,0,1,1,'canon,lens,50mm,prime','["https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- AUDIO (12 products)
-- ═══════════════════════════════════════════════════════════════════
('Sony WH-1000XM5','Industry-leading ANC, 30hr battery','AUD-001','Sony',@aud,26990,29990,19999,80,15,1,1,1,'sony,headphone,anc,wireless','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Apple AirPods Pro 2','H2 chip, ANC, Transparency, MagSafe','AUD-002','Apple',@aud,24900,26900,18999,70,12,1,1,1,'airpods,apple,anc,earbuds','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Bose QuietComfort 45','Legendary ANC, 24hr, foldable','AUD-003','Bose',@aud,29900,32900,22999,45,8,0,1,1,'bose,quietcomfort,anc,headphone','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('JBL Charge 5','Portable speaker, IP67, 20hr, powerbank','AUD-004','JBL',@aud,14999,16999,9999,100,20,1,1,1,'jbl,speaker,bluetooth,waterproof','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Samsung Galaxy Buds3 Pro','ANC, 360 audio, IP57, 6hr+','AUD-005','Samsung',@aud,17999,19999,12999,60,12,0,1,1,'samsung,buds,anc,earbuds','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('boAt Rockerz 450','40hr, Bluetooth 5.0, foldable','AUD-006','boAt',@aud,1499,2499,799,300,50,0,1,1,'boat,headphone,budget,wireless','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Sony SRS-XB33','Extra bass, IP67, 24hr, party speaker','AUD-007','Sony',@aud,9999,12999,6999,80,15,0,1,1,'sony,speaker,bass,waterproof','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Sennheiser HD 660S2','Open-back audiophile headphone','AUD-008','Sennheiser',@aud,44990,49990,34999,15,3,0,1,1,'sennheiser,audiophile,headphone,hifi','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('Marshall Emberton III','Compact portable, 32hr, IP67','AUD-009','Marshall',@aud,13999,15999,9999,60,10,0,1,1,'marshall,speaker,portable,rock','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),
('realme Buds Air 5 Pro','42dB ANC, LDAC, 38hr total','AUD-010','Realme',@aud,4999,5999,2999,150,30,0,1,1,'realme,earbuds,anc,budget','["https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- TVs (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Samsung 65" QLED 4K','QN90C, 4K, 144Hz, Neo QLED, Smart','TV-001','Samsung',@tv,189999,209999,149999,10,2,1,1,1,'samsung,qled,4k,smart,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('LG 55" OLED C3','OLED evo, 4K, 120Hz, webOS, gaming','TV-002','LG',@tv,149999,169999,114999,12,3,1,1,1,'lg,oled,4k,gaming,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('Sony Bravia 7 55"','Mini LED, 4K, 120Hz, Google TV','TV-003','Sony',@tv,139999,154999,109999,8,2,0,1,1,'sony,bravia,miniled,4k,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('Mi 43" 4K UHD','PatchWall, 4K, Dolby Vision, Smart','TV-004','Xiaomi',@tv,29999,34999,19999,50,10,0,1,1,'xiaomi,mi,4k,smart,budget','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('OnePlus 50" Y Series','4K, 60Hz, Android TV, Dolby Audio','TV-005','OnePlus',@tv,34999,39999,24999,40,8,0,1,1,'oneplus,4k,android,smart,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('Hisense 65" U8K Mini LED','Mini LED ULED, 4K, 144Hz, IMAX Enhanced','TV-006','Hisense',@tv,129999,144999,99999,15,3,0,1,1,'hisense,miniled,4k,gaming,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('TCL 55" C845','Mini LED QLED, 144Hz, 4K, Google TV','TV-007','TCL',@tv,79999,89999,59999,20,4,0,1,1,'tcl,qled,miniled,4k,tv','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),
('Fire TV Stick 4K Max','4K streaming, Wi-Fi 6E, Alexa remote','TV-008','Amazon',@tv,6499,7999,3999,200,40,0,1,1,'firetv,4k,streaming,amazon,stick','["https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- KITCHEN (12 products)
-- ═══════════════════════════════════════════════════════════════════
('Instant Pot Duo 7-in-1','Pressure cooker, slow cooker, 6qt','KIT-001','Instant Pot',@kit,8999,10999,5999,80,15,1,1,1,'instant pot,pressure cooker,kitchen','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Philips Air Fryer XXL','7L capacity, 90% less fat, digital','KIT-002','Philips',@kit,12999,14999,8999,60,12,1,1,1,'philips,airfryer,healthy,kitchen','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Ninja Foodi Smart Grill','Indoor grill, air fryer, 6-in-1','KIT-003','Ninja',@kit,15999,18999,10999,35,8,0,1,1,'ninja,grill,airfryer,kitchen','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('KitchenAid Stand Mixer','5.5L, 10 speeds, tilt-head, 325W','KIT-004','KitchenAid',@kit,54999,59999,41999,12,3,0,1,1,'kitchenaid,mixer,baking,kitchen','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Prestige Svachh Cooker','5L aluminium pressure cooker, ISI','KIT-005','Prestige',@kit,1599,1999,899,200,40,0,1,1,'prestige,cooker,pressure,indian','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Morphy Richards OTG 60L','60L, 6 heating modes, 2000W','KIT-006','Morphy Richards',@kit,8999,10999,5999,45,10,0,1,1,'morphy,otg,oven,baking','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Milton Thermosteel Flask 1L','24hr hot, 48hr cold, stainless','KIT-007','Milton',@kit,899,1199,449,400,80,0,1,1,'milton,flask,thermos,stainless','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Pigeon Handy Chopper','5 blades, 400ml, vegetable cutter','KIT-008','Pigeon',@kit,349,499,149,500,100,0,1,1,'pigeon,chopper,vegetable,kitchen','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Borosil Glass Casserole 1L','Borosilicate, microwave safe','KIT-009','Borosil',@kit,599,799,299,300,60,0,1,1,'borosil,glass,casserole,microwave','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),
('Hawkins Contura Pressure Cooker 3L','Aluminium, hard anodised, ISI mark','KIT-010','Hawkins',@kit,2299,2799,1299,150,30,0,1,1,'hawkins,pressure,cooker,aluminium','["https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- BEAUTY (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Lakme 9to5 Foundation','Matte finish, 25ml, SPF 30','BTY-001','Lakme',@bty,599,699,299,300,60,0,1,1,'lakme,foundation,makeup,indian','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Mamaearth Vitamin C Serum','10% Vitamin C, glow serum, 30ml','BTY-002','Mamaearth',@bty,599,699,299,400,80,1,1,1,'mamaearth,vitamin c,serum,skincare','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Wow Apple Cider Vinegar Shampoo','No sulphate, paraben free, 300ml','BTY-003','Wow',@bty,399,499,179,500,100,0,1,1,'wow,shampoo,haircare,natural','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('LOreal Paris Revitalift','Anti-wrinkle cream, SPF 28, 50ml','BTY-004','LOreal',@bty,799,999,399,200,40,0,1,1,'loreal,anti aging,cream,skincare','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Nykaa Cosmetics Lipstick','Matte finish, 12 shades, long lasting','BTY-005','Nykaa',@bty,449,549,199,400,80,0,1,1,'nykaa,lipstick,matte,makeup','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Biotique Bio Papaya Scrub','Removes dead skin, 75g, natural','BTY-006','Biotique',@bty,149,199,69,600,120,0,1,1,'biotique,scrub,natural,skincare','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Dove Body Lotion 400ml','Deep moisture, 48hr hydration','BTY-007','Dove',@bty,299,349,139,500,100,0,1,1,'dove,lotion,moisturizer,body','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Philips BT3231 Beard Trimmer','20 length settings, 90min, Li-ion','BTY-008','Philips',@bty,1299,1599,699,200,40,1,1,1,'philips,trimmer,beard,grooming','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Plum Goodness Green Tea Moisturizer','Oil-free, 50ml, for oily skin','BTY-009','Plum',@bty,349,449,149,350,70,0,1,1,'plum,moisturizer,green tea,skincare','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Forest Essentials Facial Moisturizer','Ayurvedic, saffron, 30ml luxury','BTY-010','Forest Essentials',@bty,1650,1995,999,100,20,0,1,1,'forest essentials,luxury,ayurvedic,skincare','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- WATCHES (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Apple Watch Series 9','GPS, 41mm, crash detection, ECG','WAT-001','Apple',@wat,41900,44900,32999,40,8,1,1,1,'apple watch,smartwatch,health,gps','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Samsung Galaxy Watch 6','1.5", sapphire glass, BIA sensor','WAT-002','Samsung',@wat,29999,32999,22999,50,10,1,1,1,'samsung,galaxy watch,smartwatch,health','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Garmin Forerunner 265','AMOLED, running metrics, HRV status','WAT-003','Garmin',@wat,44999,49999,34999,20,4,0,1,1,'garmin,running,gps,sports,watch','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Titan Kairos Smartwatch','AMOLED, SpO2, 7 day battery, IPX7','WAT-004','Titan',@wat,9999,11999,6999,80,15,0,1,1,'titan,smartwatch,indian,budget','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('boAt Wave Sigma','1.69" display, SpO2, 7 days, health','WAT-005','boAt',@wat,1799,2499,799,300,60,0,1,1,'boat,smartwatch,budget,health','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Casio G-Shock GA-2100','Carbon Core, solar, 200m water resist','WAT-006','Casio',@wat,8999,9999,5999,60,12,0,1,1,'casio,gshock,analog,rugged','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Fossil Gen 6 Smartwatch','Wear OS, SpO2, GPS, 44mm stainless','WAT-007','Fossil',@wat,18999,21999,13999,25,5,0,1,1,'fossil,smartwatch,wear os,fashion','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Titan Raga Analog Watch','Rose gold, mesh strap, ladies','WAT-008','Titan',@wat,6995,7995,4499,80,15,0,1,1,'titan,raga,ladies,analog','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Noise Colorfit Ultra','1.96" AMOLED, BT calling, health suite','WAT-009','Noise',@wat,3499,4999,1799,200,40,0,1,1,'noise,smartwatch,budget,calling','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),
('Orient Ray II Diver','200m, automatic, NH36, sapphire','WAT-010','Orient',@wat,16999,19999,11999,20,4,0,1,1,'orient,diver,automatic,mechanical','["https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- BAGS & LUGGAGE (8 products)
-- ═══════════════════════════════════════════════════════════════════
('American Tourister Trolley 68cm','4 wheels, TSA lock, expandable','BAG-001','American Tourister',@bag,5999,7999,3499,50,10,1,1,1,'american tourister,luggage,travel,trolley','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Samsonite Backpack 25L','Laptop 15.6", water resistant, USB','BAG-002','Samsonite',@bag,3999,4999,2299,100,20,0,1,1,'samsonite,backpack,laptop,travel','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Wildcraft Backpack 45L','Hiking, waterproof, MOLLE, trekking','BAG-003','Wildcraft',@bag,2999,3999,1699,80,15,0,1,1,'wildcraft,hiking,backpack,outdoor','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Lavie Women Handbag','PU leather, shoulder bag, stylish','BAG-004','Lavie',@bag,1299,1799,699,150,30,0,1,1,'lavie,handbag,women,fashion','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Fossil Men Wallet','RFID blocking, genuine leather','BAG-005','Fossil',@bag,2499,2999,1399,200,40,0,1,1,'fossil,wallet,leather,rfid','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Nasher Miles Cabin Luggage 55cm','Hard shell, 4 wheels, lightweight','BAG-006','Nasher Miles',@bag,3999,5499,2299,40,8,0,1,1,'nasher miles,cabin,luggage,travel','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Skybags Footloose Backpack 36L','School/college bag, 2 compartments','BAG-007','Skybags',@bag,1299,1699,699,200,40,0,1,1,'skybags,backpack,school,college','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),
('Safari Trolley 75cm','Large, expandable, number lock, durable','BAG-008','Safari',@bag,4999,6499,2999,35,7,0,1,1,'safari,trolley,large,travel','["https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- FOOTWEAR (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Nike Air Max 270','Air cushioning, lifestyle sneaker','FOT-001','Nike',@fot,12995,14995,8999,80,15,1,1,1,'nike,air max,sneaker,running','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Adidas Ultraboost 23','Boost midsole, Primeknit, running','FOT-002','Adidas',@fot,15999,17999,11999,60,12,1,1,1,'adidas,ultraboost,running,premium','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Bata Comfit Sandals','Leather, casual, comfort footbed','FOT-003','Bata',@fot,1299,1599,699,200,40,0,1,1,'bata,sandals,comfort,casual','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Woodland Trekking Shoes','Waterproof, lace-up, high ankle','FOT-004','Woodland',@fot,3999,4999,2299,80,15,0,1,1,'woodland,trekking,outdoor,waterproof','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Puma Suede Classic','Iconic design, suede upper, casual','FOT-005','Puma',@fot,5999,6999,3999,100,20,0,1,1,'puma,suede,classic,sneaker','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Red Tape Formal Shoe','Genuine leather, Oxford, Derby style','FOT-006','Red Tape',@fot,2499,3499,1399,120,25,0,1,1,'red tape,formal,leather,oxford','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Crocs Classic Clog','Lightweight, slip-resistant, beach','FOT-007','Crocs',@fot,3499,3999,1999,150,30,0,1,1,'crocs,clog,comfortable,waterproof','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Metro Women Heels','Block heels, party wear, 3 inch','FOT-008','Metro',@fot,1999,2499,999,100,20,0,1,1,'metro,heels,women,party','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('Skechers Go Walk 7','Memory foam, slip-on, comfort walking','FOT-009','Skechers',@fot,4499,4999,2799,80,15,0,1,1,'skechers,walking,comfort,slip on','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),
('HRX Runner Shoes','Hrithik brand, mesh, cushioned sole','FOT-010','HRX',@fot,1799,2199,899,150,30,0,1,1,'hrx,runner,budget,mesh','["https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- BABY PRODUCTS (8 products)
-- ═══════════════════════════════════════════════════════════════════
('Pampers Premium Care Diapers S64','Extra soft, 12hr protection, newborn','BAB-001','Pampers',@bab,999,1199,549,500,100,1,1,1,'pampers,diapers,baby,newborn','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Johnson Baby Powder 200g','No tears, dermatologist tested','BAB-002','Johnsons',@bab,199,249,89,800,150,0,1,1,'johnsons,baby,powder,gentle','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Mee Mee Baby Pram','3-in-1, reversible, sunshade, storage','BAB-003','Mee Mee',@bab,5999,7499,3799,20,4,0,1,1,'mee mee,pram,stroller,baby','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Philips Avent Bottle 260ml','Natural, slow flow, anti-colic','BAB-004','Philips',@bab,799,999,399,200,40,0,1,1,'philips,avent,bottle,feeding','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Fisher-Price Newborn Rocker','Vibration, music, soothing for babies','BAB-005','Fisher-Price',@bab,3499,4499,1999,30,6,0,1,1,'fisher price,rocker,baby,soothing','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Himalaya Baby Body Lotion 200ml','Nourishing, gentle, natural formula','BAB-006','Himalaya',@bab,249,299,99,600,120,0,1,1,'himalaya,baby,lotion,natural','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Chicco Baby Monitor','Digital, 300m range, night vision','BAB-007','Chicco',@bab,6999,8499,4499,15,3,0,1,1,'chicco,baby monitor,safety,digital','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Huggies Wonder Pants M60','Pant style, 360 stretch waistband','BAB-008','Huggies',@bab,849,999,449,400,80,0,1,1,'huggies,pants,diapers,baby','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- TOYS & GAMES (8 products)
-- ═══════════════════════════════════════════════════════════════════
('LEGO Technic Lamborghini','2696 pieces, 1:8 scale, collectible','TOY-001','LEGO',@toy,22999,24999,17999,15,3,1,1,1,'lego,technic,lamborghini,collector','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Monopoly Classic Board Game','Family game, 2-8 players, ages 8+','TOY-002','Hasbro',@toy,799,999,399,200,40,0,1,1,'monopoly,board game,family,hasbro','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Catan Board Game','Strategy, 3-4 players, 12+ years','TOY-003','Catan',@toy,3499,3999,1999,50,10,0,1,1,'catan,strategy,board game,settler','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Hot Wheels 20 Car Gift Pack','Die-cast cars, 1:64 scale, assorted','TOY-004','Hot Wheels',@toy,599,699,299,400,80,0,1,1,'hot wheels,cars,diecast,kids','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Funskool Scrabble','Word game, 2-4 players, 200 tiles','TOY-005','Funskool',@toy,499,599,249,200,40,0,1,1,'scrabble,word,board game,family','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('UNO Card Game','Classic card game, 112 cards, family','TOY-006','Mattel',@toy,299,399,149,400,80,0,1,1,'uno,card game,family,mattel','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Play-Doh 10 Pack','Non-toxic, 10 colors, modeling clay','TOY-007','Play-Doh',@toy,499,599,249,300,60,0,1,1,'playdoh,clay,kids,creative','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Barbie Dreamhouse','3 stories, 8 rooms, 70+ accessories','TOY-008','Barbie',@toy,9999,11999,6999,20,4,0,1,1,'barbie,dreamhouse,doll,girls','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- PET SUPPLIES (8 products)
-- ═══════════════════════════════════════════════════════════════════
('Pedigree Adult Dog Food 10kg','Complete nutrition, chicken & rice','PET-001','Pedigree',@pet,1899,2199,999,100,20,1,1,1,'pedigree,dog food,adult,nutrition','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Whiskas Cat Food 1.2kg','Ocean fish flavor, 7+ vitamins','PET-002','Whiskas',@pet,499,599,249,200,40,0,1,1,'whiskas,cat food,ocean fish,cats','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Drools Focus Dog Treats 500g','Chicken biscuits, training treats','PET-003','Drools',@pet,299,399,149,300,60,0,1,1,'drools,treats,dog,chicken','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Pet Park Anti-flea Shampoo 200ml','Neem & tulsi, safe for dogs & cats','PET-004','Pet Park',@pet,199,249,89,400,80,0,1,1,'pet shampoo,flea,neem,safe','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Trixie Dog Leash 120cm','Reflective, padded handle, 15mm nylon','PET-005','Trixie',@pet,349,449,179,300,60,0,1,1,'trixie,leash,dog,reflective','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Savic Dog Crate M','Steel wire, foldable, safe travel','PET-006','Savic',@pet,2999,3499,1799,25,5,0,1,1,'savic,crate,dog,travel','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Catit Water Fountain 2L','Multi-flow, carbon filter, quiet','PET-007','Catit',@pet,2499,2999,1499,40,8,0,1,1,'catit,fountain,cat,water','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('PawZz Dog Toys Set 6pc','Chew toys, rope, squeaky, assorted','PET-008','PawZz',@pet,599,799,299,200,40,0,1,1,'pawzz,dog toys,chew,set','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- GROCERY (10 products)
-- ═══════════════════════════════════════════════════════════════════
('Aashirvaad Atta 10kg','Whole wheat, chakki fresh, nutritious','GRO-001','Aashirvaad',@gro,499,549,249,500,100,1,1,1,'aashirvaad,atta,wheat,flour','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Tata Tea Premium 500g','Strong CTC tea, refreshing brew','GRO-002','Tata Tea',@gro,249,279,119,600,120,0,1,1,'tata tea,tea,beverage,indian','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Nescafe Classic 200g','Rich aroma, smooth taste, instant','GRO-003','Nescafe',@gro,499,549,249,400,80,0,1,1,'nescafe,coffee,instant,classic','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Dabur Honey 1kg','100% pure, raw honey, no sugar','GRO-004','Dabur',@gro,349,399,169,400,80,0,1,1,'dabur,honey,natural,pure','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Fortune Sunflower Oil 5L','Light, healthy cooking oil, vitamin E','GRO-005','Fortune',@gro,699,749,349,300,60,0,1,1,'fortune,oil,sunflower,cooking','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('India Gate Basmati Rice 5kg','Extra long grain, aged, premium','GRO-006','India Gate',@gro,549,599,274,400,80,0,1,1,'india gate,basmati,rice,premium','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Amul Ghee 1L','Pure cow ghee, tin pack, traditional','GRO-007','Amul',@gro,599,649,299,300,60,1,1,1,'amul,ghee,cow,pure','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('MDH Chana Masala 100g','Authentic spice blend, Indian cuisine','GRO-008','MDH',@gro,55,65,25,1000,200,0,1,1,'mdh,masala,spice,chana','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Haldirams Aloo Bhujia 400g','Crispy, spicy, popular Indian snack','GRO-009','Haldirams',@gro,199,219,89,600,120,0,1,1,'haldirams,bhujia,snack,indian','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Maggi Masala Noodles 12 Pack','2-minute noodles, classic masala','GRO-010','Nestle',@gro,199,219,89,800,150,1,1,1,'maggi,noodles,instant,masala','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- MUSICAL INSTRUMENTS (6 products)
-- ═══════════════════════════════════════════════════════════════════
('Yamaha F310 Acoustic Guitar','Steel string, spruce top, beginners','MUS-001','Yamaha',@mus,8999,10999,5999,25,5,1,1,1,'yamaha,guitar,acoustic,beginner','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Casio CT-S300 Keyboard','61 keys, 48 polyphony, 400 tones','MUS-002','Casio',@mus,5999,6999,3799,30,6,0,1,1,'casio,keyboard,piano,beginner','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Pearl Export Drum Kit','5-piece, fusion, hardware included','MUS-003','Pearl',@mus,34999,39999,24999,8,2,0,1,1,'pearl,drums,kit,acoustic','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Fender Player Stratocaster','Maple neck, alnico V pickups, electric','MUS-004','Fender',@mus,64999,69999,49999,5,1,0,1,1,'fender,stratocaster,electric,guitar','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Cajon Box Drum','Birch, professional, with bass sound','MUS-005','Meinl',@mus,8999,10999,5499,20,4,0,1,1,'cajon,drum,percussion,portable','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),
('Focusrite Scarlett Solo Studio','USB audio interface, recording bundle','MUS-006','Focusrite',@mus,18999,21999,13999,15,3,0,1,1,'focusrite,audio interface,recording,studio','["https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- AUTOMOTIVE (8 products)
-- ═══════════════════════════════════════════════════════════════════
('3M Car Care Kit','Wash, polish, wax, interior cleaner','AUT-001','3M',@aut,1999,2499,999,150,30,0,1,1,'3m,car care,cleaning,kit','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Michelin Tyre Inflator','Digital, auto cut-off, 12V, compact','AUT-002','Michelin',@aut,2499,2999,1299,100,20,0,1,1,'michelin,tyre,inflator,digital','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Varta Car Battery 55Ah','Maintenance free, 55Ah, 500CCA','AUT-003','Varta',@aut,5999,6999,3999,30,6,0,1,1,'varta,battery,car,maintenance free','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Garmin DriveSmart 65 GPS','6.95", live traffic, India maps','AUT-004','Garmin',@aut,14999,17999,9999,20,4,0,1,1,'garmin,gps,navigation,car','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Portronics Car Power 25W','Dual USB-C, quick charge, universal','AUT-005','Portronics',@aut,799,999,399,300,60,0,1,1,'portronics,car charger,usb,fast','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('TP-LINK Dash Cam 4K','4K UHD, night vision, loop recording','AUT-006','TP-Link',@aut,7999,9999,4999,40,8,0,1,1,'tp link,dash cam,4k,camera','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Royal Enfield Helmet Stealth','ECE certified, dual visor, ventilated','AUT-007','Royal Enfield',@aut,4999,5999,2999,50,10,0,1,1,'royal enfield,helmet,bike,safety','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Bosch Car Vacuum Cleaner','Wet & dry, 12V, 60W, compact','AUT-008','Bosch',@aut,1999,2499,999,80,15,0,1,1,'bosch,vacuum,car,wet dry','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),

-- ═══════════════════════════════════════════════════════════════════
-- OFFICE SUPPLIES (8 products)  
-- ═══════════════════════════════════════════════════════════════════
('Parker Frontier Ballpen','Stainless, medium nib, gift box','OFF-001','Parker',@off,599,699,299,300,60,0,1,1,'parker,pen,gift,ballpoint','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('HP LaserJet Pro M404n','Mono laser, 38ppm, duplex, LAN','OFF-002','HP',@off,24999,28999,18999,15,3,0,1,1,'hp,printer,laser,office','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Epson L3252 Ink Tank Printer','WiFi, EcoTank, color, multifuntion','OFF-003','Epson',@off,14999,16999,10999,20,4,1,1,1,'epson,inkjet,wifi,printer','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Classmate Notebook A4 Pack of 6','180 pages, ruled, student notebook','OFF-004','Classmate',@off,199,249,89,1000,200,0,1,1,'classmate,notebook,student,ruled','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Scotch Magic Tape 12 Rolls','19mm x 33m, invisible, removable','OFF-005','Scotch',@off,349,399,169,400,80,0,1,1,'scotch,tape,office,transparent','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Faber Castell Staedtler Pencil 12pk','HB grade, hexagonal, break resistant','OFF-006','Faber Castell',@off,149,199,69,600,120,0,1,1,'faber castell,pencil,hb,drawing','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('Kensington Pro Fit Mouse','Wired, USB, 1000 DPI, ergonomic','OFF-007','Kensington',@off,799,999,399,200,40,0,1,1,'kensington,mouse,wired,office','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]'),
('AmazonBasics Stapler 25 Sheet','Standard, with 1000 staples included','OFF-008','AmazonBasics',@off,299,349,139,300,60,0,1,1,'amazon,stapler,office,basic','["https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500"]');

SELECT CONCAT('Total products: ', COUNT(*)) AS result FROM Products WHERE IsActive=1;
SELECT CONCAT('Total categories: ', COUNT(*)) AS result FROM Categories;

