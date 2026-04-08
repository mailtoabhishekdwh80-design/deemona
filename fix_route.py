with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Insert the missing router.get line after line 115 (index 115)
lines.insert(116, "router.get('/orders/:id', authenticate, [param('id').isInt()], validate, wrap(async (req,res) => {\n")

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\routes\commerce.js", "w", encoding="utf-8") as f:
    f.writelines(lines)
print("Fixed!")
