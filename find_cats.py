with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Find the categories array
match = re.search(r"const CATEGORIES\s*=\s*\[[^\]]+\]", code, re.DOTALL)
if match:
    print("Found:", match.group()[:300])
else:
    # Show lines 5-20
    for i, l in enumerate(code.split("\n")[4:25], 5):
        print(f"{i}: {l[:120]}")
