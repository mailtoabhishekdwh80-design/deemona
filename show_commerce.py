with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i, l in enumerate(lines[99:115], 100):
    print(f"{i}: {l.rstrip()}")
