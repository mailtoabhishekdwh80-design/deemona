with open(r"C:\Deemona\built.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Fix: move id out of style into direct prop
code = code.replace(
    'style:{id:"nav-cat",padding:"0 8px"',
    'id:"nav-cat",style:{padding:"0 8px"'
)

print("Fixed:", 'id:"nav-cat",style:{padding:"0 8px"' in code)

with open(r"C:\Deemona\built.js", "wb") as f:
    f.write(code.encode("utf-8"))
