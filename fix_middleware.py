with open(r"C:\Deemona\Deemona_Backend\deemona-backend\middleware\index.js", "r", encoding="utf-8") as f:
    code = f.read()

code = code.replace(
    "if (req.user?.role !== 'admin') return fail(res, 'Admin access required', 403);",
    "if (!['admin','super_admin','manager','support'].includes(req.user?.role)) return fail(res, 'Admin access required', 403);"
)

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\middleware\index.js", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
