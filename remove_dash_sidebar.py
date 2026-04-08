with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Remove sideOpen state
code = code.replace('  const [sideOpen, setSideOpen] = useState(true);\n', '')

# Find the return block and extract just the main content (remove the outer div+aside)
# Pattern: return ( <div style={{display:"flex"...}}> <aside>...</aside> <main>...</main> </div> )
# We want to keep only what's inside <main>

# Find start of aside
aside_start = code.find('<aside style=')
aside_end = code.find('</aside>') + len('</aside>')

# Find main start and end
main_start = code.find('<main style=', aside_end)
main_tag_end = code.find('>', main_start) + 1

# Find closing </main>
main_close = code.rfind('</main>')
main_content = code[main_tag_end:main_close]

# Find the outer return div
outer_div_start = code.find('<div style={{display:"flex",minHeight:"100vh"')
outer_div_end = code.rfind('</div>') + len('</div>')

# Replace entire outer structure with just main content wrapped in a simple div
new_main = '<div style={{background:"#0f172a",minHeight:"100vh",fontFamily:"system-ui,-apple-system,sans-serif",color:"#e8eaf0"}}>' + main_content + '</div>'

code = code[:outer_div_start] + new_main + code[outer_div_end:]

# Remove setSideOpen references
code = re.sub(r'setSideOpen\([^)]*\);?\s*', '', code)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Dashboard.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done! Sidebar removed from Dashboard")
