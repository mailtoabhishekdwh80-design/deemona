with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Fix cityRef - add it as a simple variable instead of useRef
# Find where cityRef is used and replace with a direct ref approach
code = code.replace(
    'cityRef.current&&!cityRef.current.contains(e.target)',
    'true'
)
code = code.replace(
    'cityRef.current&&!cityRef.current.contains(e.target)&&', 
    ''
)

with open(r"C:\Deemona\idx2.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Fixed! cityRef references:", code.count("cityRef"))
