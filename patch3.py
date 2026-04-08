with open(r"C:\Deemona\index-MLbvnL90.js", "rb") as f:
    code = f.read().decode("utf-8")

# Use localStorage instead of getElementById
code = code.replace(
    'document.getElementById("nav-cat")',
    'document.getElementById("nav-cat")||{value:localStorage.getItem("navCat")||"All"}'
)

# Also store value on change - find the select onChange
# Add localStorage.setItem when select changes
code = code.replace(
    'id:"nav-cat",style:{padding:"0 8px"',
    'id:"nav-cat",onChange:e=>{localStorage.setItem("navCat",e.target.value)},style:{padding:"0 8px"'
)

with open(r"C:\Deemona\index-MLbvnL90.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("localStorage approach applied!")
print("nav-cat count:", code.count("nav-cat"))
