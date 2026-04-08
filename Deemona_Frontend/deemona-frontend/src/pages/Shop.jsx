import React, { useEffect, useState, useCallback } from 'react';
import { useParams, useSearchParams, useNavigate } from 'react-router-dom';
import { Products, Categories } from '../api/index.js';
import ProductCard from '../components/ProductCard.jsx';
import Spinner from '../components/Spinner.jsx';

const SORT_OPTIONS = [
  { value: 'relevance', label: 'Relevance' },
  { value: 'price_asc', label: 'Price: Low to High' },
  { value: 'price_desc', label: 'Price: High to Low' },
  { value: 'rating', label: 'Top Rated' },
  { value: 'newest', label: 'Newest First' },
];

const PRICE_RANGES = [
  { label: 'Under ₹500',       min: 0,     max: 500 },
  { label: '₹500 – ₹1,000',   min: 500,   max: 1000 },
  { label: '₹1,000 – ₹5,000', min: 1000,  max: 5000 },
  { label: '₹5,000 – ₹20,000',min: 5000,  max: 20000 },
  { label: 'Above ₹20,000',   min: 20000,  max: 999999 },
];

export default function Shop() {
  const { category }        = useParams();
  const [searchParams, setSP] = useSearchParams();
  const navigate            = useNavigate();

  const [products,   setProducts]   = useState([]);
  const [categories, setCategories] = useState([]);
  const [total,      setTotal]      = useState(0);
  const [loading,    setLoading]    = useState(true);
  const [page,       setPage]       = useState(1);
  const LIMIT = 20;

  const qParam  = searchParams.get('q')       || '';
  const sortParam  = searchParams.get('sort') || 'relevance';
  const featParam  = searchParams.get('featured') || '';
  const [sort,     setSort]     = useState(sortParam);
  const [priceRange,setPriceRange] = useState(null);
  const [minPrice, setMinPrice] = useState('');
  const [maxPrice, setMaxPrice] = useState('');
  const [inStock,  setInStock]  = useState(false);
  const [brand,    setBrand]    = useState('');
  const [brands,   setBrands]   = useState([]);
  const [rating,   setRating]   = useState('');

  useEffect(() => {
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
  }, [category]);

  const fetchProducts = useCallback(async () => {
    setLoading(true);
    try {
      const params = {
        page, limit: LIMIT,
        ...(category && { category }),
        ...(qParam    && { search: qParam }),
        ...(featParam && { featured: true }),
        sort,
        ...(priceRange && { minPrice: priceRange.min, maxPrice: priceRange.max }),
        ...(minPrice   && { minPrice }),
        ...(maxPrice   && { maxPrice }),
        ...(inStock    && { inStock: true }),
        ...(brand      && { brand }),
        ...(rating     && { minRating: rating }),
      };
      const d = await Products.list(params);
      setProducts(d.data?.products || []);
      setTotal(d.data?.pagination?.total || 0);
    } catch { setProducts([]); }
    finally   { setLoading(false); }
  }, [category, qParam, featParam, sort, priceRange, minPrice, maxPrice, inStock, brand, rating, page]);

  useEffect(() => { setPage(1); }, [category, qParam, sort, priceRange, inStock, brand, rating]);
  useEffect(() => { fetchProducts(); }, [fetchProducts]);

  const totalPages = Math.ceil(total / LIMIT);
  const pageTitle  = qParam ? `Search: "${qParam}"` : category || 'All Products';

  return (
    <div className="page-enter">
      {/* Breadcrumb */}
      <div style={{ background: 'var(--white)', borderBottom: '1px solid var(--border)', padding: '12px 0' }}>
        <div className="container" style={{ display: 'flex', alignItems: 'center', gap: 8, fontSize: 13, color: 'var(--muted)' }}>
          <span style={{ cursor: 'pointer', color: 'var(--gold)' }} onClick={() => navigate('/')}>Home</span>
          <span>›</span>
          <span style={{ cursor: 'pointer', color: 'var(--gold)' }} onClick={() => navigate('/shop')}>Shop</span>
          {category && <><span>›</span><span style={{ color: 'var(--ink)', fontWeight: 500 }}>{category}</span></>}
          {qParam   && <><span>›</span><span style={{ color: 'var(--ink)', fontWeight: 500 }}>"{qParam}"</span></>}
        </div>
      </div>

      <div className="container" style={{ padding: '32px 24px', display: 'grid', gridTemplateColumns: '240px 1fr', gap: 28, alignItems: 'start' }}>

        {/* ── Sidebar filters ─────────────────────── */}
        <aside style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 12, padding: 20, position: 'sticky', top: 100 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 }}>
            <h3 style={{ fontSize: 15, fontWeight: 700 }}>Filters</h3>
            <button onClick={() => { setPriceRange(null); setMinPrice(''); setMaxPrice(''); setBrand(''); setRating(''); setInStock(false); setSort('relevance'); }} style={{ fontSize: 12, color: 'var(--gold)', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600 }}>Clear all</button>
          </div>

          {/* Categories */}
          <div style={{ marginBottom: 24 }}>
            <div style={{ fontSize: 12, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: 10 }}>Category</div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
              <button onClick={() => navigate('/shop')} style={{ textAlign: 'left', padding: '6px 10px', borderRadius: 6, fontSize: 13, background: !category ? 'var(--gold-l)' : 'transparent', color: !category ? 'var(--amber)' : 'var(--sub)', border: 'none', cursor: 'pointer', fontWeight: !category ? 600 : 400 }}>All Categories</button>
              {categories.map(c => (
                <button key={c.CategoryID} onClick={() => navigate(`/shop/${encodeURIComponent(c.CategoryName)}`)}
                  style={{ textAlign: 'left', padding: '6px 10px', borderRadius: 6, fontSize: 13, background: category === c.CategoryName ? 'var(--gold-l)' : 'transparent', color: category === c.CategoryName ? 'var(--amber)' : 'var(--sub)', border: 'none', cursor: 'pointer', fontWeight: category === c.CategoryName ? 600 : 400, transition: 'background .1s' }}
                  onMouseEnter={e => { if (category !== c.CategoryName) e.currentTarget.style.background='var(--cream)'; }}
                  onMouseLeave={e => { if (category !== c.CategoryName) e.currentTarget.style.background='transparent'; }}
                >{c.CategoryName}</button>
              ))}
            </div>
          </div>

          {/* Price range */}
          <div style={{ marginBottom: 24 }}>
            <div style={{ fontSize: 12, fontWeight: 700, letterSpacing: '.08em', textTransform: 'uppercase', color: 'var(--muted)', marginBottom: 10 }}>Price Range</div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
              {PRICE_RANGES.map(r => (
                <label key={r.label} style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13, color: 'var(--sub)', padding: '4px 0' }}>
                  <input type="radio" name="price" checked={priceRange?.label === r.label} onChange={() => setPriceRange(r)} style={{ accentColor: 'var(--gold)' }}/>
                  {r.label}
                </label>
              ))}
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
              <input type="number" placeholder="Min ₹" value={minPrice} onChange={e => { setMinPrice(e.target.value); setPriceRange(null); }} className="input" style={{ flex: 1, padding: '7px 10px', fontSize: 13 }}/>
              <input type="number" placeholder="Max ₹" value={maxPrice} onChange={e => { setMaxPrice(e.target.value); setPriceRange(null); }} className="input" style={{ flex: 1, padding: '7px 10px', fontSize: 13 }}/>
            </div>
          </div>

          {/* Brand filter */}
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

          {/* In stock */}
          <label style={{ display: 'flex', alignItems: 'center', gap: 8, cursor: 'pointer', fontSize: 13, color: 'var(--sub)' }}>
            <input type="checkbox" checked={inStock} onChange={e => setInStock(e.target.checked)} style={{ accentColor: 'var(--gold)', width: 15, height: 15 }}/>
            In Stock Only
          </label>
        </aside>

        {/* ── Product grid ──────────────────────── */}
        <div>
          {/* Toolbar */}
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20, flexWrap: 'wrap', gap: 12 }}>
            <div>
              <h1 style={{ fontSize: 22, fontWeight: 700, fontFamily: 'var(--display)' }}>{pageTitle}</h1>
              {!loading && <div style={{ fontSize: 13, color: 'var(--muted)', marginTop: 2 }}>{total.toLocaleString('en-IN')} products</div>}
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <span style={{ fontSize: 12, color: 'var(--muted)' }}>Sort:</span>
              <select value={sort} onChange={e => setSort(e.target.value)} className="input" style={{ padding: '8px 12px', width: 'auto', fontSize: 13 }}>
                {SORT_OPTIONS.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
              </select>
            </div>
          </div>

          {loading ? (
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 20 }}>
              {[...Array(8)].map((_,i) => <div key={i} className="skeleton" style={{ height: 360, borderRadius: 12 }}/>)}
            </div>
          ) : products.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '80px 0', color: 'var(--muted)' }}>
              <div style={{ fontSize: 48, marginBottom: 16 }}>[Search]</div>
              <div style={{ fontSize: 18, fontWeight: 600, marginBottom: 8 }}>No products found</div>
              <div style={{ fontSize: 14 }}>Try adjusting your filters or search terms</div>
            </div>
          ) : (
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 20 }}>
              {products.map(p => <ProductCard key={p.ProductID} product={p}/>)}
            </div>
          )}

          {/* Pagination */}
          {totalPages > 1 && (
            <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginTop: 40 }}>
              <button onClick={() => setPage(p => Math.max(1, p-1))} disabled={page === 1} className="btn btn-outline btn-sm">← Prev</button>
              {[...Array(Math.min(7, totalPages))].map((_, i) => {
                const p = Math.max(1, Math.min(page - 3, totalPages - 6)) + i;
                return (
                  <button key={p} onClick={() => setPage(p)} style={{ width: 36, height: 36, borderRadius: 8, border: p === page ? '2px solid var(--gold)' : '1px solid var(--border)', background: p === page ? 'var(--gold)' : 'var(--white)', color: p === page ? 'var(--navy)' : 'var(--sub)', fontWeight: p === page ? 700 : 400, cursor: 'pointer', fontSize: 13 }}>{p}</button>
                );
              })}
              <button onClick={() => setPage(p => Math.min(totalPages, p+1))} disabled={page === totalPages} className="btn btn-outline btn-sm">Next →</button>
            </div>
          )}
        </div>
      </div>
      <style>{`@media(max-width:900px){.container>aside{display:none}.container{grid-template-columns:1fr!important}}`}</style>
    </div>
  );
}
