import re

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

old_row = re.search(r'<tr key=\{p\.ProductID\}.*?</tr>', code, re.DOTALL).group()

new_row = """<tr key={p.ProductID} style={{ borderBottom: '1px solid var(--border)', background: i % 2 ? 'var(--cream)' : 'var(--white)' }}>
                    <td style={{ padding: '10px 16px', width: 60 }}>
                      {(() => { try { const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs; const url = Array.isArray(arr) ? arr[0] : ''; return url ? <img src={url} alt={p.Name} style={{ width: 48, height: 48, objectFit: 'cover', borderRadius: 8, border: '1px solid var(--border)' }} onError={e => e.target.style.display='none'}/> : <div style={{ width: 48, height: 48, borderRadius: 8, background: 'var(--cream)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 }}>{'?'}</div>; } catch { return null; } })()}
                    </td>
                    <td style={{ padding: '10px 16px' }}>
                      <div style={{ fontSize: 13, fontWeight: 600, maxWidth: 200, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{p.Name}</div>
                      {p.Brand && <div style={{ fontSize: 11, color: 'var(--muted)' }}>{p.Brand}</div>}
                    </td>
                    <td style={{ padding: '12px 16px', fontSize: 12, fontFamily: 'var(--mono)', color: 'var(--muted)' }}>{p.SKU}</td>
                    <td style={{ padding: '12px 16px', fontSize: 12, color: 'var(--sub)' }}>{p.CategoryName}</td>
                    <td style={{ padding: '12px 16px' }}>
                      <div style={{ fontSize: 13, fontWeight: 700 }}>Rs.{Number(p.Price).toLocaleString('en-IN')}</div>
                      {p.MRP > p.Price && <div style={{ fontSize: 11, color: 'var(--muted)', textDecoration: 'line-through' }}>Rs.{Number(p.MRP).toLocaleString('en-IN')}</div>}
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <span style={{ fontSize: 13, fontWeight: 600, color: p.StockQuantity <= 0 ? 'var(--red)' : p.StockQuantity <= 10 ? 'var(--amber)' : 'var(--green)' }}>
                        {p.StockQuantity}
                      </span>
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <span style={{ padding: '3px 10px', borderRadius: 100, fontSize: 11, fontWeight: 600, background: p.IsActive ? 'var(--green-l)' : 'var(--red-l)', color: p.IsActive ? 'var(--green)' : 'var(--red)' }}>
                        {p.IsActive ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <div style={{ display: 'flex', gap: 6 }}>
                        <button onClick={() => openEdit(p)} className="btn btn-outline btn-sm">Edit</button>
                        <button onClick={() => handleDelete(p.ProductID)} style={{ padding: '6px 12px', borderRadius: 6, border: 'none', background: 'var(--red-l)', color: 'var(--red)', cursor: 'pointer', fontSize: 12, fontWeight: 600 }}>Del</button>
                      </div>
                    </td>
                  </tr>"""

code = code.replace(old_row, new_row)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
