with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\App.jsx", "r", encoding="utf-8") as f:
    code = f.read()

idx = code.find("AdminDashboard")
print(code[idx:idx+800])
