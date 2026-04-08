with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\AdminLayout.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Add Outlet to import
code = code.replace(
    'import { Link, useLocation, useNavigate } from "react-router-dom";',
    'import { Link, useLocation, useNavigate, Outlet } from "react-router-dom";'
)

# Replace {children} with <Outlet />
code = code.replace('{children}', '<Outlet />')

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\AdminLayout.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed! Outlet added")
