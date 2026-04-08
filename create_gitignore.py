content = """node_modules/
.env
.env.local
dist/
*.log
product_images/
__pycache__/
*.pyc
.DS_Store
"""
with open(r"C:\Deemona\.gitignore", "w") as f:
    f.write(content)
print("Created .gitignore!")
