with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Show lines 40-60 around the crash area
for i, l in enumerate(lines[38:65], 39):
    print(f"{i}: {l.rstrip()[:120]}")
