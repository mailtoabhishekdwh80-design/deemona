with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix 0 rating count
code = code.replace(
    "<span style={{ fontSize: 12, color: '#007185' }}>{ReviewsCount?.toLocaleString('en-IN')}</span>",
    "<span style={{ fontSize: 12, color: '#007185' }}>{ReviewsCount > 0 ? `(${ReviewsCount.toLocaleString('en-IN')})` : ''}</span>"
)

# Fix [Box] placeholder
code = code.replace(
    "<div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 40 }}>[Box]</div>",
    "<div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#f7f8f8', fontSize: 36, color: '#ccc' }}>{'📦'}</div>"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Fixed!")
