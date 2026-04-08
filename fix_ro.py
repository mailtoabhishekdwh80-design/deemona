with open(r"C:\Deemona\docker-compose.yml", "r", encoding="utf-8") as f:
    content = f.read()

# Remove :ro from uploads mount in nginx
content = content.replace(
    "      - uploads_data:/var/www/uploads:ro",
    "      - uploads_data:/var/www/uploads"
)

with open(r"C:\Deemona\docker-compose.yml", "w", encoding="utf-8", newline="\n") as f:
    f.write(content)
print("Fixed! :ro removed from uploads mount")
