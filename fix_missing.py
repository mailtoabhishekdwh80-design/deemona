with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\missing.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

lines[201] = lines[201].replace(
    "LIMIT ? OFFSET ?`,",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n     "
)
lines[202] = "    params\n"

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\missing.js", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
print("Line 202:", lines[201].rstrip())
print("Line 203:", lines[202].rstrip())
