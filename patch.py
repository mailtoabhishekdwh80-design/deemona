import re

with open(r"C:\Deemona\index-MLbvnL90.js", "rb") as f:
    code = f.read().decode("utf-8")

# Patch search navigation
old = "l(`/search?q=${encodeURIComponent(p.trim())}`)"
new = 'l(`/search?q=${encodeURIComponent(p.trim())}${(()=>{const s=document.getElementById("nav-cat");return s&&s.value!=="All"?"&category="+encodeURIComponent(s.value):""})()}`)'
code = code.replace(old, new)

# Add id to select
old2 = '{padding:"0 8px",background:"#f3f3f3",border:"none",fontSize:12,color:"#555",cursor:"pointer",borderRight:"1px solid #ccc",outline:"none",height:40}'
new2 = '{id:"nav-cat",padding:"0 8px",background:"#f3f3f3",border:"none",fontSize:12,color:"#555",cursor:"pointer",borderRight:"1px solid #ccc",outline:"none",height:40}'
code = code.replace(old2, new2)

with open(r"C:\Deemona\index-MLbvnL90.js", "wb") as f:
    f.write(code.encode("utf-8"))

print("Done! Old patched:", old in code, "New patched:", new in code)
