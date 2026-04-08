with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\catalogue.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Find the GET /products route
for i, l in enumerate(lines):
    if "router.get('/products'" in l or "router.get(\"/products\"" in l:
        print(f"Line {i+1}: {l.strip()}")
        # Print next 30 lines
        for j in range(i+1, min(i+35, len(lines))):
            print(f"Line {j+1}: {lines[j].rstrip()}")
        break
