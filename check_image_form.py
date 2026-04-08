with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Check for image related code
import re
for i, l in enumerate(code.split("\n")):
    if "image" in l.lower() or "upload" in l.lower() or "ImageURL" in l:
        print(f"Line {i+1}: {l.strip()}")
