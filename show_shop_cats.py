with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Shop.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find category filter in sidebar
for i, l in enumerate(code.split("\n")):
    if "CategoryName" in l or "categories.map" in l or "All Categories" in l:
        print(f"Line {i+1}: {l.strip()[:100]}")
