with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix [Box] placeholder on line 63
lines[62] = "            <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#f7f8f8' }}><svg width='48' height='48' viewBox='0 0 24 24' fill='none' stroke='#ccc' strokeWidth='1.5'><path d='M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z'/></svg></div>\n"

# Fix ReviewsCount showing 0 on line 89
lines[88] = "              <span style={{ fontSize: 12, color: '#007185' }}>{ReviewsCount > 0 ? ReviewsCount.toLocaleString('en-IN') : ''}</span>\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
