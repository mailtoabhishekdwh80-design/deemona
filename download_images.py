import urllib.request
import os
import json

# Real product-specific images from Unsplash (permanent photo IDs)
products = {
    "ELC-001": ("samsung-s24", "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&q=85"),
    "ELC-002": ("iphone-15", "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=600&q=85"),
    "ELC-003": ("macbook-air", "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&q=85"),
    "ELC-004": ("sony-headphone", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=85"),
    "ELC-005": ("samsung-tv", "https://images.unsplash.com/photo-1593359677879-a4bb92f829e1?w=600&q=85"),
    "ELC-006": ("ipad-air", "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&q=85"),
    "ELC-007": ("sony-camera", "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&q=85"),
    "ELC-008": ("airpods-pro", "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=600&q=85"),
    "ELC-009": ("dell-xps", "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=85"),
    "ELC-010": ("samsung-watch", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=85"),
    "CLO-001": ("levis-jeans", "https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&q=85"),
    "CLO-002": ("nike-tshirt", "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600&q=85"),
    "CLO-003": ("nike-airforce", "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=85"),
    "CLO-004": ("adidas-stansmith", "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?w=600&q=85"),
    "CLO-005": ("hm-hoodie", "https://images.unsplash.com/photo-1556821840-3a63f15732ce?w=600&q=85"),
    "CLO-006": ("formal-shirt", "https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=600&q=85"),
    "CLO-007": ("zara-dress", "https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=600&q=85"),
    "CLO-008": ("trekking-jacket", "https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=600&q=85"),
    "CLO-009": ("kurta-set", "https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=600&q=85"),
    "CLO-010": ("sports-bra", "https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=600&q=85"),
    "BOK-001": ("atomic-habits", "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600&q=85"),
    "BOK-002": ("rich-dad", "https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=600&q=85"),
    "BOK-003": ("psychology-money", "https://images.unsplash.com/photo-1633158829585-23ba8f7c8caf?w=600&q=85"),
    "BOK-004": ("alchemist", "https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600&q=85"),
    "BOK-005": ("sapiens", "https://images.unsplash.com/photo-1589998059171-988d887df646?w=600&q=85"),
    "BOK-006": ("wings-of-fire", "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=600&q=85"),
    "BOK-007": ("zero-to-one", "https://images.unsplash.com/photo-1507679799987-c73779587ccf?w=600&q=85"),
    "BOK-008": ("deep-work", "https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=600&q=85"),
    "BOK-009": ("harry-potter", "https://images.unsplash.com/photo-1474932430478-367dbb6832c1?w=600&q=85"),
    "BOK-010": ("ikigai", "https://images.unsplash.com/photo-1532012197267-da84d127e765?w=600&q=85"),
    "HOM-001": ("philips-bulb", "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&q=85"),
    "HOM-002": ("wakefit-mattress", "https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=85"),
    "HOM-003": ("ceramic-vase", "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=600&q=85"),
    "HOM-004": ("borosil-glass", "https://images.unsplash.com/photo-1514228742587-6b1558fcca3d?w=600&q=85"),
    "HOM-005": ("milton-flask", "https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=600&q=85"),
    "HOM-006": ("carpet-rug", "https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=600&q=85"),
    "HOM-007": ("ikea-curtains", "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=85"),
    "HOM-008": ("nestasia-mug", "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=85"),
    "HOM-009": ("wall-clock", "https://images.unsplash.com/photo-1563861826100-9cb868fdbe1c?w=600&q=85"),
    "HOM-010": ("mandala-tapestry", "https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=600&q=85"),
    "APP-001": ("washing-machine", "https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=600&q=85"),
    "APP-002": ("whirlpool-fridge", "https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=600&q=85"),
    "APP-003": ("lg-microwave", "https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=600&q=85"),
    "APP-004": ("voltas-ac", "https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=600&q=85"),
    "APP-005": ("philips-mixer", "https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=600&q=85"),
    "APP-006": ("philips-airfryer", "https://images.unsplash.com/photo-1585515320310-259814833e62?w=600&q=85"),
    "APP-007": ("crompton-fan", "https://images.unsplash.com/photo-1513506003901-1e6a35d44e07?w=600&q=85"),
    "APP-008": ("prestige-cooker", "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=600&q=85"),
    "APP-009": ("aquaguard-ro", "https://images.unsplash.com/photo-1548612327893-f16a79e7e27e?w=600&q=85"),
    "APP-010": ("dyson-vacuum", "https://images.unsplash.com/photo-1558317374-067fb5f30001?w=600&q=85"),
    "GYM-001": ("hex-dumbbell", "https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=600&q=85"),
    "GYM-002": ("powermax-treadmill", "https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=600&q=85"),
    "GYM-003": ("kobo-yogamat", "https://images.unsplash.com/photo-1592432678016-e910b452f9a2?w=600&q=85"),
    "GYM-004": ("resistance-bands", "https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=600&q=85"),
    "GYM-005": ("whey-protein", "https://images.unsplash.com/photo-1593095948071-474c5cc2989d?w=600&q=85"),
    "GYM-006": ("pullup-bar", "https://images.unsplash.com/photo-1576678927484-cc907957088c?w=600&q=85"),
    "GYM-007": ("creatine", "https://images.unsplash.com/photo-1594381898411-846e7d193883?w=600&q=85"),
    "GYM-008": ("gym-gloves", "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=600&q=85"),
    "SPT-001": ("sg-cricket-bat", "https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=600&q=85"),
    "SPT-002": ("mrf-cricket-bat", "https://images.unsplash.com/photo-1540747913346-19212a4cf528?w=600&q=85"),
    "SPT-003": ("yonex-badminton", "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=600&q=85"),
    "SPT-004": ("nivia-football", "https://images.unsplash.com/photo-1553778263-73a83bab9b0c?w=600&q=85"),
    "SPT-005": ("wilson-tennis", "https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=600&q=85"),
    "SPT-006": ("quechua-backpack", "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=85"),
    "SPT-007": ("adidas-football-shoes", "https://images.unsplash.com/photo-1511886929837-354d827aae26?w=600&q=85"),
    "SPT-008": ("kiprun-running", "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600&q=85"),
    "MED-001": ("himalaya-ashwagandha", "https://images.unsplash.com/photo-1471864190281-a93a3070b6de?w=600&q=85"),
    "MED-002": ("dabur-chyawanprash", "https://images.unsplash.com/photo-1550572017-edd951b55104?w=600&q=85"),
    "MED-003": ("revital-multivitamin", "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=600&q=85"),
    "MED-004": ("neurobion-forte", "https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=600&q=85"),
    "MED-005": ("dettol-antiseptic", "https://images.unsplash.com/photo-1631549916768-4119b2e5f926?w=600&q=85"),
    "MED-006": ("omega3-fishoil", "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=600&q=85"),
    "MED-007": ("patanjali-triphala", "https://images.unsplash.com/photo-1512069772995-ec65ed45afd6?w=600&q=85"),
    "MED-008": ("vicks-vaporub", "https://images.unsplash.com/photo-1576671081837-49000212a370?w=600&q=85"),
}

os.makedirs(r"C:\Deemona\product_images", exist_ok=True)
sql_lines = ["USE deemona;"]
failed = []
success = 0

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"}

for sku, (name, url) in products.items():
    filename = f"{name}.jpg"
    filepath = os.path.join(r"C:\Deemona\product_images", filename)
    local_url = f"/uploads/products/{filename}"
    
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            with open(filepath, "wb") as f:
                f.write(response.read())
        sql_lines.append(f'UPDATE Products SET ImageURLs = \'["{local_url}"]\' WHERE SKU=\'{sku}\';')
        success += 1
        print(f"OK: {sku} - {name}")
    except Exception as e:
        failed.append(sku)
        # Keep existing URL as fallback
        sql_lines.append(f'UPDATE Products SET ImageURLs = \'["{url}"]\' WHERE SKU=\'{sku}\';')
        print(f"FAIL: {sku} - {e}")

sql_lines.append("SELECT COUNT(*) AS Updated FROM Products;")

with open(r"C:\Deemona\update_images_local.sql", "w") as f:
    f.write("\n".join(sql_lines))

print(f"\nDone! Success: {success}, Failed: {len(failed)}")
print(f"Images saved to C:\\Deemona\\product_images\\")
if failed: print(f"Failed SKUs: {failed}")
