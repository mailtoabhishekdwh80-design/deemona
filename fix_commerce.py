with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Fix all LIMIT ? OFFSET ? patterns - replace with embedded values
def fix_limit(m):
    return m.group().replace(
        "LIMIT ? OFFSET ?`,",
        "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    "
    ).replace(
        "[...params, limit, offset]",
        "params"
    ).replace(
        "[...params, Number(limit), Number(offset)]",
        "params"
    )

# Find and fix all execute calls with LIMIT ? OFFSET ?
count = code.count("LIMIT ? OFFSET ?")
print(f"Found {count} LIMIT ? OFFSET ? patterns")

# Replace all occurrences
code = code.replace(
    "LIMIT ? OFFSET ?`,\n    [...params, limit, offset]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,\n    [...params, Number(limit), Number(offset)]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,[...params,limit,offset]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,params"
)

# Also check missing params entirely
code = code.replace(
    "LIMIT ? OFFSET ?`,\n\n  );",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params\n  );"
)
code = code.replace(
    "LIMIT ? OFFSET ?`,\n  );",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params\n  );"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
remaining = code.count("LIMIT ? OFFSET ?")
print(f"Remaining: {remaining}")
