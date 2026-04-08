with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Replace the shopping bag icon with actual product image
old_div = """                    <div style={{ width: 56, height: 56, background: 'linear-gradient(135deg,#1B3A6B,#2d5a9e)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                      <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/>
                        <line x1="3" y1="6" x2="21" y2="6"/>
                        <path d="M16 10a4 4 0 0 1-8 0"/>
                      </svg>
                    </div>"""

new_div = """                    {(() => {
                      try {
                        const arr = typeof order.FirstImageURLs === 'string' ? JSON.parse(order.FirstImageURLs) : order.FirstImageURLs;
                        const url = Array.isArray(arr) ? arr[0] : '';
                        return url ? (
                          <div style={{ width: 56, height: 56, borderRadius: 10, overflow: 'hidden', flexShrink: 0, border: '1px solid var(--border)', background: '#f7f8f8' }}>
                            <img src={url} alt="Product" style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/>
                          </div>
                        ) : (
                          <div style={{ width: 56, height: 56, background: 'linear-gradient(135deg,#1B3A6B,#2d5a9e)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontSize: 24 }}>{'📦'}</div>
                        );
                      } catch { return <div style={{ width: 56, height: 56, background: '#f7f8f8', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24 }}>{'📦'}</div>; }
                    })()}"""

code = "".join(lines)
code = code.replace(old_div, new_div)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Orders.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Orders.jsx fixed!")
