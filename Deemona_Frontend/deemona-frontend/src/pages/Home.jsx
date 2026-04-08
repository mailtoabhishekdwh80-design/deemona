import React, { useState, useEffect, useRef } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Products, Categories } from '../api/index.js';

// ── Helpers ──────────────────────────────────────────────────────────────────
const getImg = (p) => {
  try {
    const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs;
    return Array.isArray(arr) && arr[0] ? arr[0] : '';
  } catch { return ''; }
};

const fmt = (n) => Number(n).toLocaleString('en-IN');
const disc = (p) => p.MRP > p.Price ? Math.round((p.MRP - p.Price) / p.MRP * 100) : 0;

// ── Hero Banners ──────────────────────────────────────────────────────────────
const BANNERS = [
  { bg: 'linear-gradient(135deg,#1a3a5c 0%,#0d2137 100%)', tag: 'NEW ARRIVALS', title: 'Latest Smartphones', sub: 'Up to 30% off on top brands', cta: 'Shop Now', cat: 'Mobiles', img: 'https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=500', accent: '#F0C14B' },
  { bg: 'linear-gradient(135deg,#1a2e1a 0%,#0d1f0d 100%)', tag: 'BIG SALE', title: 'Fashion & Footwear', sub: 'Starting at Rs.299 | Free Delivery', cta: 'Explore', cat: 'Clothing', img: 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?w=500', accent: '#00ACC1' },
  { bg: 'linear-gradient(135deg,#2e1a1a 0%,#1f0d0d 100%)', tag: 'MEGA DEALS', title: 'Home Appliances', sub: 'Up to 55% off | EMI available', cta: 'Buy Now', cat: 'Home Appliances', img: 'https://images.pexels.com/photos/3184183/pexels-photo-3184183.jpeg?w=500', accent: '#FF9900' },
  { bg: 'linear-gradient(135deg,#1a1a2e 0%,#0d0d1f 100%)', tag: 'BESTSELLERS', title: 'Laptops & Computers', sub: 'EMI from Rs.999/month', cta: 'Shop Now', cat: 'Computers', img: 'https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=500', accent: '#34d399' },
];

// ── Deal Categories ────────────────────────────────────────────────────────────
const DEAL_CATS = [
  { label: 'Mobiles', sub: 'Up to 40% off', img: 'https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?w=300', cat: 'Mobiles' },
  { label: 'Laptops', sub: 'Starting Rs.29,999', img: 'https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=300', cat: 'Computers' },
  { label: 'TVs', sub: 'Up to 55% off', img: 'https://images.pexels.com/photos/1201996/pexels-photo-1201996.jpeg?w=300', cat: 'TVs' },
  { label: 'Appliances', sub: 'Big savings', img: 'https://images.pexels.com/photos/5591581/pexels-photo-5591581.jpeg?w=300', cat: 'Home Appliances' },
  { label: 'Fashion', sub: 'Top brands', img: 'https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg?w=300', cat: 'Clothing' },
  { label: 'Footwear', sub: 'From Rs.299', img: 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?w=300', cat: 'Footwear' },
  { label: 'Cameras', sub: 'DSLRs & more', img: 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?w=300', cat: 'Cameras' },
  { label: 'Audio', sub: 'ANC headphones', img: 'https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?w=300', cat: 'Audio' },
  { label: 'Watches', sub: 'Smart & analog', img: 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg?w=300', cat: 'Watches' },
  { label: 'Books', sub: 'Bestsellers', img: 'https://images.pexels.com/photos/256431/pexels-photo-256431.jpeg?w=300', cat: 'Books' },
  { label: 'Toys', sub: 'Kids love it', img: 'https://images.pexels.com/photos/1148998/pexels-photo-1148998.jpeg?w=300', cat: 'Toys & Games' },
  { label: 'Grocery', sub: 'Daily needs', img: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?w=300', cat: 'Groceries' },
  { label: 'Beauty', sub: 'Skincare & more', img: 'https://images.pexels.com/photos/2253832/pexels-photo-2253832.jpeg?w=300', cat: 'Beauty' },
  { label: 'Sports', sub: 'Fitness gear', img: 'https://images.pexels.com/photos/1661950/pexels-photo-1661950.jpeg?w=300', cat: 'Sports' },
  { label: 'Pet Supplies', sub: 'For your pets', img: 'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?w=300', cat: 'Pet Supplies' },
  { label: 'Bags', sub: 'Travel in style', img: 'https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg?w=300', cat: 'Bags & Luggage' },
];

// ── Mini Product Card ─────────────────────────────────────────────────────────
const MiniCard = ({ p }) => {
  const img = getImg(p);
  const d = disc(p);
  return (
    <Link to={`/product/${p.ProductID}`} style={{ textDecoration: 'none', display: 'block' }}>
      <div style={{ background: '#fff', borderRadius: 4, overflow: 'hidden', transition: 'box-shadow .2s', border: '1px solid #eee' }}
        onMouseEnter={e => e.currentTarget.style.boxShadow = '0 4px 20px rgba(0,0,0,.15)'}
        onMouseLeave={e => e.currentTarget.style.boxShadow = 'none'}
      >
        <div style={{ height: 160, background: '#f7f8f8', display: 'flex', alignItems: 'center', justifyContent: 'center', overflow: 'hidden', padding: 8 }}>
          {img
            ? <img src={img} alt={p.Name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} onError={e => e.target.style.display='none'}/>
            : <div style={{ fontSize: 40 }}>📦</div>
          }
        </div>
        <div style={{ padding: '8px 10px' }}>
          <div style={{ fontSize: 13, color: '#0F1111', lineHeight: 1.3, fontWeight: 500, overflow: 'hidden', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', minHeight: 36 }}>{p.Name}</div>
          <div style={{ marginTop: 4, display: 'flex', alignItems: 'baseline', gap: 6, flexWrap: 'wrap' }}>
            <span style={{ fontSize: 15, fontWeight: 700, color: '#0F1111' }}>Rs.{fmt(p.Price)}</span>
            {d > 0 && <span style={{ fontSize: 11, color: '#CC0C39', fontWeight: 600 }}>{d}% off</span>}
          </div>
          {p.Brand && <div style={{ fontSize: 11, color: '#007185', marginTop: 2 }}>{p.Brand}</div>}
        </div>
      </div>
    </Link>
  );
};

// ── Section ───────────────────────────────────────────────────────────────────
const Section = ({ title, viewAll, children }) => (
  <div style={{ background: '#fff', borderRadius: 4, padding: '20px 20px 16px', marginBottom: 12, border: '1px solid #ddd' }}>
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16, borderBottom: '1px solid #eee', paddingBottom: 12 }}>
      <h2 style={{ fontSize: 21, fontWeight: 700, color: '#0F1111', margin: 0 }}>{title}</h2>
      {viewAll && <Link to={viewAll} style={{ fontSize: 13, color: '#007185', textDecoration: 'none', fontWeight: 500 }}
        onMouseEnter={e => e.target.style.color='#C7511F'} onMouseLeave={e => e.target.style.color='#007185'}>
        See all deals →
      </Link>}
    </div>
    {children}
  </div>
);

// ── Scrollable Row ────────────────────────────────────────────────────────────
const ScrollRow = ({ children }) => {
  const ref = useRef();
  const scroll = (dir) => ref.current?.scrollBy({ left: dir * 300, behavior: 'smooth' });
  return (
    <div style={{ position: 'relative' }}>
      <button onClick={() => scroll(-1)} style={{ position: 'absolute', left: -12, top: '50%', transform: 'translateY(-50%)', zIndex: 10, width: 36, height: 36, borderRadius: '50%', background: '#fff', border: '1px solid #ddd', cursor: 'pointer', fontSize: 16, boxShadow: '0 2px 8px rgba(0,0,0,.2)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>‹</button>
      <div ref={ref} style={{ display: 'flex', gap: 12, overflowX: 'auto', scrollbarWidth: 'none', paddingBottom: 4 }}>
        {children}
      </div>
      <button onClick={() => scroll(1)} style={{ position: 'absolute', right: -12, top: '50%', transform: 'translateY(-50%)', zIndex: 10, width: 36, height: 36, borderRadius: '50%', background: '#fff', border: '1px solid #ddd', cursor: 'pointer', fontSize: 16, boxShadow: '0 2px 8px rgba(0,0,0,.2)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>›</button>
    </div>
  );
};

// ── Main Component ────────────────────────────────────────────────────────────
export default function Home() {
  const navigate = useNavigate();
  const [bannerIdx, setBannerIdx] = useState(0);
  const [featured, setFeatured] = useState([]);
  const [newArr, setNewArr] = useState([]);
  const [deals, setDeals] = useState([]);
  const [topElec, setTopElec] = useState([]);
  const [topFash, setTopFash] = useState([]);
  const [topBooks, setTopBooks] = useState([]);
  const [topKitch, setTopKitch] = useState([]);

  useEffect(() => {
    const t = setInterval(() => setBannerIdx(i => (i + 1) % BANNERS.length), 4000);
    return () => clearInterval(t);
  }, []);

  useEffect(() => {
    const load = async () => {
      try {
        const [f, n, d, e, fa, b, k] = await Promise.all([
          Products.list({ featured: true, limit: 12 }),
          Products.list({ sort: 'newest', limit: 12 }),
          Products.list({ sort: 'price_asc', limit: 12 }),
          Products.list({ category: 'Electronics', limit: 8 }),
          Products.list({ category: 'Clothing', limit: 8 }),
          Products.list({ category: 'Books', limit: 8 }),
          Products.list({ category: 'Kitchen', limit: 8 }),
        ]);
        setFeatured(f.data?.products || []);
        setNewArr(n.data?.products || []);
        setDeals(d.data?.products || []);
        setTopElec(e.data?.products || []);
        setTopFash(fa.data?.products || []);
        setTopBooks(b.data?.products || []);
        setTopKitch(k.data?.products || []);
      } catch(e) { console.error(e); }
    };
    load();
  }, []);

  const b = BANNERS[bannerIdx];

  return (
    <div style={{ background: '#EAEDED', minHeight: '100vh' }}>

      {/* ── Hero Banner ── */}
      <div style={{ position: 'relative', overflow: 'hidden', marginBottom: 12 }}>
        <div style={{ background: b.bg, minHeight: 380, display: 'flex', alignItems: 'center', justifyContent: 'center', transition: 'background .6s ease', position: 'relative' }}>
          <div style={{ maxWidth: 1200, width: '100%', margin: '0 auto', padding: '40px 24px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 40, alignItems: 'center' }}>
            <div>
              <div style={{ fontSize: 12, fontWeight: 700, color: b.accent, letterSpacing: '.2em', textTransform: 'uppercase', marginBottom: 12, fontFamily: 'monospace' }}>{b.tag}</div>
              <h1 style={{ fontSize: 'clamp(28px,4vw,52px)', fontWeight: 800, color: '#fff', lineHeight: 1.1, marginBottom: 16 }}>{b.title}</h1>
              <p style={{ fontSize: 18, color: 'rgba(255,255,255,.8)', marginBottom: 28, lineHeight: 1.5 }}>{b.sub}</p>
              <div style={{ display: 'flex', gap: 12 }}>
                <button onClick={() => navigate(`/shop/${b.cat}`)} style={{ padding: '14px 32px', background: b.accent, color: '#111', border: 'none', borderRadius: 6, fontSize: 15, fontWeight: 800, cursor: 'pointer', boxShadow: `0 4px 16px ${b.accent}50` }}>{b.cta}</button>
                <button onClick={() => navigate('/shop')} style={{ padding: '14px 28px', background: 'rgba(255,255,255,.1)', color: '#fff', border: '2px solid rgba(255,255,255,.4)', borderRadius: 6, fontSize: 15, fontWeight: 600, cursor: 'pointer' }}>All Products</button>
              </div>
              <div style={{ marginTop: 24, display: 'flex', gap: 24 }}>
                {['Free Delivery', 'Easy Returns', 'Secure Payments'].map(f => (
                  <div key={f} style={{ fontSize: 12, color: 'rgba(255,255,255,.6)', display: 'flex', alignItems: 'center', gap: 5 }}>
                    <span style={{ color: b.accent }}>✓</span> {f}
                  </div>
                ))}
              </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'center' }}>
              <div style={{ width: 280, height: 280, borderRadius: 16, overflow: 'hidden', boxShadow: '0 24px 64px rgba(0,0,0,.4)', border: '3px solid rgba(255,255,255,.1)' }}>
                <img src={b.img} alt={b.title} style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/>
              </div>
            </div>
          </div>
        </div>

        {/* Banner dots */}
        <div style={{ position: 'absolute', bottom: 16, left: '50%', transform: 'translateX(-50%)', display: 'flex', gap: 8 }}>
          {BANNERS.map((_, i) => (
            <button key={i} onClick={() => setBannerIdx(i)} style={{ width: i === bannerIdx ? 24 : 8, height: 8, borderRadius: 4, background: i === bannerIdx ? '#fff' : 'rgba(255,255,255,.4)', border: 'none', cursor: 'pointer', transition: 'all .3s' }}/>
          ))}
        </div>

        {/* Prev/Next */}
        <button onClick={() => setBannerIdx(i => (i - 1 + BANNERS.length) % BANNERS.length)} style={{ position: 'absolute', left: 16, top: '50%', transform: 'translateY(-50%)', width: 40, height: 40, borderRadius: '50%', background: 'rgba(0,0,0,.4)', border: 'none', color: '#fff', cursor: 'pointer', fontSize: 20 }}>‹</button>
        <button onClick={() => setBannerIdx(i => (i + 1) % BANNERS.length)} style={{ position: 'absolute', right: 16, top: '50%', transform: 'translateY(-50%)', width: 40, height: 40, borderRadius: '50%', background: 'rgba(0,0,0,.4)', border: 'none', color: '#fff', cursor: 'pointer', fontSize: 20 }}>›</button>
      </div>

      <div style={{ maxWidth: 1200, margin: '0 auto', padding: '0 12px' }}>

        {/* ── Shop by Category ── */}
        <Section title="Shop by Category">
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(8,1fr)', gap: 8 }}>
            {DEAL_CATS.map(c => (
              <Link key={c.cat} to={`/shop/${encodeURIComponent(c.cat)}`} style={{ textDecoration: 'none', textAlign: 'center' }}>
                <div style={{ borderRadius: 8, overflow: 'hidden', marginBottom: 6, aspectRatio: '1', background: '#f7f8f8', border: '1px solid #eee', transition: 'transform .2s' }}
                  onMouseEnter={e => e.currentTarget.style.transform='scale(1.04)'}
                  onMouseLeave={e => e.currentTarget.style.transform='none'}>
                  <img src={c.img} alt={c.label} style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/>
                </div>
                <div style={{ fontSize: 12, fontWeight: 700, color: '#0F1111', lineHeight: 1.2 }}>{c.label}</div>
                <div style={{ fontSize: 10, color: '#CC0C39', fontWeight: 600 }}>{c.sub}</div>
              </Link>
            ))}
          </div>
        </Section>

        {/* ── Deal Banners Row ── */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 12, marginBottom: 12 }}>
          {[
            { title: 'Appliances for your home', sub: 'Up to 55% off', img: 'https://images.pexels.com/photos/5591581/pexels-photo-5591581.jpeg?w=400', cat: 'Home Appliances', color: '#e8f4f8' },
            { title: 'Revamp your home in style', sub: 'Furniture & Decor deals', img: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?w=400', cat: 'Home Decor', color: '#f8f4e8' },
            { title: 'Bulk savings on Electronics', sub: 'Up to 45% off Laptops', img: 'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?w=400', cat: 'Computers', color: '#f0f8f0' },
            { title: 'Deals on daily essentials', sub: 'Starting Rs.49', img: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?w=400', cat: 'Groceries', color: '#f8f0f8' },
          ].map(d => (
            <Link key={d.cat} to={`/shop/${encodeURIComponent(d.cat)}`} style={{ textDecoration: 'none' }}>
              <div style={{ background: d.color, borderRadius: 4, padding: 16, border: '1px solid #ddd', cursor: 'pointer', height: '100%', transition: 'box-shadow .2s' }}
                onMouseEnter={e => e.currentTarget.style.boxShadow='0 4px 16px rgba(0,0,0,.1)'}
                onMouseLeave={e => e.currentTarget.style.boxShadow='none'}>
                <h3 style={{ fontSize: 15, fontWeight: 700, color: '#0F1111', marginBottom: 4, lineHeight: 1.3 }}>{d.title}</h3>
                <p style={{ fontSize: 12, color: '#CC0C39', fontWeight: 600, marginBottom: 10 }}>{d.sub}</p>
                <img src={d.img} alt={d.title} style={{ width: '100%', height: 120, objectFit: 'cover', borderRadius: 4 }} onError={e => e.target.style.display='none'}/>
                <div style={{ marginTop: 10, fontSize: 12, color: '#007185', fontWeight: 600 }}>See more →</div>
              </div>
            </Link>
          ))}
        </div>

        {/* ── Today's Deals ── */}
        <Section title="Today's Deals" viewAll="/shop?sort=price_asc">
          <ScrollRow>
            {deals.map(p => (
              <div key={p.ProductID} style={{ minWidth: 160, maxWidth: 160 }}>
                <MiniCard p={p}/>
              </div>
            ))}
          </ScrollRow>
        </Section>

        {/* ── Featured Products ── */}
        <Section title="Featured Products" viewAll="/shop?featured=true">
          <ScrollRow>
            {featured.map(p => (
              <div key={p.ProductID} style={{ minWidth: 180, maxWidth: 180 }}>
                <MiniCard p={p}/>
              </div>
            ))}
          </ScrollRow>
        </Section>

        {/* ── Promo Banner ── */}
        <div style={{ background: 'linear-gradient(135deg,#1B3A6B,#0F2D55)', borderRadius: 8, padding: '28px 32px', marginBottom: 12, display: 'flex', justifyContent: 'space-between', alignItems: 'center', border: '1px solid #1B3A6B' }}>
          <div>
            <div style={{ fontSize: 11, color: '#F0C14B', fontWeight: 700, letterSpacing: '.15em', textTransform: 'uppercase', marginBottom: 8, fontFamily: 'monospace' }}>EXCLUSIVE OFFER</div>
            <h2 style={{ fontSize: 26, fontWeight: 800, color: '#fff', marginBottom: 6 }}>Get 10% off your first order</h2>
            <p style={{ color: 'rgba(255,255,255,.7)', fontSize: 14, marginBottom: 16 }}>Use code <strong style={{ color: '#F0C14B' }}>DEEMONA10</strong> at checkout. Min. order Rs.500</p>
            <button onClick={() => navigate('/shop')} style={{ padding: '12px 28px', background: 'linear-gradient(to bottom,#f7dfa5,#f0c14b)', color: '#111', border: 'none', borderRadius: 6, fontWeight: 800, cursor: 'pointer', fontSize: 14 }}>Shop Now →</button>
          </div>
          <div style={{ fontSize: 80, opacity: 0.15 }}>🛍️</div>
        </div>

        {/* ── Electronics ── */}
        <Section title="Top in Electronics" viewAll="/shop/Electronics">
          <ScrollRow>
            {topElec.map(p => (
              <div key={p.ProductID} style={{ minWidth: 180, maxWidth: 180 }}>
                <MiniCard p={p}/>
              </div>
            ))}
          </ScrollRow>
        </Section>

        {/* ── Fashion ── */}
        <Section title="Fashion & Lifestyle" viewAll="/shop/Clothing">
          <ScrollRow>
            {topFash.map(p => (
              <div key={p.ProductID} style={{ minWidth: 180, maxWidth: 180 }}>
                <MiniCard p={p}/>
              </div>
            ))}
          </ScrollRow>
        </Section>

        {/* ── Split row: Books + Kitchen ── */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12, marginBottom: 12 }}>
          <Section title="Bestselling Books" viewAll="/shop/Books">
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 8 }}>
              {topBooks.slice(0, 4).map(p => <MiniCard key={p.ProductID} p={p}/>)}
            </div>
          </Section>
          <Section title="Kitchen Essentials" viewAll="/shop/Kitchen">
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 8 }}>
              {topKitch.slice(0, 4).map(p => <MiniCard key={p.ProductID} p={p}/>)}
            </div>
          </Section>
        </div>

        {/* ── New Arrivals ── */}
        <Section title="New Arrivals" viewAll="/shop?sort=newest">
          <ScrollRow>
            {newArr.map(p => (
              <div key={p.ProductID} style={{ minWidth: 180, maxWidth: 180 }}>
                <MiniCard p={p}/>
              </div>
            ))}
          </ScrollRow>
        </Section>

        {/* ── Services Row ── */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 12, marginBottom: 12 }}>
          {[
            { icon: '🚚', title: 'Free Delivery', sub: 'On orders above Rs.499', color: '#e8f4f8' },
            { icon: '↩️', title: 'Easy Returns', sub: '30-day hassle-free returns', color: '#f0f8f0' },
            { icon: '🔒', title: 'Secure Payments', sub: '100% safe & encrypted', color: '#f8f4e8' },
            { icon: '🎯', title: 'Best Prices', sub: 'Guaranteed lowest price', color: '#f8f0f8' },
          ].map(s => (
            <div key={s.title} style={{ background: s.color, borderRadius: 8, padding: '20px 16px', textAlign: 'center', border: '1px solid #ddd' }}>
              <div style={{ fontSize: 32, marginBottom: 8 }}>{s.icon}</div>
              <div style={{ fontSize: 14, fontWeight: 700, color: '#0F1111', marginBottom: 4 }}>{s.title}</div>
              <div style={{ fontSize: 12, color: '#565959' }}>{s.sub}</div>
            </div>
          ))}
        </div>

      </div>
    </div>
  );
}
