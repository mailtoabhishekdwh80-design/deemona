with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "r", encoding="utf-8") as f:
    lines = f.readlines()

# Find the {!compact && ( line
for i, l in enumerate(lines):
    if "{!compact && (" in l:
        compact_idx = i
        break

print(f"Found compact block at line {compact_idx+1}")

# Replace from compact_idx to end of function with clean version
new_end = [
    "          {!compact && (\n",
    "            <button onClick={handleAddCart} disabled={!inStock || adding}\n",
    "              style={{\n",
    "                width: '100%', marginTop: 8, padding: '8px 0', borderRadius: 20,\n",
    "                background: inStock ? 'linear-gradient(to bottom,#f7dfa5,#f0c14b)' : '#e8e8e8',\n",
    "                border: inStock ? '1px solid #a88734' : '1px solid #ddd',\n",
    "                color: inStock ? '#111' : '#888',\n",
    "                fontSize: 13, fontWeight: 500, cursor: inStock ? 'pointer' : 'not-allowed',\n",
    "                transition: 'all .12s',\n",
    "              }}\n",
    "              onMouseEnter={e => { if (inStock) e.currentTarget.style.background='linear-gradient(to bottom,#f5d78e,#eeb933)'; }}\n",
    "              onMouseLeave={e => { if (inStock) e.currentTarget.style.background='linear-gradient(to bottom,#f7dfa5,#f0c14b)'; }}\n",
    "            >\n",
    "              {adding ? 'Adding...' : inStock ? 'Add to Cart' : 'Unavailable'}\n",
    "            </button>\n",
    "          )}\n",
    "        </div>\n",
    "      </div>\n",
    "    </Link>\n",
    "  );\n",
    "}\n",
]

lines = lines[:compact_idx] + new_end

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\ProductCard.jsx", "w", encoding="utf-8") as f:
    f.writelines(lines)
print("Fixed!")
