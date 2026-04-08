with open(r"C:\Deemona\Deemona_Backend\deemona-backend\server.js", "r", encoding="utf-8") as f:
    code = f.read()

# Add inventory require after other requires
code = code.replace(
    "const paymentRoutes   = require('./routes/payments');",
    "const paymentRoutes   = require('./routes/payments');\nconst inventoryRoutes = require('./routes/inventory');"
)

# Mount BEFORE catalogue routes so /api/inventory is handled by new file
code = code.replace(
    "app.use('/api',           catalogueRoutes);",
    "app.use('/api/inventory', inventoryRoutes);  // new full inventory system\napp.use('/api',           catalogueRoutes);"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\server.js", "w", encoding="utf-8") as f:
    f.write(code)

print("server.js updated!")
