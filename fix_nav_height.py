with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 189 - increase height from 38 to 44 and add vertical padding
lines[188] = '      <div style={{ background: "#0F2D55", padding: "0 16px", display: "flex", alignItems: "center", gap: 4, minHeight: 44, overflowX: "auto", flexWrap: "nowrap" }}>\n'

# Fix link padding on line 197 - increase vertical padding
lines[196] = '            style={{ padding: "8px 12px", color: "#fff", fontSize: 13, fontWeight: 500, whiteSpace: "nowrap", textDecoration: "none", border: "1px solid transparent", borderRadius: 4 }}\n'

# Fix All Categories button padding on line 191
lines[190] = '          style={{ padding: "8px 12px", color: "#fff", background: "none", border: "1px solid transparent", borderRadius: 4, fontSize: 13, fontWeight: 700, cursor: "pointer", whiteSpace: "nowrap" }}\n'

# Fix Today Deals link padding
lines[201] = '        <Link to="/shop?featured=true" style={{ padding: "8px 12px", color: "#00ACC1", fontSize: 13, fontWeight: 700, whiteSpace: "nowrap", textDecoration: "none", marginLeft: "auto" }}>Today Deals</Link>\n'

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
