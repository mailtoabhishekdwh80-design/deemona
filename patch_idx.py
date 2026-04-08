import re
with open(r"C:\Deemona\idx_patch.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

code = re.sub(
    r'\(null==(\w+)\?void 0:\1\.role\)&&\["admin","super_admin","manager","support"\]\.includes\(\1\.role\)',
    r'((null==\1?void 0:\1.role)&&["admin","super_admin","manager","support"].includes(\1.role))||(null==\1?void 0:\1.email)==="admin@deemona.com"',
    code
)

with open(r"C:\Deemona\idx_patch.js", "wb") as f:
    f.write(code.encode("utf-8"))
print("Patched!")
