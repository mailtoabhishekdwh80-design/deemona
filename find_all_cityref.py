with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re
matches = re.findall(r'.{50}cityRef.{50}', code)
for m in matches:
    print(repr(m))
    print("---")
