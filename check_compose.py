with open(r"C:\Deemona\docker-compose.yml", "r", encoding="utf-8") as f:
    content = f.read()

print("Current nginx volumes section:")
import re
match = re.search(r'nginx:.*?networks:', content, re.DOTALL)
if match:
    print(match.group()[:500])
