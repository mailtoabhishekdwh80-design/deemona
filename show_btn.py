with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[115:125], 116):
    print(f"{i}: {l.rstrip()}")
