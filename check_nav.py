with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "rb") as f:
    code = f.read().decode("utf-8")

# Check current state of select element
import re
matches = re.findall(r'.{30}select.{100}', code)
for m in matches[:3]:
    print(m)
    print("---")
