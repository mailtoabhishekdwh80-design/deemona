with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 188 - duplicate style
lines[187] = "                <div key={k} style={{ marginBottom: 4, gridColumn: gc || 'auto' }}>\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
