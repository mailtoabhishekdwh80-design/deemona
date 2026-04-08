with open(r"C:\Deemona\idx.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# ONLY fix nav-cat - nothing else
code = code.replace(
    'style:{id:"nav-cat",padding:"0 8px"',
    'id:"nav-cat",style:{padding:"0 8px"'
)

with open(r"C:\Deemona\idx.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Done!")
