import os

routes_dir = r"C:\Deemona\Deemona_Backend\deemona-backend\routes"
fixed_files = []

for fname in os.listdir(routes_dir):
    if not fname.endswith(".js"):
        continue
    fpath = os.path.join(routes_dir, fname)
    with open(fpath, "r", encoding="utf-8") as f:
        code = f.read()
    
    original = code
    
    # Fix all LIMIT ? OFFSET ? with params array
    code = code.replace(
        "LIMIT ? OFFSET ?`,\n    [...params, limit, offset]",
        "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
    )
    code = code.replace(
        "LIMIT ? OFFSET ?`,\n    [...params, Number(limit), Number(offset)]",
        "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,\n    params"
    )
    code = code.replace(
        "LIMIT ? OFFSET ?`, [...params, limit, offset]",
        "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`, params"
    )
    code = code.replace(
        "LIMIT ? OFFSET ?`,[...params,limit,offset]",
        "LIMIT ${Number(limit)} OFFSET ${Number(offset)}`,params"
    )
    
    if code != original:
        with open(fpath, "w", encoding="utf-8") as f:
            f.write(code)
        fixed_files.append(fname)
        print(f"Fixed: {fname}")

print(f"\nTotal fixed: {len(fixed_files)}")
