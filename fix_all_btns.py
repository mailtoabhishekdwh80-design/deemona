# Fix Cart.jsx buttons
with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "r", encoding="utf-8") as f:
    code = f.read()

GRAD = "linear-gradient(to bottom,#f7dfa5,#f0c14b)"
GRAD_H = "linear-gradient(to bottom,#f5d78e,#eeb933)"
BORDER = "1px solid #a88734"

# Fix Proceed to Checkout button
code = code.replace(
    "background: '#F0C14B', border: '1px solid #a88734', borderRadius: 20,",
    f"background: '{GRAD}', border: '{BORDER}', borderRadius: 20,"
)
# Fix Continue Shopping button
code = code.replace(
    "background: '#F0C14B', border: '1px solid #a88734', borderRadius: 20, cursor: 'pointer', fontSize: 13, fontWeight: 700, color: '#111'",
    f"background: '{GRAD}', border: '{BORDER}', borderRadius: 20, cursor: 'pointer', fontSize: 13, fontWeight: 500, color: '#111'"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Cart fixed!")

# Fix Home.jsx buttons
with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()
code = code.replace("background: '#F0C14B'", f"background: '{GRAD}'")
code = code.replace("background: \"#F0C14B\"", f"background: \"{GRAD}\"")
with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Home fixed!")
