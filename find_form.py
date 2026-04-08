with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Find form/modal section
for i, l in enumerate(lines):
    if "IsFeatured" in l or "Tags" in l or "Weight" in l or "form.Name" in l:
        print(f"{i+1}: {l.rstrip()}")
