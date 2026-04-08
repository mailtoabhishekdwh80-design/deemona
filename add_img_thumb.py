with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Add Image column to table header
code = code.replace(
    "['Product', 'SKU', 'Category', 'Price', 'Stock', 'Status', 'Actions']",
    "['', 'Product', 'SKU', 'Category', 'Price', 'Stock', 'Status', 'Actions']"
)

# Add image thumbnail before product name in table row
code = code.replace(
    """                      <div style={{ fontSize: 13, fontWeight: 600, maxWidth: 200, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{p.Name}</div>""",
    """                    <td style={{ padding: '10px 16px' }}>
                        {(() => { try { const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs; const url = Array.isArray(arr) ? arr[0] : ''; return url ? <img src={url} alt={p.Name} style={{ width: 48, height: 48, objectFit: 'cover', borderRadius: 8, border: '1px solid var(--border)' }} onError={e => e.target.style.display='none'}/> : <div style={{ width: 48, height: 48, borderRadius: 8, background: 'var(--cream)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 }}>+</div>; } catch { return null; } })()}
                      </td>
                      <td style={{ padding: '10px 16px' }}>
                      <div style={{ fontSize: 13, fontWeight: 600, maxWidth: 200, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{p.Name}</div>"""
)

# Close the extra td
code = code.replace(
    """                      <div style={{ fontSize: 12, color: 'var(--muted)' }}>{p.Brand}</div>
                    </td>""",
    """                      <div style={{ fontSize: 12, color: 'var(--muted)' }}>{p.Brand}</div>
                      </td>
                    </td>"""
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Image thumbnail added to table!")
