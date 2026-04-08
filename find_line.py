with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix the JSON.parse crash - handle both string and array
old = "try { const a = JSON.parse(product.ImageURLs || '[]'); return Array.isArray(a) && a.length ? a : [nul"
# Find the full line
import re
match = re.search(r"try \{ const a = JSON\.parse\(product\.ImageURLs.*?\n", code)
if match:
    print("Found:", match.group()[:100])
else:
    print("Pattern not found, showing line 48 area:")
    lines = code.split("\n")
    for i, l in enumerate(lines[45:52], 46):
        print(f"{i}: {l[:120]}")
