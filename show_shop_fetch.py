with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Shop.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[45:75], 46):
    print(f"{i}: {l.rstrip()}")
