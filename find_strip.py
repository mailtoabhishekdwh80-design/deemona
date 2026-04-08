with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find the category strip container style
for i, l in enumerate(code.split("\n")):
    if "nav-strip" in l or "navStrip" in l or "category" in l.lower() and "strip" in l.lower():
        print(f"Line {i+1}: {l.strip()[:120]}")
