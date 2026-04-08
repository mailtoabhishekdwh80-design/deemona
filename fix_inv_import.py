with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Inventory.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Replace api import with axios directly
code = code.replace(
    'import { api } from "../../api/index.js";',
    'import axios from "axios";\nconst api = axios.create({ baseURL: "/api" });\napi.interceptors.request.use(c => { c.headers.Authorization = "Bearer " + (localStorage.getItem("access_token")||""); return c; });'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Inventory.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Fixed!")
