conf = """worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    sendfile      on;
    keepalive_timeout 65;
    gzip on;
    gzip_types application/json text/plain application/javascript text/css image/jpeg image/png image/webp;

    upstream deemona_api {
        server deemona-api:3000;
        keepalive 32;
    }

    server {
        listen 80;
        server_name localhost;
        client_max_body_size 20m;

        location = /api/health {
            proxy_pass http://deemona_api;
            proxy_http_version 1.1;
            proxy_set_header Connection "";
            access_log off;
        }

        location /uploads/ {
            proxy_pass http://deemona_api/uploads/;
            proxy_http_version 1.1;
            proxy_set_header Host $host;
            expires 30d;
            add_header Cache-Control "public, immutable";
        }

        location /api/ {
            proxy_pass http://deemona_api;
            proxy_http_version 1.1;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header Connection "";
            proxy_read_timeout 60s;
        }

        location / {
            root /var/www/frontend;
            index index.html;
            try_files $uri $uri/ /index.html;
        }
    }
}
"""

with open(r"C:\Deemona\Deemona_Backend\deemona-backend\nginx\nginx.conf", "w", encoding="utf-8", newline="\n") as f:
    f.write(conf)
print("Done!")
