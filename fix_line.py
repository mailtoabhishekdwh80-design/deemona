with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 113 - replace LIMIT ? OFFSET ? with embedded values
lines[112] = "     WHERE ${where.join(' AND ')} ORDER BY ${orderBy} LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n"
# Fix line 114 - add params
lines[113] = "    params\n"
# Fix line 115 - close the execute call
lines[114] = "  );\n"

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "w", encoding="utf-8") as f:
    f.writelines(lines)

# Verify
print("Line 113:", lines[112].rstrip())
print("Line 114:", lines[113].rstrip())
print("Line 115:", lines[114].rstrip())
print("Fixed!")
