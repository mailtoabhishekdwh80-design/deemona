with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix handleSearch - if no query but category selected, go to category page
code = code.replace(
    """  const handleSearch = e => {
    e.preventDefault();
    if (!query.trim()) return;
    const cat = searchCat !== "All" ? "&category=" + encodeURIComponent(searchCat) : "";
    navigate("/search?q=" + encodeURIComponent(query.trim()) + cat);
    setShowSug(false);
  };""",
    """  const handleSearch = e => {
    e.preventDefault();
    if (!query.trim() && searchCat !== "All") {
      navigate("/shop/" + encodeURIComponent(searchCat));
      setShowSug(false);
      return;
    }
    if (!query.trim()) return;
    const cat = searchCat !== "All" ? "&category=" + encodeURIComponent(searchCat) : "";
    navigate("/search?q=" + encodeURIComponent(query.trim()) + cat);
    setShowSug(false);
  };"""
)

# Also make category dropdown navigate directly when changed
code = code.replace(
    'onChange={e => setSearchCat(e.target.value)}',
    'onChange={e => { setSearchCat(e.target.value); if (e.target.value !== "All") navigate("/shop/" + encodeURIComponent(e.target.value)); }}'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
