with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

lines[110] = "                width: '100%', marginTop: 8, padding: '8px 0', borderRadius: 4,\n"
lines[111] = "                background: inStock ? '#F0C14B' : '#e8e8e8',\n"
lines[112] = "                border: inStock ? '1px solid #a88734' : '1px solid #ddd',\n"
lines[113] = "                color: inStock ? '#111' : '#888',\n"
lines[114] = "                fontSize: 13, fontWeight: 700, cursor: inStock ? 'pointer' : 'not-allowed',\n"
lines[116] = "              }}\n"
lines[117] = "              onMouseEnter={e => { if (inStock) e.currentTarget.style.background='#e8b400'; }}\n"
lines[118] = "              onMouseLeave={e => { if (inStock) e.currentTarget.style.background='#F0C14B'; }}\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
