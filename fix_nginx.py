with open(r"C:\Deemona\Deemona_Backend\deemona-backend\nginx\nginx.conf", "r") as f:
    conf = f.read()

# Add uploads location if not present
if "/uploads/" not in conf:
    conf = conf.replace(
        "location /api/ {",
        """location /uploads/ {
        alias /app/public/uploads/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    location /api/ {"""
    )
    with open(r"C:\Deemona\Deemona_Backend\deemona-backend\nginx\nginx.conf", "w") as f:
        f.write(conf)
    print("Added /uploads/ location to nginx.conf")
else:
    print("uploads already configured")
