with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Remove duplicate }} on line 117 (index 116)
lines[116] = ""
# Add > to close the button tag after onMouseLeave
lines[118] = "              onMouseLeave={e => { if (inStock) e.currentTarget.style.background='#F0C14B'; }}>\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed ProductCard!")
