with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\App.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Show full admin routes
idx = code.find("AdminLayout")
print(code[idx:idx+800])
