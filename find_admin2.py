import subprocess, os

result = subprocess.run(["docker", "exec", "deemona-frontend", "ls", "/var/www/frontend/assets/"], capture_output=True, text=True)
files = [f for f in result.stdout.strip().split("\n") if f.endswith(".js")]

for fname in files:
    dst = f"C:\\Deemona\\search_{fname}"
    subprocess.run(["docker", "cp", f"deemona-frontend:/var/www/frontend/assets/{fname}", dst], capture_output=True)
    try:
        with open(dst, "rb") as f:
            code = f.read().decode("utf-8", errors="replace")
        if "super_admin" in code or "isAdmin" in code:
            print(f"Found in: {fname}")
            import re
            m = re.search(r'.{30}super_admin.{80}', code)
            if m: print("  Pattern:", m.group())
    except: pass
    finally:
        try: os.remove(dst)
        except: pass
