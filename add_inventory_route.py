with open(r"C:\Deemona\Deemona_Backend\deemona-backend\server.js", "r", encoding="utf-8") as f:
    code = f.read()

# Add inventory require
code = code.replace(
    "const paymentRoutes   = require('./routes/payments');",
    "const paymentRoutes   = require('./routes/payments');\nconst inventoryRoutes = require('./routes/inventory');"
)

# Mount BEFORE catalogueRoutes so /api/inventory is handled by new file
code = code.replace(
    "app.use('/api',           catalogueRoutes);",
    "app.use('/api/inventory', inventoryRoutes);\napp.use('/api',           catalogueRoutes);"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\server.js", "w", encoding="utf-8") as f:
    f.write(code)

print("Done! Checking...")
# Verify
with open(r"C:\Deemona\Deemona_Backend\deemona-backend\server.js", "r") as f:
    content = f.read()
print("inventoryRoutes found:", "inventoryRoutes" in content)
print("app.use inventory found:", "app.use('/api/inventory'" in content)
