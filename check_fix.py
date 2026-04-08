with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[110:120], 111):
    print(f"{i}: {l.rstrip()}")
