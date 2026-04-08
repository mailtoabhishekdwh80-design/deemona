with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 235 - unclosed div tag
lines[234] = "              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 4 }}>\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
