with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Replace cityRef with null since it's not defined
code = code.replace('ref:cityRef,', 'ref:null,')

with open(r"C:\Deemona\idx2.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Fixed! cityRef remaining:", code.count("cityRef"))
