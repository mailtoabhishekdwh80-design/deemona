with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "r", encoding="utf-8") as f:
    code = f.read()

# Fix missing params in products query
code = code.replace(
    "     WHERE ${where.join(' AND ')} ORDER BY ${orderBy} LIMIT ? OFFSET ?`,\n\n  );",
    "     WHERE ${where.join(' AND ')} ORDER BY ${orderBy} LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params\n  );"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
