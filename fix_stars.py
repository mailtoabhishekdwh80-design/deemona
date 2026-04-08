with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Replace stars function with ASCII version
code = re.sub(
    r"const stars\s*=\s*[^;]+;",
    "const stars = n => '*'.repeat(Math.min(5, Math.max(0, n))) + '-'.repeat(5 - Math.min(5, Math.max(0, n)));",
    code
)

# Fix rupee symbol
code = code.replace("₹", "Rs.")

# Remove all non-ASCII chars
clean = ""
for ch in code:
    if ord(ch) < 128:
        clean += ch
    else:
        clean += ""

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "w", encoding="utf-8") as f:
    f.write(clean)

print("Fixed! Non-ASCII remaining:", sum(1 for c in clean if ord(c) > 127))
