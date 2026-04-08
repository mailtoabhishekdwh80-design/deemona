with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find and replace the entire broken table row
import re

old = re.search(r'<tr key=\{p\.ProductID\}.*?</tr>', code, re.DOTALL)
if old:
    print("Found row at:", old.start(), "-", old.end())
    print("Content:", old.group()[:200])
else:
    print("Not found")
