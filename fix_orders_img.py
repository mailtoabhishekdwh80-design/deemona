with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 62 - replace [Box] with proper order icon
lines[61] = """                    <div style={{ width: 56, height: 56, background: 'linear-gradient(135deg,#1B3A6B,#2d5a9e)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                      <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/>
                        <line x1="3" y1="6" x2="21" y2="6"/>
                        <path d="M16 10a4 4 0 0 1-8 0"/>
                      </svg>
                    </div>\n"""

# Also fix the empty orders [Box] on line 48
with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
