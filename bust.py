import subprocess

# Get current index.html
result = subprocess.run(['docker', 'exec', 'deemona-frontend', 'cat', '/var/www/frontend/index.html'], capture_output=True, text=True)
html = result.stdout
print("Current index.html:")
print(html)

# Add cache bust
html = html.replace('index-MLbvnL90.js"', 'index-MLbvnL90.js?v=2"')
html = html.replace("index-MLbvnL90.js'", "index-MLbvnL90.js?v=2'")

# Write back
with open(r"C:\Deemona\index.html", "w", encoding="utf-8") as f:
    f.write(html)
print("Done! New html saved")
