with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re
# Find banner CTA button styling
for i, l in enumerate(code.split("\n")):
    if "cta" in l.lower() or "Shop Now" in l or "Explore" in l or "Get Fit" in l or "btn" in l.lower():
        print(f"Line {i+1}: {l[:120]}")
