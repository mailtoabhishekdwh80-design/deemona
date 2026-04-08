with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix: handle both string and already-parsed array
old = "try { const a = JSON.parse(product.ImageURLs || '[]'); return Array.isArray(a) && a.length ? a : [nu"

# Find full line and replace
import re
code = re.sub(
    r"try \{ const a = JSON\.parse\(product\.ImageURLs \|\| '\[\]'\); return Array\.isArray\(a\) && a\.length \? a : \[nu[^\n]+",
    "try { const raw = product.ImageURLs; const a = Array.isArray(raw) ? raw : JSON.parse(raw || '[]'); return Array.isArray(a) && a.length ? a : [null]; }",
    code
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Product.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
# Verify
match = re.search(r"Array\.isArray\(raw\)", code)
print("Fix applied:", bool(match))
