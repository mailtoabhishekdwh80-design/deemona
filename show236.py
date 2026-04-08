with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[230:242], 231):
    print(f"{i}: {l.rstrip()}")
