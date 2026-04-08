with open(r"C:\Deemona\built.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re
# Find the search navigation code
matches = re.findall(r'.{100}search.{100}', code)
for m in matches[:5]:
    print(m)
    print("---")
