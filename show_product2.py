with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[0:40], 1):
    print(f"{i}: {l.rstrip()[:120]}")
