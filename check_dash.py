with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Remove the sidebar from Dashboard - AdminLayout already provides it
# Find and remove the aside element and the outer flex div
code = code.replace(
    'import { Link, useNavigate } from "react-router-dom";',
    'import { Link, useNavigate } from "react-router-dom";\nimport { useAuth } from "../../context/AuthContext.jsx";'
)

# Remove sideOpen state
code = code.replace(
    "  const [sideOpen, setSideOpen] = useState(true);\n",
    ""
)

# Remove the outer flex div wrapper and aside
import re

# Find the return statement and remove sidebar
old_return = re.search(r'return \(\s*<div style=\{.*?display:"flex".*?minHeight:"100vh".*?\}>', code, re.DOTALL)
if old_return:
    print("Found outer div")
else:
    print("Not found - checking structure")
    # Show first 20 lines of return
    idx = code.find("return (")
    print(code[idx:idx+500])
