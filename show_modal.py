with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Show modal/form area
for i, l in enumerate(lines[160:210], 161):
    print(f"{i}: {l.rstrip()}")
