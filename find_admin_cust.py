with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "r", encoding="utf-8") as f:
    code = f.read()

# Find admin/customers route
idx = code.find("admin/customers")
if idx == -1:
    idx = code.find("admin")
print(code[idx:idx+600])
