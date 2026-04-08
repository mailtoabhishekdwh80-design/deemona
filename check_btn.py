with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find Add to Cart button and standardize color
import re
# Show current button style
for i, l in enumerate(code.split("\n")):
    if "Add to Cart" in l or "addItem" in l:
        print(f"Line {i+1}: {l.strip()[:100]}")
