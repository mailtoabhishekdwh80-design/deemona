with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

code = code.replace(
    'const CATEGORIES = ["Electronics","Clothing","Books","Home Decor","Home Appliances","Gym Accessories","Spo',
    'const ALL_CATS = ["Electronics","Mobiles","Computers","Cameras","Audio","TVs","Clothing","Footwear","Watches","Bags & Luggage","Books","Home Decor","Home Appliances","Kitchen","Furniture","Gym Accessories","Sports","Medicines","Beauty","Personal Care","Baby Products","Toys & Games","Groceries","Pet Supplies","Musical Instruments","Garden","Automotive","Office Supplies","Jewellery","Stationery"];\nconst CATEGORIES = ["Electronics","Mobiles","Clothing","Books","Home Decor","Home Appliances","Gym Accessories","Spo'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done")
