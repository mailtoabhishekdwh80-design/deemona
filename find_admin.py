with open(r"C:\Deemona\idx_admin.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

import re

# Find isAdmin check
match = re.search(r'.{50}isAdmin.{100}', code)
if match:
    print("isAdmin pattern:", match.group())
else:
    print("isAdmin not found")
    
# Find role check  
match2 = re.search(r'.{30}super_admin.{50}', code)
if match2:
    print("role pattern:", match2.group())
