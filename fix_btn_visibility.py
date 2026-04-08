with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix Add Product button
code = code.replace(
    '<button onClick={openCreate} className="btn btn-gold">+ Add Product</button>',
    '<button onClick={openCreate} style={{ padding: "10px 20px", background: "#F0C14B", color: "#111", border: "none", borderRadius: 8, fontSize: 13, fontWeight: 700, cursor: "pointer", boxShadow: "0 2px 8px rgba(240,193,75,.4)" }}>+ Add Product</button>'
)

# Fix search input visibility
code = code.replace(
    'value={search} onChange={e => setSearch(e.target.value)} className="input" placeholder="Search products..."',
    'value={search} onChange={e => setSearch(e.target.value)} placeholder="Search products..." style={{ padding: "9px 14px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", background: "#fff", outline: "none", width: 240 }}'
)

# Fix Edit button
code = code.replace(
    'onClick={() => openEdit(p)} className="btn btn-outline btn-sm">Edit</button>',
    'onClick={() => openEdit(p)} style={{ padding: "6px 12px", borderRadius: 6, border: "1px solid #d1d5db", background: "#fff", color: "#374151", cursor: "pointer", fontSize: 12, fontWeight: 600 }}>Edit</button>'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
