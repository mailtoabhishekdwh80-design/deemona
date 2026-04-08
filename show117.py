# Fix ProductCard.jsx line 117
with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[113:122], 114):
    print(f"{i}: {l.rstrip()}")
