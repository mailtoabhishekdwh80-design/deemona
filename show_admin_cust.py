with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\missing.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[188:210], 189):
    print(f"{i}: {l.rstrip()}")
