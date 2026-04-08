with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Find the await error - search for await outside async
for i, l in enumerate(lines):
    if "await" in l and "async" not in l:
        # Check if previous lines have async context
        context = "".join(lines[max(0,i-3):i+2])
        if "async" not in context:
            print(f"Line {i+1}: {l.rstrip()}")
