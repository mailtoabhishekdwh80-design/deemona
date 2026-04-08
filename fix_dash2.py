with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix import - use correct API import
code = code.replace(
    'import { api } from "../../api/index.js";',
    'import axios from "axios";\nconst api = axios.create({ baseURL: "/api", headers: { Authorization: `Bearer ${localStorage.getItem("access_token")}` } });'
)

# Fix duplicate background key in BarChart
code = code.replace(
    '''background:color, borderRadius:"4px 4px 0 0",
            height:`${(d.value/max)*85}%`, minHeight:4,
            background:`linear-gradient(180deg, ${color} 0%, ${color}99 100%)`,''',
    '''borderRadius:"4px 4px 0 0",
            height:`${(d.value/max)*85}%`, minHeight:4,
            background:`linear-gradient(180deg, ${color} 0%, ${color}99 100%)`,'''
)

# Fix duplicate border key
code = code.replace(
    'border:"none", borderRadius:8, border:`1px solid ${period===p?"transparent":"#334155"}`',
    'border:`1px solid ${period===p?"transparent":"#334155"}`'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
