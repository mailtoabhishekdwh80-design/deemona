import re

with open(r"C:\Deemona\built.js", "rb") as f:
    code = f.read()

# Find all non-ASCII sequences
bad = []
i = 0
while i < len(code):
    if code[i] > 127:
        seq = code[i:i+8]
        ctx = code[max(0,i-20):i+20].decode("utf-8", errors="replace")
        bad.append(ctx)
        i += 4
    else:
        i += 1

# Show unique contexts
seen = set()
for b in bad[:30]:
    if b not in seen:
        seen.add(b)
        print(repr(b))
