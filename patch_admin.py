with open(r"C:\Deemona\idx_fix.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Fix isAdmin to also check email
code = code.replace(
    '(null==o?void 0:o.role)&&["admin","super_admin","manager","support"].includes(o.role)',
    '((null==o?void 0:o.role)&&["admin","super_admin","manager","support"].includes(o.role))||(null==o?void 0:o.email)==="admin@deemona.com"'
)

with open(r"C:\Deemona\idx_fix.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Fixed!")
