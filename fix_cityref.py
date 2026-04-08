with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Move cityRef declaration before the useEffects - add it with other refs
code = code.replace(
    'const searchRef = useRef(null);\n  const userRef   = useRef(null);',
    'const searchRef = useRef(null);\n  const userRef   = useRef(null);\n  const cityRef   = useRef(null);'
)

# Remove the duplicate cityRef from useState section
code = code.replace(
    'const [showCityPicker, setShowCityPicker] = useState(false);\n  const cityRef = useRef(null);',
    'const [showCityPicker, setShowCityPicker] = useState(false);'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")

# Verify
import re
refs = re.findall(r'const cityRef', code)
print("cityRef declarations:", len(refs))
