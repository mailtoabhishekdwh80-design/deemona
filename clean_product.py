with open(r"C:\Deemona\Product.js", "rb") as f:
    code = f.read()

# Clean all non-ASCII
clean = bytes([b for b in code if b < 128])

with open(r"C:\Deemona\Product.js", "wb") as f:
    f.write(clean)

print("Cleaned! Non-ASCII remaining:", sum(1 for b in clean if b > 127))
