with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

import re

# Remove all delivery city related code
code = code.replace(
    '\n  const [deliveryCity, setDeliveryCity] = useState(localStorage.getItem("deliveryCity") || "India");\n  const [showCityPicker, setShowCityPicker] = useState(false);\n  const cityRef = useRef(null);',
    ''
)

# Remove cityRef from other useEffect
code = code.replace(
    '\n      if (cityRef.current   && !cityRef.current.contains(e.target))   setShowCityPicker(false);',
    ''
)

# Replace the complex delivery city dropdown with simple static text
old = re.search(r'<div ref=\{cityRef\}.*?</div>\s*</div>', code, re.DOTALL)
if old:
    code = code[:old.start()] + '''<div style={{ display: "flex", flexDirection: "column", padding: "4px 8px" }}>
          <span style={{ fontSize: 11, color: "rgba(255,255,255,.65)" }}>Deliver to</span>
          <span style={{ fontSize: 13, fontWeight: 700, color: "#fff" }}>India</span>
        </div>''' + code[old.end():]
    print("Replaced delivery section")
else:
    print("Pattern not found")

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done!")
