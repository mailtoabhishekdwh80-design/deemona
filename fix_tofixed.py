with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Fix all .toFixed() calls to handle strings - wrap in Number()
code = re.sub(r'(\w+)\?\.toFixed\((\d+)\)', r'Number(\1)?.toFixed(\2)', code)
code = re.sub(r'(\w+)\.toFixed\((\d+)\)', r'Number(\1).toFixed(\2)', code)

# Fix .toLocaleString() calls on price fields
code = re.sub(r'(Price|MRP|Price)\?\.toLocaleString', r'Number(\1)?.toLocaleString', code)
code = re.sub(r'(AverageRating)\?\.toFixed', r'Number(\1)?.toFixed', code)

# Remove non-ASCII
clean = "".join(c if ord(c) < 128 else "" for c in code)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "w", encoding="utf-8") as f:
    f.write(clean)

print("Fixed! toFixed calls now wrapped in Number()")
