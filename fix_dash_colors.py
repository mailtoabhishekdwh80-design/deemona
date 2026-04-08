with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix sidebar - darker background with better contrast
code = code.replace('background: "#0f172a"', 'background: "#111827"')
code = code.replace('color: "#94a3b8"', 'color: "#d1d5db"')

# Fix stat card text contrast
code = code.replace('color: "#888"', 'color: "#374151"')
code = code.replace('color: "#111"', 'color: "#030712"')

# Fix table header
code = code.replace('"color: \\"#888\\""', '"color: \\"#374151\\""')

# Fix muted text
code = code.replace('color: "#94a3b8"', 'color: "#6b7280"')

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "w", encoding="utf-8") as f:
    f.write(code)
print("Done!")
