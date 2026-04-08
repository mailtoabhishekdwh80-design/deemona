with open(r"C:\Deemona\index-new.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Apply nav-cat fix
code = code.replace(
    'style:{id:"nav-cat",padding:"0 8px"',
    'id:"nav-cat",style:{padding:"0 8px"'
)

# Clean non-ASCII
clean = "".join(c if ord(c) < 128 else "" for c in code)

with open(r"C:\Deemona\index-new.js", "wb") as f:
    f.write(clean.encode("utf-8"))

print("Done! nav-cat fixed:", 'id:"nav-cat",style' in clean)
