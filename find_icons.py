with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Replace CAT_ICONS with real image URLs
old_icons = re.search(r"const CAT_ICONS\s*=\s*\{[^}]+\}", code)
if old_icons:
    print("Found CAT_ICONS:", old_icons.group()[:100])
else:
    print("CAT_ICONS not found - searching for alternative...")
    # Show lines with category icons
    for i, l in enumerate(code.split("\n")):
        if "Electronics" in l and ("icon" in l.lower() or "emoji" in l.lower() or "Power" in l or "icon" in l):
            print(f"Line {i+1}: {l[:120]}")
