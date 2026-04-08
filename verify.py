import subprocess
result = subprocess.run(['docker', 'exec', 'deemona-frontend', 'grep', '-c', 'nav-cat', '/var/www/frontend/assets/index-MLbvnL90.js'], capture_output=True, text=True)
print("nav-cat count in container:", result.stdout.strip())
