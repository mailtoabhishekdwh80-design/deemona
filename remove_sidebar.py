with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Find the return( opening
ret_idx = code.rfind("return (")
ret_content = code[ret_idx:]

# Find <aside and its closing </aside>
aside_start = ret_content.find("<aside ")
# Count divs to find matching closing tag
depth = 0
aside_end = aside_start
for i in range(aside_start, len(ret_content)):
    if ret_content[i:i+6] == "<aside":
        depth += 1
    elif ret_content[i:i+8] == "</aside>":
        depth -= 1
        if depth == 0:
            aside_end = i + 8
            break

print("Found aside from", aside_start, "to", aside_end)
print("Aside preview:", ret_content[aside_start:aside_start+100])

# Remove aside from return content
new_ret = ret_content[:aside_start] + ret_content[aside_end:]

# Also replace outer flex div with simple div
new_ret = new_ret.replace(
    'display:"flex",minHeight:"100vh",background:C.bg,fontFamily:"system-ui,-apple-system,sans-serif",color:C.text',
    'background:C.bg,fontFamily:"system-ui,-apple-system,sans-serif",color:C.text'
)

code = code[:ret_idx] + new_ret

# Remove sideOpen state
code = re.sub(r'\s*const \[sideOpen, setSideOpen\] = useState\(true\);', '', code)
code = re.sub(r'setSideOpen\(!sideOpen\)', 'void 0', code)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Sidebar removed from Dashboard!")
