with open(r"C:\Deemona\built.js", "rb") as f:
    code = f.read().decode("utf-8", errors="replace")

# Fix specific corrupted sequences
fixes = {
    'Electronics:"\u00e2\u009a\u00a1"': 'Electronics:"⚡"',
    '"India \u00f0\u009f\u0094\u008d"': '"India"',
    '"India \ufffd\u008d"': '"India"',
    '"\u00e2\u008c\u0095"': '"Go"',
    '"\u00e2\u0082\u00b9"': '"Rs."',
}

# Simply remove all non-ASCII from icon objects
import re

# Fix CAT_ICONS - replace emoji values with text
code = re.sub(r'Electronics:"[^"]*"', 'Electronics:"Electronics"', code)
code = re.sub(r'Clothing:"[^"]*"', 'Clothing:"Clothing"', code)  
code = re.sub(r'Books:"[^"]*"', 'Books:"Books"', code)

# Fix India pin emoji
code = re.sub(r'India [^\u0000-\u007F"]+', 'India', code)

# Fix search button emoji  
code = re.sub(r'children:"[^\u0000-\u007F]+"', 'children:"Go"', code)

# Fix rupee symbol - keep it as text
code = code.replace('\u00e2\u0082\u00b9', 'Rs.')

# Remove all remaining non-ASCII
result = ""
for ch in code:
    if ord(ch) <= 127:
        result += ch
    else:
        result += ""

with open(r"C:\Deemona\built.js", "wb") as f:
    f.write(result.encode("utf-8"))

remaining = sum(1 for c in result if ord(c) > 127)
print("Special chars remaining:", remaining)
print("Done!")
