with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re

# Find deliveryCity usage
matches = re.findall(r'.{80}deliveryCity.{80}', code)
for m in matches[:5]:
    print(repr(m))
    print("---")
