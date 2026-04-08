with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix function names from CartContext
code = code.replace(
    "const { items, update, remove, clear, count } = useCart();",
    "const { items, updateItem: update, removeItem: remove, clearCart: clear, count } = useCart();"
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
