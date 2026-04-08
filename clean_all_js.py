import os, subprocess

assets = "/var/www/frontend/assets"
result = subprocess.run(["docker", "exec", "deemona-frontend", "ls", assets], capture_output=True, text=True)
files = [f for f in result.stdout.strip().split("\n") if f.endswith(".js")]

for fname in files:
    local = f"C:\\Deemona\\patch_{fname}"
    subprocess.run(["docker", "cp", f"deemona-frontend:{assets}/{fname}", local])
    
    with open(local, "rb") as f:
        code = f.read().decode("utf-8", errors="replace")
    
    clean = "".join(c if ord(c) < 128 else "" for c in code)
    
    if clean != code:
        with open(local, "wb") as f:
            f.write(clean.encode("utf-8"))
        subprocess.run(["docker", "cp", local, f"deemona-frontend:{assets}/{fname}"])
        print(f"Cleaned: {fname}")
    
    os.remove(local)

print("All done!")
