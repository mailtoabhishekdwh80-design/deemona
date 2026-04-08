with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Show lines around the thumbnail
for i, l in enumerate(lines[58:72], 59):
    print(f"{i}: {l.rstrip()}")
