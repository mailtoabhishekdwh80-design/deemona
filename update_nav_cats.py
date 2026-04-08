with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Find and replace the CATEGORIES line
import re
old = re.search(r'const CATEGORIES = \[.*?\];', code, re.DOTALL).group()
new = '''const CATEGORIES = [
  "Electronics","Mobiles","Computers","Cameras","Audio","TVs",
  "Clothing","Footwear","Watches","Bags & Luggage","Jewellery",
  "Books","Home Decor","Home Appliances","Kitchen","Furniture","Garden",
  "Gym Accessories","Sports","Medicines","Beauty","Personal Care",
  "Baby Products","Toys & Games","Groceries","Pet Supplies",
  "Musical Instruments","Automotive","Office Supplies","Stationery"
];'''

code = code.replace(old, new)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done! All 30 categories added to navbar")
