with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re
# Find duplicate style attributes
matches = [(i, l) for i, l in enumerate(code.split("\n")) if l.count("style=") > 1]
for i, l in matches[:5]:
    print(f"Line {i+1}: {l[:120]}")
