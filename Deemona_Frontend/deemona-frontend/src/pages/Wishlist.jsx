// Wishlist.jsx
import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { Wishlist as WishlistAPI } from '../api/index.js';
import { useCart } from '../context/CartContext.jsx';
import { useToast } from '../context/ToastContext.jsx';
import Spinner from '../components/Spinner.jsx';

export default function Wishlist() {
  const { addItem } = useCart();
  const { add: toast } = useToast();
  const [items,   setItems]   = useState([]);
  const [loading, setLoading] = useState(true);

  const load = () => WishlistAPI.get().then(d => setItems(d.data || [])).catch(() => []).finally(() => setLoading(false));
  useEffect(() => { load(); }, []);

  const handleRemove = async pid => {
    await WishlistAPI.remove(pid);
    setItems(i => i.filter(x => x.ProductID !== pid));
    toast('Removed from wishlist', 'info');
  };

  const handleMoveToCart = async pid => {
    try {
      await WishlistAPI.moveToCart(pid);
      toast('Moved to cart!', 'success');
      load();
    } catch (e) { toast(e?.error || 'Error', 'error'); }
  };

  if (loading) return <Spinner full />;

  return (
    <div className="page-enter">
      <div className="container" style={{ padding: '40px 24px' }}>
        <h1 style={{ fontFamily: 'var(--display)', fontSize: 36, fontWeight: 700, marginBottom: 32 }}>My <em style={{ color: 'var(--gold)', fontStyle: 'italic' }}>Wishlist</em></h1>

        {items.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '80px 0' }}>
            <div style={{ fontSize: 64, marginBottom: 16 }}>♡</div>
            <h2 style={{ fontFamily: 'var(--display)', fontSize: 28, marginBottom: 8 }}>Your wishlist is empty</h2>
            <Link to="/shop" className="btn btn-gold" style={{ marginTop: 12, display: 'inline-flex' }}>Browse Products</Link>
          </div>
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 20 }}>
            {items.map(item => (
              <div key={item.WishlistID || item.ProductID} style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 14, overflow: 'hidden', transition: 'box-shadow .2s' }}
                onMouseEnter={e => e.currentTarget.style.boxShadow='var(--sh2)'}
                onMouseLeave={e => e.currentTarget.style.boxShadow='none'}
              >
                <Link to={`/product/${item.ProductID}`} style={{ display: 'block', padding: '40px 20px', background: 'var(--cream)', textAlign: 'center', fontSize: 48 }}>[Box]</Link>
                <div style={{ padding: '14px 16px' }}>
                  <Link to={`/product/${item.ProductID}`} style={{ fontSize: 14, fontWeight: 600, color: 'var(--ink)', display: 'block', marginBottom: 6, lineHeight: 1.4 }}>{item.Name}</Link>
                  <div style={{ fontSize: 16, fontWeight: 700, marginBottom: 12 }}>₹{item.Price?.toLocaleString('en-IN')}</div>
                  <div style={{ display: 'flex', gap: 8 }}>
                    <button onClick={() => handleMoveToCart(item.ProductID)} className="btn btn-navy btn-sm" style={{ flex: 1, justifyContent: 'center' }}>Add to Cart</button>
                    <button onClick={() => handleRemove(item.ProductID)} style={{ width: 34, height: 34, borderRadius: 8, background: 'var(--red-l)', color: 'var(--red)', border: 'none', cursor: 'pointer', fontSize: 16 }}>✕</button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
