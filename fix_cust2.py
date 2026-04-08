with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Fix line 38
lines[37] = lines[37].replace(
    "LIMIT ? OFFSET ?`, [...params, limit, offset]",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`, params"
)

# Fix lines 138-139
lines[137] = lines[137].replace(
    "LIMIT ? OFFSET ?`,",
    "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n      []"
)
# Remove the params line that follows
if "[id, limit, offset]" in lines[138]:
    lines[138] = "\n"

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "w", encoding="utf-8") as f:
    f.writelines(lines)

print("Fixed!")
print("Line 38:", lines[37].rstrip())
print("Line 139:", lines[137].rstrip())
