with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

lines[113] = "  ok(res, { orders:rows, pagination:{ total:countRow.total, page, limit, pages:Math.ceil(countRow.total/limit) } });\n"
lines[114] = "}));\n\n"

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "w", encoding="utf-8") as f:
    f.writelines(lines)
print("Fixed!")
