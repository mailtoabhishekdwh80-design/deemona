with open(r"C:\Deemona\idx2.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re

# Replace deliveryCity with hardcoded "India"
code = re.sub(r'\bdeliveryCity\b', '"India"', code)
code = re.sub(r'\bsetDeliveryCity\b', '(()=>{})', code)
code = re.sub(r'\bshowCityPicker\b', 'false', code)
code = re.sub(r'\bsetShowCityPicker\b', '(()=>{})', code)

with open(r"C:\Deemona\idx2.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Fixed!")
