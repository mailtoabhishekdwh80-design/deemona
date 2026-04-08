import subprocess

sql = """USE deemona;

SET @fur = (SELECT CategoryID FROM Categories WHERE CategoryName='Furniture' LIMIT 1);
SET @gar = (SELECT CategoryID FROM Categories WHERE CategoryName='Garden' LIMIT 1);
SET @jew = (SELECT CategoryID FROM Categories WHERE CategoryName='Jewellery' LIMIT 1);
SET @prc = (SELECT CategoryID FROM Categories WHERE CategoryName='Personal Care' LIMIT 1);
SET @sta = (SELECT CategoryID FROM Categories WHERE CategoryName='Stationery' LIMIT 1);

INSERT IGNORE INTO Products (Name,Description,SKU,Brand,CategoryID,Price,MRP,CostPrice,StockQuantity,ReorderLevel,IsFeatured,IsActive,ShowPublicly,Tags,ImageURLs) VALUES

-- FURNITURE
('Wakefit Orthopaedic Memory Foam Mattress','6 inch, Queen size, 10 year warranty','FUR-001','Wakefit',@fur,12999,17999,8999,30,5,1,1,1,'mattress,memory foam,queen,wakefit','["https://images.pexels.com/photos/1648776/pexels-photo-1648776.jpeg?w=500"]'),
('Nilkamal Plastic Chair','Heavy duty, weather resistant, stackable','FUR-002','Nilkamal',@fur,899,1299,499,200,40,0,1,1,'chair,plastic,outdoor,nilkamal','["https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=500"]'),
('Godrej Interio Bookshelf','5 shelf, engineered wood, walnut finish','FUR-003','Godrej',@fur,7999,9999,5499,20,4,0,1,1,'bookshelf,godrej,wood,storage','["https://images.pexels.com/photos/1648776/pexels-photo-1648776.jpeg?w=500"]'),
('Urban Ladder Sofa 3 Seater','Fabric, wooden legs, comfortable, modern','FUR-004','Urban Ladder',@fur,24999,32999,17999,10,2,1,1,1,'sofa,3 seater,fabric,modern','["https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=500"]'),
('IKEA KALLAX Shelf Unit','4x4 cubes, white, 147x147cm storage','FUR-005','IKEA',@fur,14999,16999,10999,15,3,0,1,1,'ikea,kallax,shelf,storage','["https://images.pexels.com/photos/1648776/pexels-photo-1648776.jpeg?w=500"]'),
('Durian Dining Table 6 Seater','Solid wood, rectangular, premium finish','FUR-006','Durian',@fur,34999,44999,24999,8,2,0,1,1,'dining table,6 seater,wood,durian','["https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=500"]'),
('Pepperfry Study Table','Engineered wood, 120cm, with drawer, walnut','FUR-007','Pepperfry',@fur,5999,7999,3999,25,5,0,1,1,'study table,desk,wood,home office','["https://images.pexels.com/photos/1648776/pexels-photo-1648776.jpeg?w=500"]'),
('Sleepwell Ortho Pro Mattress','5 inch, single size, foam, orthopaedic','FUR-008','Sleepwell',@fur,6999,9999,4499,40,8,0,1,1,'mattress,single,ortho,sleepwell','["https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=500"]'),

-- GARDEN
('Ugaoo Indoor Plant Combo','Pothos, snake plant, money plant set of 3','GAR-001','Ugaoo',@gar,699,999,349,100,20,1,1,1,'plants,indoor,combo,ugaoo','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Tata Florigo Garden Soil','Premium potting mix, 5kg, all plants','GAR-002','Tata',@gar,299,399,149,200,40,0,1,1,'soil,potting mix,garden,plants','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Kraft Seeds Vegetable Kit','10 varieties, high germination, organic','GAR-003','Kraft Seeds',@gar,399,549,199,150,30,0,1,1,'seeds,vegetable,organic,garden','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Garden Guru Drip Irrigation Kit','16 plants, timer, adjustable drippers','GAR-004','Garden Guru',@gar,1299,1799,699,60,12,0,1,1,'drip irrigation,garden,watering,kit','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Nisarg Neem Khali Fertilizer','Organic, 1kg, pest repellent, all crops','GAR-005','Nisarg',@gar,199,249,89,300,60,0,1,1,'fertilizer,neem,organic,garden','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Fiskars Garden Trowel Set','3 piece, stainless steel, ergonomic grip','GAR-006','Fiskars',@gar,999,1299,549,80,15,0,1,1,'trowel,garden tools,fiskars,steel','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Cera Plast Watering Can 10L','Heavy duty, long spout, rose sprinkler','GAR-007','Cera Plast',@gar,349,449,179,150,30,0,1,1,'watering can,garden,sprinkler,plants','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),
('Ugaoo Ceramic Pot Set','Set of 3, white, decorative, drainage hole','GAR-008','Ugaoo',@gar,799,999,399,100,20,0,1,1,'pot,ceramic,planters,ugaoo','["https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?w=500"]'),

-- JEWELLERY
('Tanishq Gold Pendant 22KT','Floral design, BIS hallmark, 1.5g','JEW-001','Tanishq',@jew,8999,9999,6999,20,4,1,1,1,'tanishq,gold,pendant,hallmark','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Mia Diamond Earrings 18KT','Solitaire stud, IGI certified, 0.15ct','JEW-002','Mia',@jew,12999,14999,9999,15,3,1,1,1,'diamond,earrings,mia,18kt','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Voylla Silver Bracelet','92.5 sterling silver, oxidised, bohemian','JEW-003','Voylla',@jew,799,999,399,100,20,0,1,1,'silver,bracelet,voylla,925','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Sukkhi Kundan Necklace Set','Bridal, gold plated, earrings included','JEW-004','Sukkhi',@jew,1299,1799,699,60,12,0,1,1,'kundan,necklace,bridal,sukkhi','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('CaratLane Platinum Ring','Couple band, 950 platinum, comfort fit','JEW-005','CaratLane',@jew,24999,27999,18999,10,2,0,1,1,'platinum,ring,couple,caratlane','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Pipa Bella Fashion Earrings','Drop earrings, statement, party wear','JEW-006','Pipa Bella',@jew,599,799,299,150,30,0,1,1,'earrings,fashion,party,statement','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Senco Gold Bangle 22KT','Traditional design, BIS hallmark, pair','JEW-007','Senco',@jew,18999,20999,14999,12,2,0,1,1,'gold,bangle,senco,traditional','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),
('Zaveri Pearls Mangalsutra','Gold plated, black beads, traditional','JEW-008','Zaveri Pearls',@jew,899,1199,449,80,15,0,1,1,'mangalsutra,gold,pearls,traditional','["https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=500"]'),

-- PERSONAL CARE
('Oral-B Electric Toothbrush','Pro 500, 2 modes, pressure sensor','PRC-001','Oral-B',@prc,1999,2499,1199,100,20,1,1,1,'oral-b,electric toothbrush,dental,care','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Gillette Mach3 Razor','3 blade, lubricating strip, 2 cartridges','PRC-002','Gillette',@prc,299,399,149,300,60,0,1,1,'gillette,razor,shaving,mach3','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Dettol Hand Sanitizer 500ml','70% alcohol, kills 99.9% germs','PRC-003','Dettol',@prc,199,249,89,500,100,0,1,1,'dettol,sanitizer,hand wash,hygiene','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Colgate MaxFresh Toothpaste 300g','Triple pack, cooling crystals, fresh breath','PRC-004','Colgate',@prc,199,249,89,600,120,0,1,1,'colgate,toothpaste,oral care,fresh','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Himalaya Purifying Neem Face Wash','150ml, tulsi, deep cleanse, oil control','PRC-005','Himalaya',@prc,149,179,69,500,100,0,1,1,'himalaya,face wash,neem,skincare','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Park Avenue Deodorant Combo','2x150ml, Cool Blue & Storm, 48hr','PRC-006','Park Avenue',@prc,299,399,149,400,80,0,1,1,'deodorant,park avenue,combo,men','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Veet Hair Removal Cream 200g','Sensitive skin, 3 min, aloe vera','PRC-007','Veet',@prc,199,249,89,400,80,0,1,1,'veet,hair removal,cream,sensitive','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),
('Engage Perfume 120ml','Floral, long lasting, for women','PRC-008','Engage',@prc,399,499,199,200,40,0,1,1,'engage,perfume,fragrance,women','["https://images.pexels.com/photos/3762879/pexels-photo-3762879.jpeg?w=500"]'),

-- STATIONERY
('Camlin Kokuyo Notebook A4','Single line, 180 pages, hard cover','STA-001','Camlin',@sta,199,249,89,500,100,0,1,1,'camlin,notebook,a4,ruled','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Faber-Castell Colour Pencils 48','Premium quality, vibrant, shatterproof','STA-002','Faber-Castell',@sta,499,649,249,200,40,1,1,1,'faber castell,colour pencils,art,kids','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Pilot G2 Gel Pen 10 Pack','0.5mm, smooth writing, black, refillable','STA-003','Pilot',@sta,399,499,199,300,60,0,1,1,'pilot,gel pen,black,smooth','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Apsara Platinum Pencil 20 Pack','HB grade, smooth writing, break resistant','STA-004','Apsara',@sta,99,149,49,1000,200,0,1,1,'apsara,pencil,hb,students','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('3M Post-it Notes 5 Pack','76x76mm, 100 sheets each, assorted colors','STA-005','3M',@sta,349,449,179,300,60,0,1,1,'3m,post it,sticky notes,office','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Maped Geometry Box','8 piece, metal compass, student set','STA-006','Maped',@sta,199,249,89,400,80,0,1,1,'maped,geometry box,compass,students','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Cello Gripper Ball Pen 25 Pack','0.7mm, smooth flow, blue, office use','STA-007','Cello',@sta,149,199,69,500,100,0,1,1,'cello,ball pen,blue,office','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]'),
('Staedtler Mechanical Pencil','0.5mm, twist erase, metal grip, drafting','STA-008','Staedtler',@sta,399,499,199,200,40,0,1,1,'staedtler,mechanical pencil,drafting,art','["https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500"]');

SELECT CONCAT('Total products: ', COUNT(*)) FROM Products WHERE IsActive=1;
"""

result = subprocess.run(
    ["docker", "exec", "-i", "deemona-mysql", "mysql", "-u", "root", "-pDeemonaLocal123", "deemona"],
    input=sql, capture_output=True, text=True
)
print("Status:", "OK" if result.returncode==0 else result.stderr[:200])
if result.stdout:
    print(result.stdout)
