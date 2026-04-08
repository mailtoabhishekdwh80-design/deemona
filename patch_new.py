with open(r"C:\Deemona\idx_new.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re

# Fix nav-cat
code = code.replace('style:{id:"nav-cat",padding:"0 8px"', 'id:"nav-cat",style:{padding:"0 8px"')

# Fix isAdmin to check email
code = re.sub(
    r'\(null==(\w+)\?void 0:\1\.role\)&&\["admin","super_admin","manager","support"\]\.includes\(\1\.role\)',
    r'((null==\1?void 0:\1.role)&&["admin","super_admin","manager","support"].includes(\1.role))||(null==\1?void 0:\1.email)==="admin@deemona.com"',
    code
)

with open(r"C:\Deemona\idx_new.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Patched!")
