with open(r"C:\Deemona\Product.js", "rb") as f:
    code = f.read()

# Show non-ASCII contexts
import re
decoded = code.decode("utf-8", errors="replace")
matches = re.findall(r'.{20}\ufffd.{20}', decoded)
for m in matches[:10]:
    print(repr(m))
