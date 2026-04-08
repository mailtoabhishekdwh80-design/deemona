import subprocess
import os

assets_dir = "/var/www/frontend/assets"

# Get list of JS files
result = subprocess.run(["docker", "exec", "deemona-frontend", "ls", assets_dir], capture_output=True, text=True)
js_files = [f for f in result.stdout.strip().split("\n") if f.endswith(".js")]
print("Files to patch:", js_files)

for filename in js_files:
    # Copy from container
    src = f"deemona-frontend:{assets_dir}/{filename}"
    dst = f"C:\\Deemona\\assets_patch\\{filename}"
    os.makedirs("C:\\Deemona\\assets_patch", exist_ok=True)
    subprocess.run(["docker", "cp", src, dst])
    
    with open(dst, "rb") as f:
        code = f.read().decode("utf-8", errors="replace")
    
    original = code
    
    # Fix nav-cat id placement
    code = code.replace(
        'style:{id:"nav-cat",padding:"0 8px"',
        'id:"nav-cat",style:{padding:"0 8px"'
    )
    
    # Remove all non-ASCII
    clean = "".join(c if ord(c) < 128 else "" for c in code)
    
    if clean != original:
        with open(dst, "wb") as f:
            f.write(clean.encode("utf-8"))
        subprocess.run(["docker", "cp", dst, src])
        print(f"Patched: {filename}")
    else:
        print(f"No changes: {filename}")

print("All done!")
