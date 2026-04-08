// scripts/generateSeedSQL.js
// Generates seed_products.sql with 1000 products across 8 categories
// Run: node scripts/generateSeedSQL.js
// Then: sqlcmd -S localhost -d DeemonaDB -i seed_products.sql
'use strict';
const fs   = require('fs');
const path = require('path');

// ─── Helpers ──────────────────────────────────────────────
const rnd     = (a, b)    => Math.floor(Math.random() * (b - a + 1)) + a;
const pick    = arr        => arr[Math.floor(Math.random() * arr.length)];
const mrpFrom = price      => Math.round((price * (1 + rnd(10, 60) / 100)) / 10) * 10;
const cost    = price      => Math.round(price * (0.45 + Math.random() * 0.25));
const stock   = ()         => rnd(5, 300);
const reorder = ()         => rnd(10, 40);
const weight  = (min, max) => (min + Math.random() * (max - min)).toFixed(2);
const sq      = s          => s.replace(/'/g, "''");

// ─── Categories (will be inserted first) ──────────────────
const CATEGORIES = [
  { id: 1,  name: 'Electronics',       parent: null },
  { id: 2,  name: 'Clothing',          parent: null },
  { id: 3,  name: 'Books',             parent: null },
  { id: 4,  name: 'Home Decor',        parent: null },
  { id: 5,  name: 'Home Appliances',   parent: null },
  { id: 6,  name: 'Gym Accessories',   parent: null },
  { id: 7,  name: 'Sports',            parent: null },
  { id: 8,  name: 'Medicines',         parent: null },
];

// ─── Suppliers ─────────────────────────────────────────────
const SUPPLIERS = [
  { id: 1, name: 'TechVision Pvt Ltd',      email: 'supply@techvision.in',    city: 'Bengaluru' },
  { id: 2, name: 'FabricWorld India',       email: 'orders@fabricworld.in',   city: 'Surat'     },
  { id: 3, name: 'PageTurner Distributors', email: 'bulk@pageturner.in',      city: 'Mumbai'    },
  { id: 4, name: 'HomeStyle Suppliers',     email: 'supply@homestyle.in',     city: 'Delhi'     },
  { id: 5, name: 'FitGear Wholesale',       email: 'orders@fitgear.in',       city: 'Pune'      },
  { id: 6, name: 'MedSource India',         email: 'procurement@medsource.in',city: 'Hyderabad' },
  { id: 7, name: 'SportZone Wholesale',     email: 'bulk@sportzone.in',       city: 'Chennai'   },
  { id: 8, name: 'AplianceHub Pvt Ltd',     email: 'supply@appliancehub.in',  city: 'Noida'     },
];

// ═══════════════════════════════════════════════════════════
//  PRODUCT DEFINITIONS PER CATEGORY
//  Each entry: { name, brand, price, tags, desc, wt, suppID }
//  Target count shown per category (totals ~1000)
// ═══════════════════════════════════════════════════════════

// ── 1. Electronics (~180) ─────────────────────────────────
const ELECTRONICS_BRANDS = ['Sony','Samsung','Apple','OnePlus','Xiaomi','Boat','JBL','Realme',
  'LG','Philips','Logitech','Belkin','Anker','Lenovo','HP','Dell','Asus','Acer','Bose','Noise'];

const ELECTRONICS = [
  // Smartphones
  ...['Pro Max','Ultra 5G','5G Plus','Lite 5G','Neo 5G','X Pro'].map((v,i) => ({
    name: `${pick(['OnePlus','Xiaomi','Realme','Samsung','Vivo'])} ${v}`,
    brand: pick(['OnePlus','Xiaomi','Realme','Samsung']),
    price: rnd(8999,44999), tags:'smartphone,5g,mobile', desc:'5G smartphone with high-refresh AMOLED display, fast charging and pro-grade camera system.',
    wt:'0.22', suppID:1, catID:1
  })),
  // Wireless Earbuds
  ...['AirPods Pro','Galaxy Buds','Airdopes 181','XSound Go','Boat Airdopes 441'].concat(
    ['QuietComfort','Jabra Evolve','WF-1000XM5','FreeBuds Pro','Momentum True'].map(v=>v)
  ).map((v,i) => ({
    name:`${v} Wireless Earbuds`, brand: pick(ELECTRONICS_BRANDS),
    price:rnd(999,15999), tags:'earbuds,wireless,bluetooth,audio', desc:'True wireless earbuds with active noise cancellation and 30-hour total playtime.',
    wt:'0.06', suppID:1, catID:1
  })),
  // Smartwatches
  ...['Band Pro','Watch GT 3','Smart SE','FitPro Ultra','Active 5'].map((v,i)=>({
    name:`${pick(['Noise','Fire-Boltt','boAt','Amazfit','Samsung'])} ${v} Smartwatch`,
    brand:pick(['Noise','Fire-Boltt','Amazfit','boAt']),
    price:rnd(1499,24999), tags:'smartwatch,fitness,wearable', desc:'Smartwatch with health monitoring, sleep tracking, SpO2, and 7-day battery life.',
    wt:'0.08', suppID:1, catID:1
  })),
  // Laptops
  ...['IdeaPad 3','VivoBook 15','Aspire 5','Pavilion 15','Inspiron 15',
    'MacBook Air M2','ThinkPad E14','Gram 16','ZenBook 14','Surface Laptop'].map((v,i)=>({
    name:`${v} Laptop`, brand:pick(['Lenovo','Asus','Acer','HP','Dell','Apple','LG','Microsoft']),
    price:rnd(32999,139999), tags:'laptop,computer,notebook,work', desc:'Thin and light laptop with latest gen processor, 8GB RAM, 512GB SSD and all-day battery.',
    wt:'1.60', suppID:1, catID:1
  })),
  // Bluetooth Speakers
  ...['Charge 5','Extreme 3','Flip 6','Soundlink Mini','Go 3','Tribit MaxSound','Mivi Roam 2'].map(v=>({
    name:`${v} Bluetooth Speaker`, brand:pick(['JBL','Bose','Sony','Anker','Mivi']),
    price:rnd(799,14999), tags:'speaker,bluetooth,portable,audio', desc:'360° portable Bluetooth speaker with 20-hour playtime and waterproof design.',
    wt:'0.50', suppID:1, catID:1
  })),
  // Cameras
  ...['EOS M50','Alpha 6400','Z30 Mirrorless','OM-5','Fujifilm X-T30','GoPro Hero 12'].map(v=>({
    name:`${v} Camera`, brand:pick(['Canon','Sony','Nikon','Olympus','Fujifilm','GoPro']),
    price:rnd(24999,89999), tags:'camera,photography,mirrorless', desc:'Compact mirrorless camera with 4K video, in-body stabilization and fast autofocus.',
    wt:'0.40', suppID:1, catID:1
  })),
  // Tablets
  ...['Tab S8','iPad 10th Gen','Tab P12','MatePad Pro','Fire HD 10'].map(v=>({
    name:`${v} Tablet`, brand:pick(['Samsung','Apple','Lenovo','Huawei','Amazon']),
    price:rnd(12999,79999), tags:'tablet,android,ipad', desc:'10.9-inch tablet with 2K display, S-Pen support and all-day battery for work and entertainment.',
    wt:'0.55', suppID:1, catID:1
  })),
  // Gaming
  ...['DualSense Controller','Xbox Controller','Mechanical Keyboard RGB','Gaming Mouse Pro',
    'Gaming Headset 7.1','27-inch 144Hz Monitor','Capture Card 4K','Gaming Chair RGB'].map(v=>({
    name:v, brand:pick(['Sony','Microsoft','Logitech','Razer','HyperX','BenQ']),
    price:rnd(1499,39999), tags:'gaming,peripheral,esports', desc:'High-performance gaming peripheral engineered for competitive play.',
    wt:'0.80', suppID:1, catID:1
  })),
  // Accessories
  ...['65W GaN Charger','20000mAh Power Bank','USB-C Hub 7-in-1','Wireless Charging Pad',
    'Phone Stand Adjustable','Laptop Sleeve 15"','Smart Plug Wi-Fi','LED Desk Lamp Smart'].map(v=>({
    name:v, brand:pick(['Anker','Belkin','Xiaomi','Lenovo','Philips']),
    price:rnd(399,3999), tags:'accessory,charger,gadget', desc:'Essential everyday tech accessory built to last.',
    wt:'0.30', suppID:1, catID:1
  })),
  // Networking
  ...['Wi-Fi 6 Router','Mesh System 3-Pack','4G LTE Router','Gigabit Switch 8-Port',
    'Powerline Adapter Kit','Wi-Fi Range Extender'].map(v=>({
    name:v, brand:pick(['TP-Link','Netgear','D-Link','Tenda','Asus']),
    price:rnd(1299,12999), tags:'networking,router,wifi,internet', desc:'High-speed networking device for home and office with easy setup.',
    wt:'0.40', suppID:1, catID:1
  })),
  // Monitors & Displays
  ...['24" FHD IPS Monitor','27" QHD Monitor','32" 4K Display','Portable 15.6" Monitor'].map(v=>({
    name:v, brand:pick(['LG','Dell','BenQ','Asus','Acer']),
    price:rnd(8999,49999), tags:'monitor,display,screen', desc:'Eye-care certified monitor with wide colour gamut and ultra-thin bezels.',
    wt:'3.50', suppID:1, catID:1
  })),
  // Smart Home
  ...['Smart LED Bulb Colour','Smart Door Lock','Video Doorbell Wi-Fi','Security Camera Indoor',
    'Smart Thermostat','Voice-Controlled Smart Strip'].map(v=>({
    name:v, brand:pick(['Philips','Yale','Eufy','TP-Link','Honeywell','Wipro']),
    price:rnd(899,8999), tags:'smarthome,iot,alexa', desc:'Voice assistant compatible smart home device for effortless automation.',
    wt:'0.35', suppID:1, catID:1
  })),
  // Headphones
  ...['WH-1000XM5','QuietComfort 45','Momentum 4','Fidelio X3','Jabra Evolve2 85'].map(v=>({
    name:`${v} Over-Ear Headphones`, brand:pick(['Sony','Bose','Sennheiser','Philips','Jabra']),
    price:rnd(2999,29999), tags:'headphones,anc,audio,hi-fi', desc:'Premium over-ear headphones with best-in-class noise cancellation.',
    wt:'0.25', suppID:1, catID:1
  })),
];

// ── 2. Clothing (~160) ────────────────────────────────────
const CLOTH_BRANDS = ['Zara','H&M','Levi\'s','Nike','Adidas','Puma','Mango','Van Heusen',
  'Allen Solly','Arrow','US Polo','Woodland','Jack & Jones','Roadster','HRX'];
const SIZES   = ['XS','S','M','L','XL','XXL'];
const COLOURS = ['Black','White','Navy Blue','Olive Green','Charcoal Grey','Burgundy',
  'Sky Blue','Coral','Mustard Yellow','Forest Green','Off-White','Royal Blue'];

const CLOTHING = [
  ...['Slim Fit Chinos','Regular Fit Jeans','Cargo Pants','Track Pants','Joggers'].flatMap(item =>
    COLOURS.slice(0,4).map(col => ({
      name:`${col} ${item}`, brand:pick(CLOTH_BRANDS),
      price:rnd(599,3499), tags:'bottom,trousers,casual', desc:`${col} ${item} in premium stretch fabric. Available in ${SIZES.join(', ')}.`,
      wt:'0.45', suppID:2, catID:2
    }))),
  ...['Graphic Tee','Polo T-Shirt','V-Neck T-Shirt','Oversized T-Shirt','Striped T-Shirt'].flatMap(item =>
    COLOURS.slice(0,5).map(col => ({
      name:`${col} ${item}`, brand:pick(CLOTH_BRANDS),
      price:rnd(299,1499), tags:'tshirt,top,casual,cotton', desc:`Pure cotton ${col} ${item} — breathable, soft and easy-care.`,
      wt:'0.20', suppID:2, catID:2
    }))),
  ...['Oxford Button-Down Shirt','Casual Linen Shirt','Formal Dress Shirt','Flannel Check Shirt'].flatMap(item =>
    COLOURS.slice(0,4).map(col => ({
      name:`${col} ${item}`, brand:pick(CLOTH_BRANDS),
      price:rnd(699,2999), tags:'shirt,formal,casual,top', desc:`${col} ${item} in wrinkle-resistant fabric. Machine washable.`,
      wt:'0.28', suppID:2, catID:2
    }))),
  ...['Quilted Jacket','Windbreaker','Hoodie Sweatshirt','Zip-Up Fleece','Puffer Vest',
    'Bomber Jacket','Denim Jacket'].flatMap(item =>
    COLOURS.slice(0,3).map(col => ({
      name:`${col} ${item}`, brand:pick(CLOTH_BRANDS),
      price:rnd(999,5999), tags:'jacket,outerwear,winter', desc:`${col} ${item} — water-resistant and windproof for all-season wear.`,
      wt:'0.65', suppID:2, catID:2
    }))),
  ...['Floral Maxi Dress','Wrap Midi Dress','Bodycon Mini Dress','A-Line Skirt',
    'High-Waist Palazzo','Straight Kurti','Anarkali Kurti'].flatMap(item =>
    COLOURS.slice(0,4).map(col => ({
      name:`${col} ${item}`, brand:pick(['Biba','W for Woman','Zara','Mango','AND']),
      price:rnd(499,3999), tags:'women,dress,ethnic,western', desc:`Elegant ${col} ${item} in breathable fabric. Perfect for all occasions.`,
      wt:'0.35', suppID:2, catID:2
    }))),
  ...['Athletic Running Shoes','Canvas Sneakers','Leather Loafers','Ankle Chelsea Boots',
    'Slip-On Espadrilles','Formal Derby Shoes'].map(v => ({
    name:`${pick(COLOURS.slice(0,4))} ${v}`, brand:pick(['Nike','Adidas','Woodland','Clarks','Bata','Puma']),
    price:rnd(799,6999), tags:'shoes,footwear,casual', desc:`Comfortable and stylish ${v} for everyday wear.`,
    wt:'0.80', suppID:2, catID:2
  })),
];

// ── 3. Books (~100) ──────────────────────────────────────
const PUBLISHERS = ['Penguin Random House','HarperCollins','Bloomsbury','Rupa Publications',
  'Oxford University Press','Pearson','McGraw Hill','Westland Books','Juggernaut'];

const BOOKS = [
  // Fiction bestsellers
  ...[
    {t:'The Midnight Library',a:'Matt Haig'},{t:'Atomic Habits',a:'James Clear'},
    {t:'The Alchemist',a:'Paulo Coelho'},{t:'Ikigai',a:'Héctor García'},
    {t:'The Psychology of Money',a:'Morgan Housel'},{t:'Sapiens',a:'Yuval Noah Harari'},
    {t:'Rich Dad Poor Dad',a:'Robert Kiyosaki'},{t:'The Power of Now',a:'Eckhart Tolle'},
    {t:'Think and Grow Rich',a:'Napoleon Hill'},{t:'Deep Work',a:'Cal Newport'},
    {t:'The Subtle Art of Not Giving a F*ck',a:'Mark Manson'},{t:'Man\'s Search for Meaning',a:'Viktor Frankl'},
    {t:'Educated',a:'Tara Westover'},{t:'Becoming',a:'Michelle Obama'},
    {t:'The Book Thief',a:'Markus Zusak'},{t:'A Little Life',a:'Hanya Yanagihara'},
    {t:'Normal People',a:'Sally Rooney'},{t:'The Kite Runner',a:'Khaled Hosseini'},
    {t:'Where the Crawdads Sing',a:'Delia Owens'},{t:'It Ends with Us',a:'Colleen Hoover'},
    {t:'Dune',a:'Frank Herbert'},{t:'Project Hail Mary',a:'Andy Weir'},
    {t:'The Martian',a:'Andy Weir'},{t:'Ready Player One',a:'Ernest Cline'},
    {t:'Hitchhiker\'s Guide to the Galaxy',a:'Douglas Adams'},
  ].map(b => ({
    name:`${b.t} — Paperback`, brand:pick(PUBLISHERS),
    price:rnd(199,699), tags:'fiction,bestseller,novel', desc:`Internationally bestselling book by ${b.a}. This edition features a new introduction by the author.`,
    wt:'0.35', suppID:3, catID:3
  })),
  // Self-help & business (hardcover)
  ...[
    'Zero to One','The Lean Startup','Start with Why','Good to Great',
    'Thinking, Fast and Slow','Outliers','The 4-Hour Work Week','Principles',
    'Never Split the Difference','Can\'t Hurt Me','The 48 Laws of Power',
    'Essentialism','Digital Minimalism','Flow','Grit'
  ].map(t => ({
    name:`${t} — Hardcover`, brand:pick(PUBLISHERS),
    price:rnd(499,1299), tags:'self-help,business,nonfiction,hardcover', desc:'A definitive guide for personal and professional growth. Includes index and notes.',
    wt:'0.50', suppID:3, catID:3
  })),
  // Tech books
  ...[
    'Clean Code','Design Patterns','The Pragmatic Programmer','Structure and Interpretation',
    'Introduction to Algorithms','JavaScript: The Good Parts','You Don\'t Know JS',
    'Python Crash Course','Database Design for Mere Mortals',
    'System Design Interview','Cracking the Coding Interview','The DevOps Handbook'
  ].map(t => ({
    name:`${t} — Technical Edition`, brand:'O\'Reilly / Pearson',
    price:rnd(599,2499), tags:'programming,technology,reference,textbook', desc:'Industry-standard technical reference. Includes code examples and exercises.',
    wt:'0.70', suppID:3, catID:3
  })),
  // Children & education
  ...[
    'NCERT Mathematics Class 10','NCERT Physics Class 12','NCERT Chemistry Class 11',
    'R.D. Sharma Mathematics','S.L. Arora Physics','Arihant Practice Sets JEE',
    'Objective NCERT at Your Fingertips','MTG Complete NEET Guide',
    'Wren and Martin Grammar','Oxford Dictionary New Edition',
    'Geronimo Stilton Collection Box','Wimpy Kid Diary Set','Harry Potter Box Set'
  ].map(t => ({
    name:t, brand:pick(PUBLISHERS),
    price:rnd(149,1999), tags:'education,textbook,children,academic', desc:'Curriculum-aligned edition with solved examples, practice questions and answer key.',
    wt:'0.60', suppID:3, catID:3
  })),
  // Magazines & journals
  ...[
    'Moleskine Classic Notebook A5','Leuchtturm1917 Bullet Journal','Paperblanks Flexi Journal',
    'Rhodia Webnotebook','Life Planner 2025'
  ].map(t => ({
    name:t, brand:pick(['Moleskine','Leuchtturm','Rhodia']),
    price:rnd(499,1799), tags:'notebook,journal,stationery', desc:'Premium quality paper journal for notes, journaling and sketching.',
    wt:'0.30', suppID:3, catID:3
  })),
];

// ── 4. Home Decor (~100) ─────────────────────────────────
const DECOR_BRANDS = ['IKEA','Pepperfry','Urban Ladder','Nilkamal','Home Centre','HomeTown','The Label Life'];

const HOME_DECOR = [
  ...['Ceramic Table Vase','Glass Flower Vase','Rattan Woven Vase','Terracotta Vase Set'].flatMap(v =>
    ['White','Teal','Beige','Blush Pink','Rust Brown'].map(col => ({
      name:`${col} ${v}`, brand:pick(DECOR_BRANDS),
      price:rnd(299,2499), tags:'vase,decor,living-room', desc:`Handcrafted ${col} ${v} — adds a touch of elegance to any space.`,
      wt:'0.80', suppID:4, catID:4
    }))),
  ...['Scented Soy Candle Set','Reed Diffuser Set','Aromatherapy Candle Jar',
    'Beeswax Pillar Candle','Flameless LED Candle Set'].map(v => ({
    name:`${pick(['Lavender','Vanilla','Sandalwood','Rose','Eucalyptus'])} ${v}`,
    brand:pick(['Iris','Aroma Magic','Candlescapes','Yankee Candle']),
    price:rnd(299,1999), tags:'candle,aroma,wellness,gifting', desc:'Long-burn aromatherapy candle made with natural wax and essential oils.',
    wt:'0.40', suppID:4, catID:4
  })),
  ...['Geometric Wall Clock','Wooden Antique Clock','Minimalist Wall Clock','Digital LED Clock',
    'Marble Effect Wall Clock'].map(v => ({
    name:v, brand:pick(DECOR_BRANDS),
    price:rnd(599,4999), tags:'clock,wall-decor,living-room', desc:'Silent sweep quartz movement clock. No ticking. Perfect for bedrooms and offices.',
    wt:'1.20', suppID:4, catID:4
  })),
  ...['Bohemian Wall Tapestry','Macramé Wall Hanging','Canvas Abstract Art Print',
    'Wooden Wall Shelf Floating','Hexagonal Mirror Set',
    'Gallery Wall Frame Set','Motivational Poster Set A3'].map(v => ({
    name:v, brand:pick(DECOR_BRANDS),
    price:rnd(399,3999), tags:'wall-decor,art,living-room,bedroom', desc:'Statement wall décor piece — transforms any blank wall instantly.',
    wt:'0.60', suppID:4, catID:4
  })),
  ...['Monstera Artificial Plant','Succulent Arrangement Pot','Bamboo Desktop Plant',
    'Air Plant Tillandsia Set','Ceramic Planter with Stand'].map(v => ({
    name:v, brand:pick(['Ugaoo','Nurserylive','Kraft Seeds']),
    price:rnd(299,2999), tags:'plants,indoor,decor,greenery', desc:'Low-maintenance decorative plant — brings life and freshness to your home.',
    wt:'0.50', suppID:4, catID:4
  })),
  ...['Cotton Throw Blanket','Knitted Chunky Throw','Sherpa Fleece Throw',
    'Linen Cushion Cover Set 5','Velvet Cushion Cover Pack',
    'Bohemian Rug 5x7 ft','Jute Braided Rug','Shaggy Bedroom Rug',
    'Bamboo Tray Decorative','Wicker Basket Set 3'].map(v => ({
    name:v, brand:pick(DECOR_BRANDS),
    price:rnd(499,5999), tags:'soft-furnishing,living-room,bedroom,textile', desc:'Premium quality home textile — adds warmth, texture and personality to your space.',
    wt:'1.00', suppID:4, catID:4
  })),
  ...['Photo Frame Collage 6-in-1','Bamboo Photo Frame A4',
    'Acrylic Floating Frame','Instax Mini Frame Set'].map(v => ({
    name:v, brand:pick(['Ikea','Furlenco','Nilkamal']),
    price:rnd(299,1499), tags:'photo-frame,decor,gifting', desc:'Display your favourite memories beautifully. Easy hanging hardware included.',
    wt:'0.40', suppID:4, catID:4
  })),
];

// ── 5. Home Appliances (~120) ─────────────────────────────
const APPL_BRANDS = ['LG','Samsung','Bosch','Philips','Panasonic','Bajaj','Havells',
  'Usha','Crompton','Whirlpool','IFB','Prestige','Inalsa','Morphy Richards'];

const HOME_APPLIANCES = [
  ...['Mixer Grinder 750W','Mixer Grinder 1000W','Wet Grinder 2L'].flatMap(v =>
    [2,3,4].map(j => ({
      name:`${v} ${j}J`, brand:pick(['Bajaj','Prestige','Inalsa','Philips']),
      price:rnd(1799,5999), tags:'kitchen,mixer,grinder', desc:`${j}-jar mixer grinder with ${v} motor. SS blades, 5-year warranty.`,
      wt:'4.50', suppID:8, catID:5
    }))),
  ...['Air Fryer 4L','Air Fryer 5.5L','Dual Basket Air Fryer 8L'].map(v => ({
    name:v, brand:pick(['Philips','Inalsa','Cosori','Havells','Instant Vortex']),
    price:rnd(2999,9999), tags:'air-fryer,kitchen,healthy-cooking', desc:'Rapid air technology — fry with up to 95% less oil. 8 preset programs.',
    wt:'3.50', suppID:8, catID:5
  })),
  ...['Induction Cooktop 2000W','Electric Cooktop Dual Burner',
    'OTG 25L','OTG 40L','Microwave Solo 20L','Microwave Convection 28L',
    'Sandwich Maker Grill','Waffle Maker','Electric Kettle 1.7L',
    'French Press Coffee Maker','Drip Coffee Machine','Espresso Machine Semi-Auto'].map(v => ({
    name:v, brand:pick(APPL_BRANDS),
    price:rnd(799,14999), tags:'kitchen,cooking,countertop', desc:'Energy-efficient kitchen appliance with auto-shutoff safety feature.',
    wt:'2.00', suppID:8, catID:5
  })),
  ...['Ceiling Fan 1200mm','Pedestal Fan 400mm','Tower Fan 55"',
    'Wall Fan 300mm','Exhaust Fan 6 Inch'].map(v => ({
    name:`${v} ${pick(['White','Brown','Ivory','Midnight Black'])}`, brand:pick(['Usha','Crompton','Havells','Orient','Bajaj']),
    price:rnd(999,6999), tags:'fan,cooling,home', desc:'Energy Star rated fan with 5-speed settings and remote control option.',
    wt:'3.50', suppID:8, catID:5
  })),
  ...['Room Heater 2000W','Oil-Filled Radiator 11-Fin',
    'Halogen Room Heater','Tower Room Heater PTC'].map(v => ({
    name:v, brand:pick(['Bajaj','Havells','Usha','Morphy Richards']),
    price:rnd(1299,7999), tags:'heater,winter,home', desc:'Overheating protection with tip-over safety switch. Silent operation.',
    wt:'2.80', suppID:8, catID:5
  })),
  ...['Water Purifier RO+UV 7L','Water Purifier RO+UV+UF 10L',
    'Gravity Water Purifier 15L'].map(v => ({
    name:v, brand:pick(['Kent','Aquaguard','Pureit','Havells']),
    price:rnd(4999,22999), tags:'water-purifier,kitchen,health', desc:'7-stage purification with mineral retention technology. 1-year free service.',
    wt:'6.00', suppID:8, catID:5
  })),
  ...['Front Load Washing Machine 7kg','Top Load Washing Machine 6.5kg',
    'Semi-Automatic 8kg','Fully Automatic 8kg'].map(v => ({
    name:v, brand:pick(['LG','Samsung','Whirlpool','IFB','Bosch']),
    price:rnd(12999,54999), tags:'washing-machine,laundry,home', desc:'IntelliWash technology with 15 wash programs and in-built heater.',
    wt:'65.0', suppID:8, catID:5
  })),
  ...['Vacuum Cleaner 2200W','Robot Vacuum Cleaner','Wet & Dry Vacuum 30L',
    'Handheld Cordless Vacuum'].map(v => ({
    name:v, brand:pick(['Dyson','Philips','Inalsa','Mi','Eureka Forbes']),
    price:rnd(2999,34999), tags:'vacuum,cleaning,home', desc:'Powerful suction with HEPA filtration — removes allergens and fine dust.',
    wt:'3.00', suppID:8, catID:5
  })),
  ...['Steam Iron 2400W','Dry Iron 1100W','Garment Steamer 1500W'].map(v => ({
    name:v, brand:pick(['Philips','Bajaj','Usha','Morphy Richards']),
    price:rnd(499,3499), tags:'iron,laundry,home', desc:'Non-stick soleplate with auto temperature control. 360° cord rotation.',
    wt:'1.10', suppID:8, catID:5
  })),
];

// ── 6. Gym Accessories (~110) ─────────────────────────────
const GYM_BRANDS = ['Decathlon','Boldfit','Adidas','Nike','RitFit','Kobo','Vector X','Cosco'];

const GYM = [
  ...['Adjustable Dumbbell Set 20kg','Hex Dumbbell Pair 5kg','Hex Dumbbell Pair 10kg',
    'Hex Dumbbell Pair 15kg','Neoprene Dumbbell Set 3kg','Cast Iron Dumbbell 7.5kg Pair'].map(v => ({
    name:v, brand:pick(GYM_BRANDS),
    price:rnd(799,8999), tags:'dumbbell,weights,strength', desc:'Hex-shaped anti-roll dumbbells with rubberized coating. Ergonomic grip.',
    wt:'10.0', suppID:5, catID:6
  })),
  ...['Barbell Rod 6ft Olympic','EZ Curl Bar','Tricep Bar','Weight Plates 5kg Pair',
    'Weight Plates 10kg Pair','Weight Plates 20kg Pair','Barbell Collar Clamp'].map(v => ({
    name:v, brand:pick(GYM_BRANDS),
    price:rnd(999,12999), tags:'barbell,weights,powerlifting', desc:'Olympic grade steel with knurled grip. Compatible with 2-inch weight plates.',
    wt:'7.00', suppID:5, catID:6
  })),
  ...['Resistance Band Set 5pcs','Pull-Up Assist Band','Loop Resistance Band 4pcs',
    'Figure 8 Resistance Band','Fabric Hip Band Set'].map(v => ({
    name:v, brand:pick(['Boldfit','Decathlon','RitFit','Fit Simplify']),
    price:rnd(299,1499), tags:'resistance-band,stretching,yoga,home-workout', desc:'Natural latex resistance bands with 5 resistance levels from light to extra-heavy.',
    wt:'0.50', suppID:5, catID:6
  })),
  ...['Yoga Mat 6mm NBR','Yoga Mat 4mm TPE','Non-Slip Yoga Mat 5mm','Foam Exercise Mat',
    'Interlocking Foam Floor Tiles 6pcs'].map(v => ({
    name:v, brand:pick(['Boldfit','Kobo','Strauss','Decathlon']),
    price:rnd(499,2999), tags:'yoga-mat,yoga,pilates,exercise', desc:'High-density foam mat with alignment lines and carry strap. Anti-slip surface.',
    wt:'1.20', suppID:5, catID:6
  })),
  ...['Whey Protein 1kg Chocolate','Whey Protein 2kg Vanilla','Mass Gainer 3kg',
    'BCAA 250g Watermelon','Creatine Monohydrate 300g','Pre-Workout 300g',
    'Multivitamin for Men 60 tabs','Omega-3 Capsules 90pcs'].map(v => ({
    name:v, brand:pick(['MuscleBlaze','Optimum Nutrition','MyProtein','HealthKart','Dymatize']),
    price:rnd(699,4999), tags:'supplements,protein,nutrition,fitness', desc:'Lab-tested sports nutrition supplement. Informed Sport certified.',
    wt:'1.00', suppID:5, catID:6
  })),
  ...['Ab Roller Wheel','Pull-Up Bar Doorway','Push-Up Handles Rotating',
    'Foam Roller 60cm','Massage Ball Lacrosse','Jump Rope Speed Cable',
    'Gym Gloves Padded','Wrist Wraps Support','Knee Sleeves Pair',
    'Weightlifting Belt Leather','Ankle Weights 5kg Pair'].map(v => ({
    name:v, brand:pick(GYM_BRANDS),
    price:rnd(199,2499), tags:'gym-accessory,fitness,workout', desc:'Ergonomically designed fitness accessory for targeted muscle training and recovery.',
    wt:'0.60', suppID:5, catID:6
  })),
  ...['Adjustable Weight Bench','Folding Treadmill 3HP','Stationary Bike Magnetic',
    'Rowing Machine Air','Pull-Up Station Multi-Grip','Power Rack Half Rack'].map(v => ({
    name:v, brand:pick(['Decathlon','Kobo','Lifeline','PowerFit','Body Solid']),
    price:rnd(4999,49999), tags:'gym-equipment,cardio,strength,home-gym', desc:'Commercial-grade home gym equipment with 2-year structural warranty.',
    wt:'25.0', suppID:5, catID:6
  })),
];

// ── 7. Sports (~110) ──────────────────────────────────────
const SPORT_BRANDS = ['Nivia','SG','SS','Cosco','Yonex','Victor','Decathlon','Adidas','Nike','Puma'];

const SPORTS = [
  // Cricket
  ...['Kashmir Willow Cricket Bat','English Willow Cricket Bat Grade 1',
    'Tennis Ball Cricket Bat Tape','Cricket Bat Cover Full Length'].map(v => ({
    name:v, brand:pick(['SG','SS','Kookaburra','Gunn & Moore']),
    price:rnd(599,7999), tags:'cricket,bat,outdoor', desc:'Premium willow bat with full toe guard and anti-scuff sheet. MRF stickered.',
    wt:'1.20', suppID:7, catID:7
  })),
  ...['SG Cricket Ball Red Leather','Kookaburra Pink Ball','Cricket Helmet Senior',
    'Cricket Batting Gloves','Cricket Batting Pads','Cricket Wicket Keeping Gloves',
    'Cricket Thigh Guard','Cricket Chest Guard','Cricket Kitbag Wheelie'].map(v => ({
    name:v, brand:pick(['SG','SS','Kookaburra']),
    price:rnd(299,5999), tags:'cricket,gear,protective', desc:'International standard cricket equipment meeting all safety requirements.',
    wt:'0.80', suppID:7, catID:7
  })),
  // Football & Futsal
  ...['FIFA Quality Pro Football','Futsal Ball Size 4','Goalkeeper Gloves',
    'Football Shin Guards','Football Ankle Socks 3-Pack'].map(v => ({
    name:v, brand:pick(['Adidas','Nike','Nivia','Cosco','Puma']),
    price:rnd(399,3999), tags:'football,soccer,outdoor', desc:'Machine-stitched PU football with butyl bladder. FIFA approved.',
    wt:'0.45', suppID:7, catID:7
  })),
  // Badminton
  ...['Badminton Racket Graphite','Shuttlecock Feather 6pcs','Shuttlecock Nylon 6pcs',
    'Badminton Bag Backpack','Badminton Net Standard','Grip Tape 3pcs'].map(v => ({
    name:v, brand:pick(['Yonex','Victor','Apacs','Li-Ning','Decathlon']),
    price:rnd(299,7999), tags:'badminton,racket,sport', desc:'Carbon fibre shaft with T-joint reinforcement. Ideal for intermediate players.',
    wt:'0.25', suppID:7, catID:7
  })),
  // Tennis & Table Tennis
  ...['Tennis Racket Beginner','Tennis Balls 3 Tin','Table Tennis Bat Set',
    'Table Tennis Balls 40mm 6pcs','Ping Pong Net & Post'].map(v => ({
    name:v, brand:pick(['Wilson','Head','Stiga','Butterfly','Decathlon']),
    price:rnd(399,6999), tags:'tennis,table-tennis,racket', desc:'ITTF approved equipment for recreational and competitive play.',
    wt:'0.30', suppID:7, catID:7
  })),
  // Basketball & Volleyball
  ...['Basketball Size 7 Indoor','Basketball Size 5','Volleyball Mikasa',
    'Basketball Hoop Portable','Volleyball Net Standard'].map(v => ({
    name:v, brand:pick(['Spalding','Cosco','Nivia','Mikasa']),
    price:rnd(699,9999), tags:'basketball,volleyball,outdoor', desc:'Deep channel design for easy grip. Indoor/outdoor use.',
    wt:'0.65', suppID:7, catID:7
  })),
  // Cycling & Skating
  ...['Bicycle Helmet Adult','Knee Pads Skating Set','Inline Skates Adult',
    'Cycling Gloves Padded','Cycle Water Bottle Cage'].map(v => ({
    name:v, brand:pick(['Decathlon','Scott','Trek','Btwin']),
    price:rnd(399,3999), tags:'cycling,skating,outdoor,safety', desc:'CE certified protective gear for cycling and skating enthusiasts.',
    wt:'0.50', suppID:7, catID:7
  })),
  // Swimming
  ...['Swimming Goggles Anti-Fog','Silicone Swim Cap','Kickboard Swimming',
    'Pull Buoy Float','Swimming Fins Fins Pair'].map(v => ({
    name:v, brand:pick(['Speedo','Arena','Decathlon']),
    price:rnd(299,2499), tags:'swimming,pool,sport', desc:'FINA approved swimming accessory for training and recreational swimming.',
    wt:'0.20', suppID:7, catID:7
  })),
];

// ── 8. Medicines / Health (~120) ──────────────────────────
// NOTE: Descriptions are generic OTC items only — no prescription drugs
const MED_BRANDS = ['Himalaya','Dabur','Patanjali','Setu','HealthKart','MuscleBlaze','Cipla OTC','Dr. Morepen'];

const MEDICINES = [
  // Vitamins & supplements
  ...['Vitamin C 1000mg 60 Tablets','Vitamin D3 2000 IU 90 Capsules',
    'Vitamin B12 500mcg 60 Tabs','Biotin 10000mcg 60 Caps',
    'Zinc 50mg 90 Tablets','Magnesium 400mg 60 Caps',
    'Iron 45mg + Vitamin C 60 Tabs','Calcium + D3 60 Tablets',
    'Folic Acid 5mg 30 Tablets','Vitamin E 400 IU 30 Softgels',
    'CoQ10 100mg 30 Capsules','Fish Oil Omega-3 1000mg 90 Softgels',
    'Probiotics 50 Billion CFU 30 Caps','Ashwagandha KSM-66 500mg 60 Caps',
    'Turmeric Curcumin 500mg 60 Tabs','Moringa 500mg 60 Capsules'].map(v => ({
    name:v, brand:pick(MED_BRANDS),
    price:rnd(199,1499), tags:'vitamins,supplements,health,nutrition', desc:'Third-party tested dietary supplement. GMP certified manufacturing facility.',
    wt:'0.15', suppID:6, catID:8
  })),
  // OTC care products
  ...['Antiseptic Cream 20g','Antifungal Cream 15g','Moisturising Lotion 200ml',
    'Sunscreen SPF 50 100ml','Lip Balm SPF 30','Cold Relief Balm 50g',
    'Muscle Pain Relief Gel 100g','Herbal Cough Syrup 200ml',
    'Glucose D Orange 500g','ORS Electrolyte Sachets 20pcs',
    'Activated Charcoal Capsules 60pcs','Digestive Enzyme Tablets 60pcs'].map(v => ({
    name:v, brand:pick(['Cipla OTC','Himalaya','Boroline','Manforce','Volini','Patanjali']),
    price:rnd(49,799), tags:'otc,skincare,first-aid,health', desc:'Clinically tested over-the-counter product. Dermatologically tested formula.',
    wt:'0.12', suppID:6, catID:8
  })),
  // Medical devices (non-prescription)
  ...['Digital Thermometer','Contact Thermometer Infrared',
    'Blood Pressure Monitor Automatic','Pulse Oximeter Finger Clip',
    'Blood Glucose Monitor Kit','Peak Flow Meter','Nebulizer Machine Compressor',
    'TENS Machine Pain Relief','Heating Pad Electric','Ice Gel Pack Reusable',
    'Cervical Collar Soft','Lumbar Support Belt','Knee Cap Medium',
    'Ankle Brace Support','Wrist Splint Carpal'].map(v => ({
    name:v, brand:pick(['Dr. Morepen','Omron','AccuSure','Sahyog Wellness','Beurer']),
    price:rnd(299,4999), tags:'medical-device,health-monitor,first-aid', desc:'CE and FDA compliant health monitoring device. Includes carrying case and batteries.',
    wt:'0.35', suppID:6, catID:8
  })),
  // Ayurvedic & herbal
  ...['Chyawanprash 500g','Triphala Churna 500g','Aloe Vera Juice 1L',
    'Neem Capsules 60pcs','Giloy Juice 500ml','Amla Juice 500ml',
    'Shilajit Resin 30g','Brahmi Churna 100g','Shatavari Powder 200g',
    'Panchakarma Kit Basic','Neem Face Wash 150ml','Tulsi Green Tea 25 Bags'].map(v => ({
    name:v, brand:pick(['Patanjali','Dabur','Himalaya','Baidyanath','Zandu']),
    price:rnd(99,1299), tags:'ayurveda,herbal,natural,wellness', desc:'100% natural Ayurvedic formulation. No artificial colours or preservatives.',
    wt:'0.50', suppID:6, catID:8
  })),
  // Personal hygiene & first aid
  ...['First Aid Kit 85-piece','Elastic Adhesive Bandage Roll',
    'Crepe Bandage 10cm','Sterile Gloves Box 50','Face Mask N95 10pcs',
    'Alcohol Hand Sanitiser 500ml','Hydrogen Peroxide 3% 100ml',
    'Povidone Iodine Solution 100ml','Digital Baby Weighing Scale',
    'Pregnancy Test Kit 2pcs'].map(v => ({
    name:v, brand:pick(['Cipla OTC','Dr. Morepen','Himalaya','Lifebuoy']),
    price:rnd(49,999), tags:'first-aid,hygiene,personal-care,baby', desc:'Essential healthcare product for home use. Meets all regulatory quality standards.',
    wt:'0.25', suppID:6, catID:8
  })),
];

// ═══════════════════════════════════════════════════════════
//  COMBINE ALL PRODUCTS
// ═══════════════════════════════════════════════════════════
const ALL_PRODUCTS = [
  ...ELECTRONICS, ...CLOTHING, ...BOOKS, ...HOME_DECOR,
  ...HOME_APPLIANCES, ...GYM, ...SPORTS, ...MEDICINES,
];

console.log(`Generated ${ALL_PRODUCTS.length} products`);

// ═══════════════════════════════════════════════════════════
//  BUILD SQL
// ═══════════════════════════════════════════════════════════
const lines = [];
lines.push(`-- ============================================================`);
lines.push(`--  DEEMONA — 1000 Sample Products Seed`);
lines.push(`--  Generated: ${new Date().toISOString().slice(0,10)}`);
lines.push(`--  Categories: Electronics, Clothing, Books, Home Decor,`);
lines.push(`--              Home Appliances, Gym Accessories, Sports, Medicines`);
lines.push(`-- ============================================================`);
lines.push(`USE DeemonaDB;`);
lines.push(`GO`);
lines.push(``);

// ── Categories ─────────────────────────────────────────────
lines.push(`-- Categories`);
lines.push(`SET IDENTITY_INSERT Categories ON;`);
CATEGORIES.forEach(c => {
  lines.push(`IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName='${c.name}')`);
  lines.push(`  INSERT INTO Categories(CategoryID,CategoryName,IsActive) VALUES(${c.id},'${c.name}',1);`);
});
lines.push(`SET IDENTITY_INSERT Categories OFF;`);
lines.push(`GO`);
lines.push(``);

// ── Suppliers ──────────────────────────────────────────────
lines.push(`-- Suppliers`);
lines.push(`SET IDENTITY_INSERT Suppliers ON;`);
SUPPLIERS.forEach(s => {
  lines.push(`IF NOT EXISTS (SELECT 1 FROM Suppliers WHERE Email='${s.email}')`);
  lines.push(`  INSERT INTO Suppliers(SupplierID,SupplierName,ContactEmail,City,IsActive)`);
  lines.push(`  VALUES(${s.id},'${sq(s.name)}','${s.email}','${s.city}',1);`);
});
lines.push(`SET IDENTITY_INSERT Suppliers OFF;`);
lines.push(`GO`);
lines.push(``);

// ── Products (chunked into batches of 50 for safety) ──────
lines.push(`-- Products (${ALL_PRODUCTS.length} total)`);

// Deduplicate names
const seen = new Map();
const dedupedProducts = ALL_PRODUCTS.map(p => {
  const key = `${p.name}|${p.catID}`;
  if (seen.has(key)) {
    const count = seen.get(key) + 1;
    seen.set(key, count);
    return { ...p, name: `${p.name} ${count > 2 ? 'v'+count : 'II'}` };
  }
  seen.set(key, 1);
  return p;
});

// Pad to exactly 1000
while (dedupedProducts.length < 1000) {
  const base = dedupedProducts[Math.floor(Math.random() * dedupedProducts.length)];
  const variant = ['Pro','Plus','Elite','Max','Neo','Lite','Advanced','Premium'][Math.floor(Math.random()*8)];
  dedupedProducts.push({
    ...base,
    name: `${base.name.replace(/ (Pro|Plus|Elite|Max|Neo|Lite|Advanced|Premium)$/,'')} ${variant}`,
    price: Math.round(base.price * (0.85 + Math.random() * 0.3) / 10) * 10,
  });
}
const final1000 = dedupedProducts.slice(0, 1000);

// Write in batches of 50
for (let i = 0; i < final1000.length; i += 50) {
  const batch = final1000.slice(i, i + 50);
  lines.push(`-- Batch ${Math.floor(i/50)+1}/20 (products ${i+1}–${Math.min(i+50,1000)})`);
  batch.forEach((p, idx) => {
    const globalIdx = i + idx + 1;
    const sku   = `${['ELC','CLO','BOK','DEC','APL','GYM','SPT','MED'][p.catID-1]}-${String(globalIdx).padStart(5,'0')}`;
    const price = p.price;
    const mrp   = mrpFrom(price);
    const cp    = cost(price);
    const stk   = stock();
    const ror   = reorder();
    const wt    = p.wt || '0.50';
    const isFeat= (globalIdx % 20 === 0) ? 1 : 0;
    const rating= (3.5 + Math.random() * 1.5).toFixed(1);
    const rvcnt = rnd(0, 450);
    lines.push(`INSERT INTO Products(Name,Description,SKU,Brand,CategoryID,SupplierID,Price,MRP,CostPrice,`);
    lines.push(`  StockQuantity,ReorderLevel,Tags,IsFeatured,Weight,AverageRating,ReviewsCount,IsActive)`);
    lines.push(`VALUES(`);
    lines.push(`  '${sq(p.name.slice(0,250))}',`);
    lines.push(`  '${sq(p.desc.slice(0,499))}',`);
    lines.push(`  '${sku}','${sq((p.brand||'').slice(0,100))}',${p.catID},${p.suppID},`);
    lines.push(`  ${price},${mrp},${cp},${stk},${ror},`);
    lines.push(`  '${p.tags}',${isFeat},${wt},${rating},${rvcnt},1);`);
  });
  lines.push(`GO`);
  lines.push(``);
}

// Summary
lines.push(`-- Verification`);
lines.push(`SELECT c.CategoryName, COUNT(*) AS ProductCount`);
lines.push(`FROM Products p INNER JOIN Categories c ON c.CategoryID=p.CategoryID`);
lines.push(`WHERE p.IsActive=1 GROUP BY c.CategoryName ORDER BY ProductCount DESC;`);
lines.push(`GO`);

// Write file
const outPath = path.join(__dirname, '..', 'seed_products.sql');
fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
console.log(`\n✅  Written to: ${outPath}`);
console.log(`    Lines: ${lines.length}`);
console.log(`    Products: ${final1000.length}`);
console.log(`\nCategory breakdown:`);
const catCounts = {};
final1000.forEach(p => { catCounts[p.catID] = (catCounts[p.catID]||0)+1; });
CATEGORIES.forEach(c => console.log(`  ${c.name.padEnd(20)} ${catCounts[c.id]||0}`));
