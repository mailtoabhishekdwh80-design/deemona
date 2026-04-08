# Read the fixed file and add a cache-bust comment at the start
with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Add version comment to force browser to reload
code = "/* v2 */" + code

with open(r"C:\Deemona\idx2.js", "wb") as f:
    f.write(code.encode("utf-8"))
print("Done!")
