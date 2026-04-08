with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\App.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Show admin routes section
idx = code.find("admin")
print(code[idx-100:idx+500])
