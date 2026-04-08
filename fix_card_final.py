with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Remove duplicate style{{ on line 110 and fix missing button content
lines[109] = "              style={{\n"
lines[110] = "                width: '100%', marginTop: 8, padding: '8px 0', borderRadius: 20,\n"
# Fix missing button text on line 119-120
lines[118] = "              onMouseLeave={e => { if (inStock) e.currentTarget.style.background='linear-gradient(to bottom,#f7dfa5,#f0c14b)'; }}>\n"
lines[119] = "              {adding ? 'Adding\u2026' : inStock ? 'Add to Cart' : 'Unavailable'}\n"
lines[120] = "            </button>\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)
print("Fixed!")
