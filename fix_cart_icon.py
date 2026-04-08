with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Replace the Cart link text with SVG icon + text
code = code.replace(
    '''<Link to="/cart" style={{ ...navLink, display: "flex", alignItems: "center", gap: 6, position: "relative" }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >
            <span style={{ fontSize: 14, fontWeight: 700 }}>
              Cart {count > 0 && <span style={{ background: "#00ACC1", color: "#fff", borderRadius: "50%", padding: "1px 5px", fontSize: 11 }}>{count}</span>}
            </span>
          </Link>''',
    '''<Link to="/cart" style={{ ...navLink, display: "flex", alignItems: "center", gap: 6, position: "relative" }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >
            <div style={{ position: "relative" }}>
              <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
              </svg>
              {count > 0 && <span style={{ position: "absolute", top: -8, right: -8, background: "#F0C14B", color: "#111", width: 18, height: 18, borderRadius: "50%", fontSize: 11, fontWeight: 800, display: "flex", alignItems: "center", justifyContent: "center" }}>{count > 9 ? "9+" : count}</span>}
            </div>
            <span style={{ fontSize: 14, fontWeight: 700 }}>Cart</span>
          </Link>'''
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Cart icon added!")
