with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[90:140], 91):
    print(f"{i}: {l.rstrip()[:120]}")
