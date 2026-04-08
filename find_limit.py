with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines):
    if "LIMIT" in l or "OFFSET" in l or "limit" in l.lower() and "offset" in l.lower():
        print(f"{i+1}: {l.rstrip()}")
