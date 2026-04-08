with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Replace the entire HERO_CATEGORIES array with image URLs
old = """const HERO_CATEGORIES = [
  { name: 'Electronics',      icon: '[Power]', color: '#1e3a5f', light: '#dbeafe' },
  { name: 'Clothing',         icon: '[Shirt]', color: '#3b1f5e', light: '#ede9fe' },
  { name: 'Books',            icon: '[Books]', color: '#1a3a2e', light: '#d1fae5' },
  { name: 'Home Decor',       icon: '[Plant]', color: '#3d2b0e', light: '#fef3c7' },
  { name: 'Home Appliances',  icon: '[Home]', color: '#1f3040', light: '#e0f2fe' },
  { name: 'Gym Accessories',  icon: '[Strong]', color: '#1a1a2e', light: '#e0e7ff' },
  { name: 'Sports',           icon: '[Ball]', color: '#0e2a1a', light: '#dcfce7' },
  { name: 'Medicines',        icon: '[Med]', color: '#2a0e1a', light: '#fce7f3' },
];"""

new = """const HERO_CATEGORIES = [
  { name: 'Electronics',     icon: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300&q=80', color: '#1e3a5f', light: '#dbeafe' },
  { name: 'Clothing',        icon: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=300&q=80', color: '#3b1f5e', light: '#ede9fe' },
  { name: 'Books',           icon: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300&q=80', color: '#1a3a2e', light: '#d1fae5' },
  { name: 'Home Decor',      icon: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&q=80', color: '#3d2b0e', light: '#fef3c7' },
  { name: 'Home Appliances', icon: 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?w=300&q=80', color: '#1f3040', light: '#e0f2fe' },
  { name: 'Gym Accessories', icon: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=300&q=80', color: '#1a1a2e', light: '#e0e7ff' },
  { name: 'Sports',          icon: 'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=300&q=80', color: '#0e2a1a', light: '#dcfce7' },
  { name: 'Medicines',       icon: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&q=80', color: '#2a0e1a', light: '#fce7f3' },
];"""

code = code.replace(old, new)

# Now find where icon is rendered and replace text rendering with img tag
# Find pattern like: <span ...>{icon}</span> or similar
import re
# Show how icon is used in JSX
for i, l in enumerate(code.split("\n")):
    if "icon" in l and ("<" in l or "style" in l):
        print(f"Line {i+1}: {l[:120]}")

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("\nDone! Icons replaced with URLs")
