import subprocess, os

# Find Dashboard file
result = subprocess.run(["docker", "exec", "deemona-frontend", "ls", "/var/www/frontend/assets/"], capture_output=True, text=True)
files = [f for f in result.stdout.strip().split("\n") if f.endswith(".js")]

for fname in files:
    dst = f"C:\\Deemona\\dash_{fname}"
    subprocess.run(["docker", "cp", f"deemona-frontend:/var/www/frontend/assets/{fname}", dst], capture_output=True)
    try:
        with open(dst, "rb") as f:
            code = f.read().decode("utf-8", errors="replace")
        if "Dashboard" in code and "Total Revenue" in code:
            print(f"Found Dashboard in: {fname}")
    except: pass
    finally:
        try: os.remove(dst)
        except: pass
