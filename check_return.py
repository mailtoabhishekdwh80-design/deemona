with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Show return statement area
for i, l in enumerate(lines):
    if "return (" in l:
        print(f"Return at line {i+1}")
        for j in range(i, min(i+10, len(lines))):
            print(f"{j+1}: {lines[j].rstrip()}")
        break
