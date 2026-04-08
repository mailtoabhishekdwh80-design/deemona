with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "r", encoding="utf-8") as f:
    code = f.read()

code = code.replace(
    "<div style={{ fontSize: 48, marginBottom: 16 }}>[Box]</div>",
    "<div style={{ fontSize: 64, marginBottom: 16 }}>{'📦'}</div>"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Empty state fixed!")
