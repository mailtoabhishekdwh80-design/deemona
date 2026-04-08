with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\AdminLayout.jsx", "r", encoding="utf-8") as f:
    code = f.read()

code = code.replace(
    'import { useAuth } from "../context/AuthContext.jsx";',
    'import { useAuth } from "../../context/AuthContext.jsx";'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\AdminLayout.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Fixed!")
