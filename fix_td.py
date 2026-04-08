with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix: Remove the extra unclosed td on line 125 (index 124)
lines[124] = ""  # Remove the extra <td style={{ padding: '12px 16px' }}> line

# Fix the brand div closing - line 131 missing </div>
lines[130] = "                      <div style={{ fontSize: 13, fontWeight: 600, maxWidth: 200, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{p.Name}</div>\n"
lines[131] = "                      {p.Brand && <div style={{ fontSize: 11, color: 'var(--muted)' }}>{p.Brand}</div>}\n"

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
# Verify
for i, l in enumerate(lines[123:135], 124):
    if l.strip():
        print(f"{i}: {l.rstrip()}")
