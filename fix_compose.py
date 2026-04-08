with open(r"C:\Deemona\docker-compose.yml", "r", encoding="utf-8") as f:
    content = f.read()

# Fix uploads mount in nginx to match where images are copied
content = content.replace(
    "      - uploads_data:/var/www/uploads:ro",
    "      - uploads_data:/var/www/uploads/products:ro"
)

with open(r"C:\Deemona\docker-compose.yml", "w", encoding="utf-8", newline="\n") as f:
    f.write(content)
print("docker-compose.yml fixed!")
