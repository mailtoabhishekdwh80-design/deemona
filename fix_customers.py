with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "r", encoding="utf-8") as f:
    code = f.read()

import re

count = code.count("LIMIT ? OFFSET ?")
print(f"Found {count} LIMIT ? OFFSET ? patterns")

code = code.replace(
    "LIMIT ? OFFSET ?`,\n    [...params, limit, offset]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,\n    [...params, Number(limit), Number(offset)]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,\n\n  );",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params\n  );"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,\n  );",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params\n  );"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed! Remaining:", code.count("LIMIT ? OFFSET ?"))
