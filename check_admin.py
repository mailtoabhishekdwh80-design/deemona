import os

# Read the Inventory.jsx content and write directly
dst = r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Inventory.jsx"

# Check if file exists already
if os.path.exists(dst):
    print("File already exists at:", dst)
    print("Size:", os.path.getsize(dst), "bytes")
else:
    print("File not found at:", dst)
    
# List what IS in admin folder
admin_dir = r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin"
if os.path.exists(admin_dir):
    print("Files in admin folder:")
    for f in os.listdir(admin_dir):
        print(" -", f)
else:
    print("Admin folder not found!")
