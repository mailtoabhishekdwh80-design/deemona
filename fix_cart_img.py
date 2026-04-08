with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Cart.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix image display - parse ImageURLs array
code = code.replace(
    "{item.ImageURL ? <img src={item.ImageURL}",
    "{(() => { try { const arr = typeof item.ImageURLs === 'string' ? JSON.parse(item.ImageURLs) : item.ImageURLs; const url = Array.isArray(arr) ? arr[0] : item.ImageURL || ''; return url ? <img src={url}"
)

# Find the rest of the img tag and close the IIFE
code = code.replace(
    "alt=\"\" style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/> : <div",
    "alt=\"\" style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/> : <div"
)

# Simpler approach - just replace the whole image expression
import re
# Find the image rendering pattern
old = re.search(r'\{item\.ImageURL \? <img src=\{item\.ImageURL\}.*?</div>\s*\}', code, re.DOTALL)
if old:
    print("Found old pattern:", old.group()[:100])
else:
    print("Pattern not found, showing line 59:")
    lines = code.split("\n")
    for i in range(56, 65):
        print(f"{i+1}: {lines[i]}")
