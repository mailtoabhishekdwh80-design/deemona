with open(r"C:\Deemona\Product.js", "rb") as f:
    code = f.read()
non_ascii = sum(1 for b in code if b > 127)
print("Non-ASCII chars:", non_ascii)
