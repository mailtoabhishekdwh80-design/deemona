with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Show current CATEGORIES line
for i, l in enumerate(code.split("\n")):
    if "CATEGORIES" in l:
        print(f"Line {i+1}: {l.strip()[:120]}")
