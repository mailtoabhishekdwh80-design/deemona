import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCart } from '../context/CartContext.jsx';
import { Wishlist } from '../api/index.js';
import { useAuth } from '../context/AuthContext.jsx';
import { useToast } from '../context/ToastContext.jsx';

export default function ProductCard({ product, compact = false }) {
  const { isAuthed } = useAuth();
  const { addItem }  = useCart();
  const { add: toast } = useToast();
  const navigate     = useNavigate();
  const [adding,     setAdding]     = useState(false);
  const [wishlisted, setWishlisted] = useState(false);

  const { ProductID, Name, Price, MRP, Brand, AverageRating, ReviewsCount, StockQuantity, CategoryName, IsFeatured, ImageURLs } = product;

  const discount = MRP > Price ? Math.round((MRP - Price) / MRP * 100) : 0;
  const inStock  = StockQuantity > 0;

  const imgUrl = (() => {
    try { const arr = typeof ImageURLs === 'string' ? JSON.parse(ImageURLs) : ImageURLs; return Array.isArray(arr) && arr[0] ? arr[0] : null; } catch { return null; }
  })();

  const handleAddCart = async e => {
    e.preventDefault();
    if (!isAuthed) { navigate('/auth'); return; }
    setAdding(true);
    try { await addItem(ProductID, 1); toast(`Added to cart`, 'success'); }
    catch (err) { toast(err?.error || 'Could not add to cart', 'error'); }
    finally { setAdding(false); }
  };

  const handleWishlist = async e => {
    e.preventDefault();
    if (!isAuthed) { navigate('/auth'); return; }
    try {
      if (wishlisted) { await Wishlist.remove(ProductID); setWishlisted(false); }
      else { await Wishlist.add(ProductID); setWishlisted(true); toast('Saved to Wishlist', 'success'); }
    } catch {}
  };

  const starStr = r => { const f = Math.round(r); return '*'.repeat(f) + '☆'.repeat(5-f); };

  return (
    <Link to={`/product/${ProductID}`} style={{ display: 'block', textDecoration: 'none' }}>
      <div style={{
        background: '#fff', border: '1px solid #ddd', borderRadius: 8,
        overflow: 'hidden', height: '100%', display: 'flex', flexDirection: 'column',
        transition: 'box-shadow .15s',
      }}
      onMouseEnter={e => e.currentTarget.style.boxShadow='0 4px 20px rgba(0,0,0,.12)'}
      onMouseLeave={e => e.currentTarget.style.boxShadow='none'}
      >
        {/* Image */}
        <div style={{ position: 'relative', paddingTop: '80%', background: '#f7f8f8', overflow: 'hidden' }}>
          {imgUrl ? (
            <img src={imgUrl} alt={Name} style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', objectFit: 'contain', padding: 8, transition: 'transform .3s' }}
              onMouseEnter={e => e.target.style.transform='scale(1.05)'}
              onMouseLeave={e => e.target.style.transform='scale(1)'}
            />
          ) : (
            <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#f7f8f8' }}><svg width='48' height='48' viewBox='0 0 24 24' fill='none' stroke='#ccc' strokeWidth='1.5'><path d='M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z'/></svg></div>
          )}
          {discount >= 5 && (
            <div style={{ position: 'absolute', top: 8, left: 8, background: '#CC0C39', color: '#fff', fontSize: 11, fontWeight: 700, padding: '3px 7px', borderRadius: 3 }}>-{discount}%</div>
          )}
          {IsFeatured && (
            <div style={{ position: 'absolute', top: 8, right: 36, background: '#FF9900', color: '#111', fontSize: 10, fontWeight: 700, padding: '3px 7px', borderRadius: 3 }}>FEATURED</div>
          )}
          <button onClick={handleWishlist} style={{
            position: 'absolute', top: 6, right: 6,
            width: 28, height: 28, borderRadius: '50%',
            background: 'rgba(255,255,255,.9)', border: '1px solid #ddd',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 15, cursor: 'pointer', color: wishlisted ? '#B12704' : '#888',
            transition: 'all .15s',
          }}>{wishlisted ? '♥' : '♡'}</button>
        </div>

        {/* Info */}
        <div style={{ padding: '10px 12px', flex: 1, display: 'flex', flexDirection: 'column', gap: 4 }}>
          <div style={{ fontSize: 13, color: '#0F1111', lineHeight: 1.4, fontWeight: 500, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>{Name}</div>
          {Brand && <div style={{ fontSize: 12, color: '#007185' }}>{Brand}</div>}

          {AverageRating > 0 && (
            <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
              <span style={{ color: '#FF9900', fontSize: 12 }}>{starStr(AverageRating)}</span>
              <span style={{ fontSize: 12, color: '#007185' }}>{ReviewsCount > 0 ? ReviewsCount.toLocaleString('en-IN') : ''}</span>
            </div>
          )}

          <div style={{ marginTop: 'auto', paddingTop: 6 }}>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: 6, flexWrap: 'wrap' }}>
              <span style={{ fontSize: 18, fontWeight: 700, color: '#B12704' }}>₹{Price?.toLocaleString('en-IN')}</span>
              {discount > 0 && <span style={{ fontSize: 12, color: '#565959', textDecoration: 'line-through' }}>₹{MRP?.toLocaleString('en-IN')}</span>}
            </div>
            {discount >= 5 && <div style={{ fontSize: 11, color: '#007600', fontWeight: 500 }}>Save ₹{(MRP - Price)?.toLocaleString('en-IN')} ({discount}%)</div>}
          </div>

          {!inStock ? (
            <div style={{ fontSize: 12, color: '#B12704', fontWeight: 600 }}>Currently unavailable</div>
          ) : StockQuantity <= 5 ? (
            <div style={{ fontSize: 12, color: '#B12704', fontWeight: 600 }}>Only {StockQuantity} left in stock</div>
          ) : null}

          {!compact && (
            <button onClick={handleAddCart} disabled={!inStock || adding}
              style={{
                width: '100%', marginTop: 8, padding: '8px 0', borderRadius: 20,
                background: inStock ? 'linear-gradient(to bottom,#f7dfa5,#f0c14b)' : '#e8e8e8',
                border: inStock ? '1px solid #a88734' : '1px solid #ddd',
                color: inStock ? '#111' : '#888',
                fontSize: 13, fontWeight: 500, cursor: inStock ? 'pointer' : 'not-allowed',
                transition: 'all .12s',
              }}
              onMouseEnter={e => { if (inStock) e.currentTarget.style.background='linear-gradient(to bottom,#f5d78e,#eeb933)'; }}
              onMouseLeave={e => { if (inStock) e.currentTarget.style.background='linear-gradient(to bottom,#f7dfa5,#f0c14b)'; }}
            >
              {adding ? 'Adding...' : inStock ? 'Add to Cart' : 'Unavailable'}
            </button>
          )}
        </div>
      </div>
    </Link>
  );
}
