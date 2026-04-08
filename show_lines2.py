with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\customers.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[10:30], 11):
    print(f"{i}: {l.rstrip()}")
