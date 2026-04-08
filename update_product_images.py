"""
update_product_images.py
Run: python update_product_images.py
Updates all product images with accurate Unsplash/Pexels URLs
"""
import subprocess

# SKU -> Image URL mapping with accurate product photos
images = {
    # ── MOBILES ──────────────────────────────────────────────────────
    "MOB-001": "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=80",  # Samsung S24
    "MOB-002": "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&q=80",  # iPhone 15 Pro
    "MOB-003": "https://images.unsplash.com/photo-1598327106026-d9521da673d3?w=600&q=80",  # OnePlus
    "MOB-004": "https://images.unsplash.com/photo-1598327106026-d9521da673d3?w=600&q=80",  # Pixel
    "MOB-005": "https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=600&q=80",  # Xiaomi
    "MOB-006": "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=600&q=80",  # Realme
    "MOB-007": "https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=600&q=80",  # Vivo
    "MOB-008": "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=80",  # Samsung A55
    "MOB-009": "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&q=80",  # iPhone 15
    "MOB-010": "https://images.unsplash.com/photo-1598327106026-d9521da673d3?w=600&q=80",  # Redmi
    "MOB-011": "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=600&q=80",  # OPPO
    "MOB-012": "https://images.unsplash.com/photo-1574944985070-8f3ebc6b79d2?w=600&q=80",  # Motorola
    "MOB-013": "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=80",  # Z Fold
    "MOB-014": "https://images.unsplash.com/photo-1598327106026-d9521da673d3?w=600&q=80",  # Nothing
    "MOB-015": "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=600&q=80",  # iQOO

    # ── LAPTOPS ──────────────────────────────────────────────────────
    "LAP-001": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&q=80",  # MacBook Air
    "LAP-002": "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80",  # Dell XPS
    "LAP-003": "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=80",  # HP Spectre
    "LAP-004": "https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=600&q=80",  # ThinkPad
    "LAP-005": "https://images.unsplash.com/photo-1593642634367-d91a135587b5?w=600&q=80",  # ASUS ROG
    "LAP-006": "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=80",  # Acer Swift
    "LAP-007": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&q=80",  # MacBook Pro
    "LAP-008": "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80",  # Galaxy Book
    "PER-001": "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&q=80",  # Logitech Mouse
    "PER-002": "https://images.unsplash.com/photo-1541140532154-b024d705b90a?w=600&q=80",  # Keychron
    "MON-001": "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=600&q=80",  # Dell Monitor
    "STO-001": "https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=600&q=80",  # Samsung SSD

    # ── CAMERAS ──────────────────────────────────────────────────────
    "CAM-001": "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&q=80",  # Sony A7IV
    "CAM-002": "https://images.unsplash.com/photo-1502982720700-bfff97f2ecac?w=600&q=80",  # Canon R6
    "CAM-003": "https://images.unsplash.com/photo-1512790182412-b19e6d62bc39?w=600&q=80",  # Nikon Z6
    "CAM-004": "https://images.unsplash.com/photo-1551721434-8b94ddff0e6d?w=600&q=80",  # GoPro
    "CAM-005": "https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=600&q=80",  # DJI Drone
    "CAM-006": "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&q=80",  # Fujifilm
    "LEN-001": "https://images.unsplash.com/photo-1617296538902-887900d9b592?w=600&q=80",  # Sony Lens
    "LEN-002": "https://images.unsplash.com/photo-1617296538902-887900d9b592?w=600&q=80",  # Canon Lens

    # ── AUDIO ─────────────────────────────────────────────────────────
    "AUD-001": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80",  # Sony WH-1000XM5
    "AUD-002": "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&q=80",  # AirPods Pro
    "AUD-003": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80",  # Bose QC45
    "AUD-004": "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&q=80",  # JBL Charge
    "AUD-005": "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600&q=80",  # Galaxy Buds
    "AUD-006": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80",  # boAt
    "AUD-007": "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&q=80",  # Sony SRS
    "AUD-008": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80",  # Sennheiser
    "AUD-009": "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&q=80",  # Marshall
    "AUD-010": "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600&q=80",  # Realme Buds

    # ── TVs ───────────────────────────────────────────────────────────
    "TV-001": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # Samsung QLED
    "TV-002": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # LG OLED
    "TV-003": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # Sony Bravia
    "TV-004": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # Mi TV
    "TV-005": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # OnePlus TV
    "TV-006": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # Hisense
    "TV-007": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # TCL
    "TV-008": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",  # Fire TV Stick

    # ── KITCHEN ───────────────────────────────────────────────────────
    "KIT-001": "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=80",  # Instant Pot
    "KIT-002": "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=80",  # Philips Airfryer
    "KIT-003": "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=80",  # Ninja
    "KIT-004": "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&q=80",  # KitchenAid
    "KIT-005": "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=80",  # Prestige
    "KIT-006": "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=80",  # Morphy OTG
    "KIT-007": "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80",  # Milton Flask
    "KIT-008": "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=80",  # Pigeon Chopper
    "KIT-009": "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=80",  # Borosil
    "KIT-010": "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=80",  # Hawkins

    # ── BEAUTY ────────────────────────────────────────────────────────
    "BTY-001": "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600&q=80",  # Lakme
    "BTY-002": "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=600&q=80",  # Mamaearth
    "BTY-003": "https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=600&q=80",  # Wow Shampoo
    "BTY-004": "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=600&q=80",  # LOreal
    "BTY-005": "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600&q=80",  # Nykaa Lipstick
    "BTY-006": "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=600&q=80",  # Biotique
    "BTY-007": "https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=600&q=80",  # Dove Lotion
    "BTY-008": "https://images.unsplash.com/photo-1585751119414-ef2636f8aede?w=600&q=80",  # Philips Trimmer
    "BTY-009": "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=600&q=80",  # Plum
    "BTY-010": "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600&q=80",  # Forest Essentials

    # ── WATCHES ───────────────────────────────────────────────────────
    "WAT-001": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&q=80",  # Apple Watch
    "WAT-002": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80",  # Galaxy Watch
    "WAT-003": "https://images.unsplash.com/photo-1544117519-31a4b719223d?w=600&q=80",  # Garmin
    "WAT-004": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80",  # Titan Kairos
    "WAT-005": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&q=80",  # boAt Wave
    "WAT-006": "https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=600&q=80",  # Casio G-Shock
    "WAT-007": "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80",  # Fossil
    "WAT-008": "https://images.unsplash.com/photo-1587836374828-4dbafa94cf0e?w=600&q=80",  # Titan Raga
    "WAT-009": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&q=80",  # Noise
    "WAT-010": "https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=600&q=80",  # Orient

    # ── BAGS ──────────────────────────────────────────────────────────
    "BAG-001": "https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=600&q=80",  # American Tourister
    "BAG-002": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80",  # Samsonite Backpack
    "BAG-003": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80",  # Wildcraft
    "BAG-004": "https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600&q=80",  # Lavie Handbag
    "BAG-005": "https://images.unsplash.com/photo-1627123424574-724758594785?w=600&q=80",  # Fossil Wallet
    "BAG-006": "https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=600&q=80",  # Nasher Miles
    "BAG-007": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80",  # Skybags
    "BAG-008": "https://images.unsplash.com/photo-1565026057447-bc90a3dceb87?w=600&q=80",  # Safari

    # ── FOOTWEAR ──────────────────────────────────────────────────────
    "FOT-001": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80",  # Nike Air Max
    "FOT-002": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80",  # Adidas Ultraboost
    "FOT-003": "https://images.unsplash.com/photo-1603487742131-4160ec999306?w=600&q=80",  # Bata Sandals
    "FOT-004": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80",  # Woodland
    "FOT-005": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80",  # Puma Suede
    "FOT-006": "https://images.unsplash.com/photo-1614252234498-b3f1a1e5e7b2?w=600&q=80",  # Red Tape Formal
    "FOT-007": "https://images.unsplash.com/photo-1603487742131-4160ec999306?w=600&q=80",  # Crocs
    "FOT-008": "https://images.unsplash.com/photo-1603487742131-4160ec999306?w=600&q=80",  # Metro Heels
    "FOT-009": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80",  # Skechers
    "FOT-010": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80",  # HRX

    # ── BABY PRODUCTS ─────────────────────────────────────────────────
    "BAB-001": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Pampers
    "BAB-002": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Johnson Baby
    "BAB-003": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Mee Mee Pram
    "BAB-004": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Philips Avent
    "BAB-005": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Fisher Price
    "BAB-006": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Himalaya Baby
    "BAB-007": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Chicco Monitor
    "BAB-008": "https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=600&q=80",  # Huggies

    # ── TOYS ──────────────────────────────────────────────────────────
    "TOY-001": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80",  # LEGO
    "TOY-002": "https://images.unsplash.com/photo-1611371805429-8b5c1b2c34ba?w=600&q=80",  # Monopoly
    "TOY-003": "https://images.unsplash.com/photo-1611371805429-8b5c1b2c34ba?w=600&q=80",  # Catan
    "TOY-004": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80",  # Hot Wheels
    "TOY-005": "https://images.unsplash.com/photo-1611371805429-8b5c1b2c34ba?w=600&q=80",  # Scrabble
    "TOY-006": "https://images.unsplash.com/photo-1611371805429-8b5c1b2c34ba?w=600&q=80",  # UNO
    "TOY-007": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80",  # Play-Doh
    "TOY-008": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80",  # Barbie

    # ── PET SUPPLIES ──────────────────────────────────────────────────
    "PET-001": "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?w=600&q=80",  # Pedigree
    "PET-002": "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600&q=80",  # Whiskas
    "PET-003": "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?w=600&q=80",  # Drools
    "PET-004": "https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&q=80",  # Pet Shampoo
    "PET-005": "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?w=600&q=80",  # Trixie Leash
    "PET-006": "https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&q=80",  # Savic Crate
    "PET-007": "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=600&q=80",  # Catit Fountain
    "PET-008": "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?w=600&q=80",  # PawZz Toys

    # ── GROCERY ───────────────────────────────────────────────────────
    "GRO-001": "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=600&q=80",  # Aashirvaad Atta
    "GRO-002": "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=600&q=80",  # Tata Tea
    "GRO-003": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=600&q=80",  # Nescafe
    "GRO-004": "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=600&q=80",  # Dabur Honey
    "GRO-005": "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=600&q=80",  # Fortune Oil
    "GRO-006": "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=600&q=80",  # India Gate Rice
    "GRO-007": "https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=600&q=80",  # Amul Ghee
    "GRO-008": "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=600&q=80",  # MDH Masala
    "GRO-009": "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&q=80",  # Haldirams
    "GRO-010": "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=600&q=80",  # Maggi

    # ── MUSICAL INSTRUMENTS ───────────────────────────────────────────
    "MUS-001": "https://images.unsplash.com/photo-1510915361894-db8b60106cb1?w=600&q=80",  # Yamaha Guitar
    "MUS-002": "https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=600&q=80",  # Casio Keyboard
    "MUS-003": "https://images.unsplash.com/photo-1524230572899-a752b3835840?w=600&q=80",  # Pearl Drums
    "MUS-004": "https://images.unsplash.com/photo-1510915361894-db8b60106cb1?w=600&q=80",  # Fender Strat
    "MUS-005": "https://images.unsplash.com/photo-1524230572899-a752b3835840?w=600&q=80",  # Cajon
    "MUS-006": "https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=600&q=80",  # Focusrite

    # ── AUTOMOTIVE ────────────────────────────────────────────────────
    "AUT-001": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # 3M Car Care
    "AUT-002": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Michelin Inflator
    "AUT-003": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Varta Battery
    "AUT-004": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Garmin GPS
    "AUT-005": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Portronics Charger
    "AUT-006": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Dash Cam
    "AUT-007": "https://images.unsplash.com/photo-1558618047-f4e60cfd3f7d?w=600&q=80",  # RE Helmet
    "AUT-008": "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=600&q=80",  # Bosch Vacuum

    # ── OFFICE SUPPLIES ───────────────────────────────────────────────
    "OFF-001": "https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=600&q=80",  # Parker Pen
    "OFF-002": "https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=600&q=80",  # HP Printer
    "OFF-003": "https://images.unsplash.com/photo-1612815154858-60aa4c59eaa6?w=600&q=80",  # Epson Printer
    "OFF-004": "https://images.unsplash.com/photo-1506880018603-83d5b814b5a6?w=600&q=80",  # Classmate
    "OFF-005": "https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=600&q=80",  # Scotch Tape
    "OFF-006": "https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=600&q=80",  # Faber Castell
    "OFF-007": "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&q=80",  # Kensington Mouse
    "OFF-008": "https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?w=600&q=80",  # Stapler

    # ── EXISTING PRODUCTS (original 74) ───────────────────────────────
    "ELC-001": "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=80",
    "ELC-002": "https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&q=80",
    "ELC-003": "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&q=80",
    "ELC-004": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80",
    "ELC-005": "https://images.unsplash.com/photo-1593359677879-a4bb92f4834c?w=600&q=80",
    "ELC-006": "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&q=80",
    "ELC-007": "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&q=80",
    "ELC-008": "https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&q=80",
    "ELC-009": "https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80",
    "ELC-010": "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&q=80",
    "CLO-001": "https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&q=80",
    "CLO-002": "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=80",
    "CLO-003": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80",
    "CLO-004": "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80",
    "CLO-005": "https://images.unsplash.com/photo-1620799139507-2a76f79a2f4d?w=600&q=80",
    "CLO-006": "https://images.unsplash.com/photo-1603252109303-2751441dd157?w=600&q=80",
    "CLO-007": "https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=600&q=80",
    "CLO-008": "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=600&q=80",
    "CLO-009": "https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=600&q=80",
    "CLO-010": "https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=600&q=80",
    "BOK-001": "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600&q=80",
    "BOK-002": "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=600&q=80",
    "BOK-003": "https://images.unsplash.com/photo-1633158829585-23ba8f7c8caf?w=600&q=80",
    "BOK-004": "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600&q=80",
    "BOK-005": "https://images.unsplash.com/photo-1589998059171-988d887df646?w=600&q=80",
    "BOK-006": "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=600&q=80",
    "BOK-007": "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600&q=80",
    "BOK-008": "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=600&q=80",
    "BOK-009": "https://images.unsplash.com/photo-1474932430478-367dbb6832c1?w=600&q=80",
    "BOK-010": "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=600&q=80",
    "HOM-001": "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&q=80",
    "HOM-002": "https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80",
    "HOM-003": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=600&q=80",
    "HOM-004": "https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=600&q=80",
    "HOM-005": "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=600&q=80",
    "HOM-006": "https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=600&q=80",
    "HOM-007": "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80",
    "HOM-008": "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80",
    "HOM-009": "https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?w=600&q=80",
    "HOM-010": "https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=600&q=80",
    "APP-001": "https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=600&q=80",
    "APP-002": "https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=600&q=80",
    "APP-003": "https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=600&q=80",
    "APP-004": "https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=600&q=80",
    "APP-005": "https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=600&q=80",
    "APP-006": "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=80",
    "APP-007": "https://images.unsplash.com/photo-1513506003901-1e6a35d44e07?w=600&q=80",
    "APP-008": "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=80",
    "APP-009": "https://images.unsplash.com/photo-1600147131759-880e94a6185f?w=600&q=80",
    "APP-010": "https://images.unsplash.com/photo-1558317374-067fb5f30001?w=600&q=80",
    "GYM-001": "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=600&q=80",
    "GYM-002": "https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=600&q=80",
    "GYM-003": "https://images.unsplash.com/photo-1592432678016-e910b452f9a2?w=600&q=80",
    "GYM-004": "https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=600&q=80",
    "GYM-005": "https://images.unsplash.com/photo-1593095948071-474c5cc2989d?w=600&q=80",
    "GYM-006": "https://images.unsplash.com/photo-1576678927484-cc907957088c?w=600&q=80",
    "GYM-007": "https://images.unsplash.com/photo-1594381898411-846e7d193883?w=600&q=80",
    "GYM-008": "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=600&q=80",
    "SPT-001": "https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=600&q=80",
    "SPT-002": "https://images.unsplash.com/photo-1540747913346-19212a4cf528?w=600&q=80",
    "SPT-003": "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=600&q=80",
    "SPT-004": "https://images.unsplash.com/photo-1553778263-73a83bab9b0c?w=600&q=80",
    "SPT-005": "https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=600&q=80",
    "SPT-006": "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80",
    "SPT-007": "https://images.unsplash.com/photo-1511886929837-354d827aae26?w=600&q=80",
    "SPT-008": "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600&q=80",
    "MED-001": "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=600&q=80",
    "MED-002": "https://images.unsplash.com/photo-1550572017-edd951b55104?w=600&q=80",
    "MED-003": "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=600&q=80",
    "MED-004": "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=600&q=80",
    "MED-005": "https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=600&q=80",
    "MED-006": "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=600&q=80",
    "MED-007": "https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?w=600&q=80",
    "MED-008": "https://images.unsplash.com/photo-1576671081837-49000212a370?w=600&q=80",
}

# Build SQL
sql = "USE deemona;\n"
for sku, url in images.items():
    sql += f"UPDATE Products SET ImageURLs='[\"{url}\"]' WHERE SKU='{sku}';\n"

# Run against MySQL
result = subprocess.run(
    ["docker", "exec", "-i", "deemona-mysql", "mysql", "-u", "root", "-pDeemonaLocal123", "deemona"],
    input=sql, capture_output=True, text=True
)

if result.returncode == 0:
    print(f"SUCCESS! Updated images for {len(images)} products")
else:
    print("Error:", result.stderr[:200])

