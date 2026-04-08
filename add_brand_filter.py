with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Shop.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# 1. Add brand state after inStock state
code = code.replace(
    "  const [inStock,  setInStock]  = useState(false);",
    "  const [inStock,  setInStock]  = useState(false);\n  const [brand,    setBrand]    = useState('');\n  const [brands,   setBrands]   = useState([]);\n  const [rating,   setRating]   = useState('');"
)

# 2. Fetch brands when category changes
code = code.replace(
    "  useEffect(() => {\n    Categories.list().then(d => setCategories(d.data || [])).catch(() => {});\n  }, []);",
    """  useEffect(() => {
    Categories.list().then(d => setCategories(d.data || [])).catch(() => {});
  }, []);

  useEffect(() => {
    setBrand('');
    if (!category) { setBrands([]); return; }
    Products.list({ category, limit: 200 })
      .then(d => {
        const allBrands = [...new Set((d.data?.products || []).map(p => p.Brand).filter(Boolean))].sort();
        setBrands(allBrands);
      }).catch(() => {});
  }, [category]);"""
)

# 3. Add brand and rating to fetch params
code = code.replace(
    "        ...(inStock    && { inStock: true }),",
    "        ...(inStock    && { inStock: true }),\n        ...(brand      && { brand }),\n        ...(rating     && { minRating: rating }),"
)

# 4. Add brand and rating to dependency arrays
code = code.replace(
    "  }, [category, qParam, featParam, sort, priceRange, minPrice, maxPrice, inStock, page]);",
    "  }, [category, qParam, featParam, sort, priceRange, minPrice, maxPrice, inStock, brand, rating, page]);"
)
code = code.replace(
    "  useEffect(() => { setPage(1); }, [category, qParam, sort, priceRange, inStock]);",
    "  useEffect(() => { setPage(1); }, [category, qParam, sort, priceRange, inStock, brand, rating]);"
)

# 5. Add brand + rating reset to clear filters button
code = code.replace(
    "setPriceRange(null); setMinPrice(''); setMaxPrice(''); setInStock(fal",
    "setPriceRange(null); setMinPrice(''); setMaxPrice(''); setBrand(''); setRating(''); setInStock(fal"
)

# 6. Add brand filter section in sidebar after price section
old_sidebar_end = """          {/* In stock */}"""
new_brand_section = """          {/* Brand filter */}
          {brands.length > 0 && (
            <div style={{ borderTop: '1px solid var(--border)', paddingTop: 16, marginTop: 8 }}>
              <div style={{ fontSize: 12, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: 10 }}>Brand</div>
              <div style={{ maxHeight: 200, overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: 6 }}>
                <label style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13 }}>
                  <input type="radio" name="brand" checked={brand === ''} onChange={() => setBrand('')} style={{ accentColor: 'var(--primary)' }}/>
                  <span>All Brands</span>
                </label>
                {brands.map(b => (
                  <label key={b} style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13 }}>
                    <input type="radio" name="brand" checked={brand === b} onChange={() => setBrand(b)} style={{ accentColor: 'var(--primary)' }}/>
                    <span style={{ color: brand === b ? 'var(--primary)' : 'var(--text)' }}>{b}</span>
                  </label>
                ))}
              </div>
            </div>
          )}

          {/* Rating filter */}
          <div style={{ borderTop: '1px solid var(--border)', paddingTop: 16, marginTop: 8 }}>
            <div style={{ fontSize: 12, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: 10 }}>Min Rating</div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
              {[['', 'All Ratings'], ['4', '4+ Stars'], ['3', '3+ Stars'], ['2', '2+ Stars']].map(([val, label]) => (
                <label key={val} style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13 }}>
                  <input type="radio" name="rating" checked={rating === val} onChange={() => setRating(val)} style={{ accentColor: 'var(--primary)' }}/>
                  <span style={{ color: rating === val ? 'var(--primary)' : 'var(--text)' }}>
                    {val ? `${'★'.repeat(parseInt(val))}${'☆'.repeat(5-parseInt(val))}` : label}
                  </span>
                </label>
              ))}
            </div>
          </div>

          {/* In stock */}"""

code = code.replace(old_sidebar_end, new_brand_section)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Shop.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done! Brand + Rating filters added!")
