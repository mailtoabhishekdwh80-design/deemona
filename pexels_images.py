import subprocess

# Replace with guaranteed working Pexels images - specific product photos
replacements = {
    # Electronics
    "ELC-001": "https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500",
    "ELC-002": "https://images.pexels.com/photos/1092644/pexels-photo-1092644.jpeg?w=500",
    "ELC-003": "https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500",
    "ELC-004": "https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?w=500",
    "ELC-005": "https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=500",
    "ELC-006": "https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?w=500",
    "ELC-007": "https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?w=500",
    "ELC-008": "https://images.pexels.com/photos/3780681/pexels-photo-3780681.jpeg?w=500",
    "ELC-009": "https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=500",
    "ELC-010": "https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?w=500",
    # Clothing
    "CLO-001": "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?w=500",
    "CLO-002": "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?w=500",
    "CLO-003": "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500",
    "CLO-004": "https://images.pexels.com/photos/1240892/pexels-photo-1240892.jpeg?w=500",
    "CLO-005": "https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?w=500",
    "CLO-006": "https://images.pexels.com/photos/991509/pexels-photo-991509.jpeg?w=500",
    "CLO-007": "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?w=500",
    "CLO-008": "https://images.pexels.com/photos/1124468/pexels-photo-1124468.jpeg?w=500",
    "CLO-009": "https://images.pexels.com/photos/2220316/pexels-photo-2220316.jpeg?w=500",
    "CLO-010": "https://images.pexels.com/photos/3621104/pexels-photo-3621104.jpeg?w=500",
    # Books
    "BOK-001": "https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=500",
    "BOK-002": "https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?w=500",
    "BOK-003": "https://images.pexels.com/photos/762687/pexels-photo-762687.jpeg?w=500",
    "BOK-004": "https://images.pexels.com/photos/1130980/pexels-photo-1130980.jpeg?w=500",
    "BOK-005": "https://images.pexels.com/photos/1148399/pexels-photo-1148399.jpeg?w=500",
    "BOK-006": "https://images.pexels.com/photos/694740/pexels-photo-694740.jpeg?w=500",
    "BOK-007": "https://images.pexels.com/photos/590493/pexels-photo-590493.jpeg?w=500",
    "BOK-008": "https://images.pexels.com/photos/261510/pexels-photo-261510.jpeg?w=500",
    "BOK-009": "https://images.pexels.com/photos/1005324/pexels-photo-1005324.jpeg?w=500",
    "BOK-010": "https://images.pexels.com/photos/415071/pexels-photo-415071.jpeg?w=500",
    # Home Decor
    "HOM-001": "https://images.pexels.com/photos/1123262/pexels-photo-1123262.jpeg?w=500",
    "HOM-002": "https://images.pexels.com/photos/1648776/pexels-photo-1648776.jpeg?w=500",
    "HOM-003": "https://images.pexels.com/photos/931177/pexels-photo-931177.jpeg?w=500",
    "HOM-004": "https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?w=500",
    "HOM-005": "https://images.pexels.com/photos/3735633/pexels-photo-3735633.jpeg?w=500",
    "HOM-006": "https://images.pexels.com/photos/276583/pexels-photo-276583.jpeg?w=500",
    "HOM-007": "https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=500",
    "HOM-008": "https://images.pexels.com/photos/1070534/pexels-photo-1070534.jpeg?w=500",
    "HOM-009": "https://images.pexels.com/photos/1090638/pexels-photo-1090638.jpeg?w=500",
    "HOM-010": "https://images.pexels.com/photos/1669754/pexels-photo-1669754.jpeg?w=500",
    # Home Appliances
    "APP-001": "https://images.pexels.com/photos/5591581/pexels-photo-5591581.jpeg?w=500",
    "APP-002": "https://images.pexels.com/photos/3735218/pexels-photo-3735218.jpeg?w=500",
    "APP-003": "https://images.pexels.com/photos/4108715/pexels-photo-4108715.jpeg?w=500",
    "APP-004": "https://images.pexels.com/photos/4158/apple-iphone-smartphone-desk.jpeg?w=500",
    "APP-005": "https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500",
    "APP-006": "https://images.pexels.com/photos/3184291/pexels-photo-3184291.jpeg?w=500",
    "APP-007": "https://images.pexels.com/photos/1643383/pexels-photo-1643383.jpeg?w=500",
    "APP-008": "https://images.pexels.com/photos/2284166/pexels-photo-2284166.jpeg?w=500",
    "APP-009": "https://images.pexels.com/photos/416528/pexels-photo-416528.jpeg?w=500",
    "APP-010": "https://images.pexels.com/photos/4107278/pexels-photo-4107278.jpeg?w=500",
    # Gym
    "GYM-001": "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg?w=500",
    "GYM-002": "https://images.pexels.com/photos/1954524/pexels-photo-1954524.jpeg?w=500",
    "GYM-003": "https://images.pexels.com/photos/4056723/pexels-photo-4056723.jpeg?w=500",
    "GYM-004": "https://images.pexels.com/photos/4162449/pexels-photo-4162449.jpeg?w=500",
    "GYM-005": "https://images.pexels.com/photos/3735633/pexels-photo-3735633.jpeg?w=500",
    "GYM-006": "https://images.pexels.com/photos/416778/pexels-photo-416778.jpeg?w=500",
    "GYM-007": "https://images.pexels.com/photos/3621104/pexels-photo-3621104.jpeg?w=500",
    "GYM-008": "https://images.pexels.com/photos/4164761/pexels-photo-4164761.jpeg?w=500",
    # Sports
    "SPT-001": "https://images.pexels.com/photos/1661950/pexels-photo-1661950.jpeg?w=500",
    "SPT-002": "https://images.pexels.com/photos/3659681/pexels-photo-3659681.jpeg?w=500",
    "SPT-003": "https://images.pexels.com/photos/3660204/pexels-photo-3660204.jpeg?w=500",
    "SPT-004": "https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg?w=500",
    "SPT-005": "https://images.pexels.com/photos/2168292/pexels-photo-2168292.jpeg?w=500",
    "SPT-006": "https://images.pexels.com/photos/1150601/pexels-photo-1150601.jpeg?w=500",
    "SPT-007": "https://images.pexels.com/photos/2400801/pexels-photo-2400801.jpeg?w=500",
    "SPT-008": "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=500",
    # Medicines
    "MED-001": "https://images.pexels.com/photos/3683074/pexels-photo-3683074.jpeg?w=500",
    "MED-002": "https://images.pexels.com/photos/139398/thermometer-medication-tablets-pills-139398.jpeg?w=500",
    "MED-003": "https://images.pexels.com/photos/3616840/pexels-photo-3616840.jpeg?w=500",
    "MED-004": "https://images.pexels.com/photos/3683053/pexels-photo-3683053.jpeg?w=500",
    "MED-005": "https://images.pexels.com/photos/4047186/pexels-photo-4047186.jpeg?w=500",
    "MED-006": "https://images.pexels.com/photos/3683098/pexels-photo-3683098.jpeg?w=500",
    "MED-007": "https://images.pexels.com/photos/1170979/pexels-photo-1170979.jpeg?w=500",
    "MED-008": "https://images.pexels.com/photos/3683056/pexels-photo-3683056.jpeg?w=500",
}

sql = "USE deemona;\n"
for sku, url in replacements.items():
    sql += f"UPDATE Products SET ImageURLs='[\"{url}\"]' WHERE SKU='{sku}';\n"

result = subprocess.run(
    ["docker", "exec", "-i", "deemona-mysql", "mysql", "-u", "root", "-pDeemonaLocal123", "deemona"],
    input=sql, capture_output=True, text=True
)
print("Done!", "OK" if result.returncode == 0 else result.stderr[:100])
