with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix Continue Shopping button color to match Add to Cart
code = code.replace(
    "background: '#fff', border: '1px solid #ddd', borderRadius: 20, cursor: 'pointer', fontSize: 13, color: '#007185'",
    "background: '#F0C14B', border: '1px solid #a88734', borderRadius: 20, cursor: 'pointer', fontSize: 13, fontWeight: 700, color: '#111'"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
