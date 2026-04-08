with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find and show the Add Product button area
for i, l in enumerate(code.split("\n")):
    if "Add Product" in l or "btn-gold" in l or "openCreate" in l:
        print(f"Line {i+1}: {l.strip()}")
