with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 59 - add missing closing })()}
lines[58] = "                    {(() => { try { const arr = typeof item.ImageURLs === 'string' ? JSON.parse(item.ImageURLs) : item.ImageURLs; const url = Array.isArray(arr) ? arr[0] : item.ImageURL || ''; return url ? <img src={url} alt={item.ProductName} style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/> : <span style={{fontSize:28}}>{'?'}</span>; } catch { return <span>{'?'}</span>; } })()}\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
print("Line 59:", lines[58][:100])
