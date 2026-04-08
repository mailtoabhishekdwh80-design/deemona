with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "rb") as f:
    code = f.read().decode("utf-8")

# Add id directly to select element
code = code.replace(
    '<select\n            value={searchCat}',
    '<select\n            id="nav-cat"\n            value={searchCat}'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "wb") as f:
    f.write(code.encode("utf-8"))

print("Done! id added:", 'id="nav-cat"' in code)
