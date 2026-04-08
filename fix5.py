import urllib.request
import os

# Replacement URLs for the 5 failed ones
fixes = {
    "ELC-005": ("samsung-tv", "https://images.unsplash.com/photo-1601944179066-29786cb9d32a?w=600&q=85"),
    "CLO-005": ("hm-hoodie", "https://images.unsplash.com/photo-1620799139507-2a76f79a2f4d?w=600&q=85"),
    "APP-007": ("crompton-fan", "https://images.unsplash.com/photo-1558618047-f4e60cfc3830?w=600&q=85"),
    "APP-009": ("aquaguard-ro", "https://images.unsplash.com/photo-1600147131759-880e94a6185f?w=600&q=85"),
    "SPT-002": ("mrf-cricket-bat", "https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=600&q=85"),
}

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"}
sql_fixes = ["USE deemona;"]

for sku, (name, url) in fixes.items():
    filename = f"{name}.jpg"
    filepath = os.path.join(r"C:\Deemona\product_images", filename)
    local_url = f"/uploads/products/{filename}"
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            with open(filepath, "wb") as f:
                f.write(response.read())
        sql_fixes.append(f'UPDATE Products SET ImageURLs = \'["{local_url}"]\' WHERE SKU=\'{sku}\';')
        print(f"OK: {sku} - {name}")
    except Exception as e:
        # Use fallback Unsplash URL directly
        sql_fixes.append(f'UPDATE Products SET ImageURLs = \'["{url}"]\' WHERE SKU=\'{sku}\';')
        print(f"FALLBACK: {sku} - using direct URL")

with open(r"C:\Deemona\fix_5.sql", "w") as f:
    f.write("\n".join(sql_fixes))
print("Done!")
