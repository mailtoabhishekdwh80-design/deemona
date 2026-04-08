with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix the try block - add catch
code = code.replace(
    "try { const raw = product.ImageURLs; const a = Array.isArray(raw) ? raw : JSON.parse(raw || '[]'); return Array.isArray(a) && a.length ? a : [null]; }",
    "try { const raw = product.ImageURLs; const a = Array.isArray(raw) ? raw : JSON.parse(raw || '[]'); return Array.isArray(a) && a.length ? a : [null]; } catch(e) { return [null]; }"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
