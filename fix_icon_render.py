with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Replace icon text rendering with img tag
code = code.replace(
    '<div style={{ fontSize: 36, marginBottom: 10 }}>{c.icon}</div>',
    '<div style={{ width: 80, height: 80, marginBottom: 10, borderRadius: 12, overflow: "hidden" }}><img src={c.icon} alt={c.name} style={{ width: "100%", height: "100%", objectFit: "cover" }} onError={e => e.target.style.display="none"}/></div>'
)

code = code.replace(
    '<div style={{ fontSize: 32, marginBottom: 10 }}>{v.icon}</div>',
    '<div style={{ width: 70, height: 70, marginBottom: 10, borderRadius: 12, overflow: "hidden" }}><img src={v.icon} alt={v.name} style={{ width: "100%", height: "100%", objectFit: "cover" }} onError={e => e.target.style.display="none"}/></div>'
)

# Remove non-ASCII
clean = "".join(c if ord(c) < 128 else "" for c in code)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "w", encoding="utf-8") as f:
    f.write(clean)

print("Done!")
