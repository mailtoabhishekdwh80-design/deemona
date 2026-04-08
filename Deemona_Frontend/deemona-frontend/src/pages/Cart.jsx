import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCart } from '../context/CartContext.jsx';

const getImage = (item) => {
  try {
    const arr = typeof item.ImageURLs === 'string' ? JSON.parse(item.ImageURLs) : item.ImageURLs;
    return Array.isArray(arr) && arr[0] ? arr[0] : item.ImageURL || '';
  } catch { return item.ImageURL || ''; }
};

export default function Cart() {
  const { items, updateItem: update, removeItem: remove, clearCart: clear, count } = useCart();
  const navigate = useNavigate();
  const [selected, setSelected] = useState(new Set());
  const [coupon, setCoupon] = useState('');
  const [couponMsg, setCouponMsg] = useState('');
  const [discount, setDiscount] = useState(0);
  const [savedItems, setSavedItems] = useState([]);

  const allSelected = items.length > 0 && selected.size === items.length;

  const toggleSelect = (id) => {
    setSelected(s => {
      const n = new Set(s);
      n.has(id) ? n.delete(id) : n.add(id);
      return n;
    });
  };

  const toggleAll = () => {
    if (allSelected) setSelected(new Set());
    else setSelected(new Set(items.map(i => i.CartItemID)));
  };

  const deleteSelected = () => {
    selected.forEach(id => remove(id));
    setSelected(new Set());
  };

  const subtotal = items.reduce((s, i) => s + Number(i.Price) * i.Quantity, 0);
  const selectedSubtotal = items.filter(i => selected.has(i.CartItemID)).reduce((s, i) => s + Number(i.Price) * i.Quantity, 0);
  const shipping = subtotal >= 499 ? 0 : 49;
  const total = subtotal + shipping - discount;

  const applyCoupon = () => {
    if (coupon === 'DEEMONA10') { setDiscount(Math.round(subtotal * 0.1)); setCouponMsg('10% discount applied!'); }
    else if (coupon === 'SAVE50') { setDiscount(50); setCouponMsg('Rs.50 discount applied!'); }
    else { setDiscount(0); setCouponMsg('Invalid coupon code'); }
  };

  const saveForLater = (item) => {
    setSavedItems(s => [...s, item]);
    remove(item.CartItemID);
    setSelected(s => { const n = new Set(s); n.delete(item.CartItemID); return n; });
  };

  const moveToCart = (item) => {
    setSavedItems(s => s.filter(x => x.CartItemID !== item.CartItemID));
  };

  if (items.length === 0 && savedItems.length === 0) return (
    <div style={{ background: '#EAEDED', minHeight: '80vh', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <div style={{ background: '#fff', borderRadius: 8, padding: 48, textAlign: 'center', maxWidth: 480, border: '1px solid #ddd' }}>
        <div style={{ fontSize: 80, marginBottom: 16 }}>🛒</div>
        <h2 style={{ fontSize: 24, fontWeight: 700, color: '#111', marginBottom: 8 }}>Your Cart is empty</h2>
        <p style={{ color: '#565959', marginBottom: 24, lineHeight: 1.6 }}>Add products you want to buy.</p>
        <Link to="/shop" style={{ display: 'inline-block', padding: '12px 28px', background: '#F0C14B', color: '#111', borderRadius: 8, fontWeight: 700, textDecoration: 'none', border: '1px solid #a88734', fontSize: 14 }}>
          Continue Shopping
        </Link>
      </div>
    </div>
  );

  return (
    <div style={{ background: '#EAEDED', minHeight: '100vh', padding: '16px 0 40px' }}>
      <div style={{ maxWidth: 1200, margin: '0 auto', padding: '0 16px', display: 'grid', gridTemplateColumns: '1fr 320px', gap: 16, alignItems: 'start' }}>

        {/* ── Left Column ── */}
        <div>
          {/* Cart Header */}
          <div style={{ background: '#fff', borderRadius: 8, padding: '20px 24px', marginBottom: 12, border: '1px solid #ddd' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
              <div>
                <h1 style={{ fontSize: 28, fontWeight: 400, color: '#0F1111', margin: '0 0 8px' }}>Shopping Cart</h1>
                <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                  <label style={{ display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer', fontSize: 13, color: '#007185' }}>
                    <input type="checkbox" checked={allSelected} onChange={toggleAll}
                      style={{ width: 16, height: 16, cursor: 'pointer', accentColor: '#007185' }}/>
                    {allSelected ? 'Deselect all items' : 'Select all items'}
                  </label>
                  {selected.size > 0 && (
                    <button onClick={deleteSelected} style={{ background: 'none', border: 'none', color: '#CC0C39', cursor: 'pointer', fontSize: 13, fontWeight: 600, padding: 0 }}>
                      Delete selected ({selected.size})
                    </button>
                  )}
                </div>
              </div>
              <div style={{ fontSize: 13, color: '#565959' }}>Price</div>
            </div>
          </div>

          {/* Cart Items */}
          {items.length > 0 && (
            <div style={{ background: '#fff', borderRadius: 8, border: '1px solid #ddd', marginBottom: 12, overflow: 'hidden' }}>
              {items.map((item, idx) => {
                const imgUrl = getImage(item);
                const itemTotal = Number(item.Price) * item.Quantity;
                const hasDiscount = item.MRP > item.Price;
                const discPct = hasDiscount ? Math.round((item.MRP - item.Price) / item.MRP * 100) : 0;
                const isSelected = selected.has(item.CartItemID);

                return (
                  <div key={item.CartItemID} style={{
                    padding: '20px 24px',
                    borderBottom: idx < items.length - 1 ? '1px solid #ddd' : 'none',
                    display: 'flex', gap: 16,
                    background: isSelected ? '#fffbf0' : '#fff',
                    transition: 'background .2s',
                  }}>
                    {/* Checkbox */}
                    <div style={{ display: 'flex', alignItems: 'flex-start', paddingTop: 4 }}>
                      <input type="checkbox" checked={isSelected} onChange={() => toggleSelect(item.CartItemID)}
                        style={{ width: 18, height: 18, cursor: 'pointer', accentColor: '#007185' }}/>
                    </div>

                    {/* Product Image */}
                    <div style={{ width: 120, height: 120, flexShrink: 0, display: 'flex', alignItems: 'center', justifyContent: 'center', background: '#f7f8f8', borderRadius: 4, border: '1px solid #eee', overflow: 'hidden' }}>
                      {imgUrl
                        ? <img src={imgUrl} alt={item.ProductName} style={{ maxWidth: '100%', maxHeight: '100%', objectFit: 'contain' }} onError={e => { e.target.style.display='none'; }}/>
                        : <span style={{ fontSize: 40 }}>📦</span>
                      }
                    </div>

                    {/* Product Details */}
                    <div style={{ flex: 1 }}>
                      <Link to={`/product/${item.ProductID}`} style={{ fontSize: 16, fontWeight: 500, color: '#0F1111', textDecoration: 'none', lineHeight: 1.4, display: 'block', marginBottom: 4 }}
                        onMouseEnter={e => e.target.style.color='#C7511F'}
                        onMouseLeave={e => e.target.style.color='#0F1111'}
                      >{item.ProductName || item.Name}</Link>

                      {item.Brand && <div style={{ fontSize: 13, color: '#565959', marginBottom: 4 }}>by {item.Brand}</div>}
                      <div style={{ fontSize: 12, color: '#007600', fontWeight: 700, marginBottom: 6 }}>✓ In Stock</div>

                      {hasDiscount && (
                        <div style={{ fontSize: 12, color: '#565959', marginBottom: 8 }}>
                          <span style={{ color: '#CC0C39', fontWeight: 700 }}>{discPct}% off</span>
                          {' '}<span style={{ textDecoration: 'line-through' }}>Rs.{Number(item.MRP).toLocaleString('en-IN')}</span>
                        </div>
                      )}

                      {/* Quantity + Actions */}
                      <div style={{ display: 'flex', alignItems: 'center', gap: 12, flexWrap: 'wrap' }}>

                        {/* Quantity Selector */}
                        <div style={{ display: 'flex', alignItems: 'center', border: '1px solid #888', borderRadius: 20, overflow: 'hidden', background: '#f0f2f2' }}>
                          <button
                            onClick={() => item.Quantity > 1 ? update(item.CartItemID, item.Quantity - 1) : remove(item.CartItemID)}
                            style={{ width: 36, height: 32, border: 'none', background: 'transparent', cursor: 'pointer', fontSize: 18, color: '#0F1111', fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>−</button>
                          <input
                            type="number" min="1" max="10" value={item.Quantity}
                            onChange={e => { const v = parseInt(e.target.value); if (v >= 1 && v <= 10) update(item.CartItemID, v); }}
                            style={{ width: 40, height: 32, border: 'none', borderLeft: '1px solid #888', borderRight: '1px solid #888', textAlign: 'center', fontSize: 14, fontWeight: 700, background: '#fff', color: '#0F1111', outline: 'none' }}
                          />
                          <button
                            onClick={() => item.Quantity < 10 ? update(item.CartItemID, item.Quantity + 1) : null}
                            style={{ width: 36, height: 32, border: 'none', background: 'transparent', cursor: item.Quantity >= 10 ? 'not-allowed' : 'pointer', fontSize: 18, color: item.Quantity >= 10 ? '#ccc' : '#0F1111', fontWeight: 700, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>+</button>
                        </div>

                        <span style={{ color: '#ddd' }}>|</span>
                        <button onClick={() => remove(item.CartItemID)} style={{ background: 'none', border: 'none', color: '#007185', cursor: 'pointer', fontSize: 13 }}
                          onMouseEnter={e => e.target.style.color='#C7511F'} onMouseLeave={e => e.target.style.color='#007185'}>Delete</button>
                        <span style={{ color: '#ddd' }}>|</span>
                        <button onClick={() => saveForLater(item)} style={{ background: 'none', border: 'none', color: '#007185', cursor: 'pointer', fontSize: 13 }}
                          onMouseEnter={e => e.target.style.color='#C7511F'} onMouseLeave={e => e.target.style.color='#007185'}>Save for later</button>
                        <span style={{ color: '#ddd' }}>|</span>
                        <Link to={`/shop?category=${item.CategoryName}`} style={{ color: '#007185', fontSize: 13, textDecoration: 'none' }}
                          onMouseEnter={e => e.target.style.color='#C7511F'} onMouseLeave={e => e.target.style.color='#007185'}>See more like this</Link>
                      </div>
                    </div>

                    {/* Price */}
                    <div style={{ textAlign: 'right', flexShrink: 0 }}>
                      <div style={{ fontSize: 18, fontWeight: 700, color: '#0F1111' }}>Rs.{itemTotal.toLocaleString('en-IN')}</div>
                      {item.Quantity > 1 && <div style={{ fontSize: 11, color: '#565959', marginTop: 2 }}>Rs.{Number(item.Price).toLocaleString('en-IN')} each</div>}
                    </div>
                  </div>
                );
              })}

              {/* Cart Total Row */}
              <div style={{ padding: '16px 24px', textAlign: 'right', borderTop: '2px solid #ddd', background: '#fafafa' }}>
                <span style={{ fontSize: 18, color: '#0F1111' }}>
                  Subtotal ({count} {count === 1 ? 'item' : 'items'}): <strong style={{ fontSize: 20 }}>Rs.{subtotal.toLocaleString('en-IN')}</strong>
                </span>
                {selected.size > 0 && selected.size < items.length && (
                  <div style={{ fontSize: 13, color: '#565959', marginTop: 4 }}>
                    Selected items ({selected.size}): <strong>Rs.{selectedSubtotal.toLocaleString('en-IN')}</strong>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Saved for Later */}
          {savedItems.length > 0 && (
            <div style={{ background: '#fff', borderRadius: 8, border: '1px solid #ddd', overflow: 'hidden' }}>
              <div style={{ padding: '16px 24px', borderBottom: '1px solid #ddd' }}>
                <h2 style={{ fontSize: 18, fontWeight: 700, color: '#0F1111', margin: 0 }}>Saved for later ({savedItems.length} {savedItems.length === 1 ? 'item' : 'items'})</h2>
              </div>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill,minmax(160px,1fr))', gap: 16, padding: 20 }}>
                {savedItems.map(item => {
                  const imgUrl = getImage(item);
                  return (
                    <div key={item.CartItemID} style={{ border: '1px solid #eee', borderRadius: 6, overflow: 'hidden', padding: 12 }}>
                      <div style={{ height: 100, display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 8 }}>
                        {imgUrl ? <img src={imgUrl} alt={item.ProductName} style={{ maxWidth: '100%', maxHeight: '100%', objectFit: 'contain' }}/> : <span style={{ fontSize: 32 }}>📦</span>}
                      </div>
                      <div style={{ fontSize: 12, color: '#0F1111', fontWeight: 500, marginBottom: 4, lineHeight: 1.3 }}>{item.ProductName || item.Name}</div>
                      <div style={{ fontSize: 14, fontWeight: 700, color: '#0F1111', marginBottom: 8 }}>Rs.{Number(item.Price).toLocaleString('en-IN')}</div>
                      <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
                        <button onClick={() => moveToCart(item)} style={{ padding: '6px 12px', background: '#F0C14B', border: '1px solid #a88734', borderRadius: 4, cursor: 'pointer', fontSize: 12, fontWeight: 600, color: '#111' }}>Move to cart</button>
                        <button onClick={() => setSavedItems(s => s.filter(x => x.CartItemID !== item.CartItemID))} style={{ padding: '6px 12px', background: '#fff', border: '1px solid #ddd', borderRadius: 4, cursor: 'pointer', fontSize: 12, color: '#CC0C39' }}>Delete</button>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}
        </div>

        {/* ── Right Column - Order Summary ── */}
        <div style={{ position: 'sticky', top: 16 }}>
          <div style={{ background: '#fff', borderRadius: 8, padding: 20, border: '1px solid #ddd' }}>

            {shipping === 0 && (
              <div style={{ fontSize: 13, color: '#007600', marginBottom: 12, padding: '8px 12px', background: '#f0faf0', borderRadius: 4, border: '1px solid #c3e6cb' }}>
                Your order qualifies for <strong>FREE Delivery!</strong>
              </div>
            )}

            <div style={{ fontSize: 18, color: '#0F1111', marginBottom: 16, lineHeight: 1.4 }}>
              Subtotal ({count} {count === 1 ? 'item' : 'items'}): <strong>Rs.{subtotal.toLocaleString('en-IN')}</strong>
            </div>

            {/* Gift option */}
            <label style={{ display: 'flex', alignItems: 'flex-start', gap: 8, marginBottom: 16, cursor: 'pointer', fontSize: 13, color: '#0F1111' }}>
              <input type="checkbox" style={{ marginTop: 2, accentColor: '#007185' }}/>
              <span>This order contains a gift</span>
            </label>

            {/* Coupon */}
            <div style={{ marginBottom: 16, padding: '12px', background: '#f7f8f8', borderRadius: 6, border: '1px solid #eee' }}>
              <div style={{ fontSize: 13, fontWeight: 600, color: '#0F1111', marginBottom: 8 }}>Apply Coupon Code</div>
              <div style={{ display: 'flex', gap: 6 }}>
                <input value={coupon} onChange={e => setCoupon(e.target.value.toUpperCase())} placeholder="Enter code"
                  style={{ flex: 1, padding: '8px 10px', border: '1px solid #888', borderRadius: 4, fontSize: 13, outline: 'none' }}
                  onKeyDown={e => e.key === 'Enter' && applyCoupon()}/>
                <button onClick={applyCoupon} style={{ padding: '8px 14px', background: '#F0C14B', border: '1px solid #a88734', borderRadius: 4, cursor: 'pointer', fontSize: 13, fontWeight: 700, color: '#111' }}>Apply</button>
              </div>
              {couponMsg && <div style={{ fontSize: 12, marginTop: 6, color: couponMsg.includes('Invalid') ? '#B12704' : '#007600', fontWeight: 600 }}>{couponMsg}</div>}
              <div style={{ fontSize: 11, color: '#565959', marginTop: 6 }}>Try: DEEMONA10 or SAVE50</div>
            </div>

            {/* Price breakdown */}
            <div style={{ borderTop: '1px solid #ddd', paddingTop: 12, marginBottom: 16 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, color: '#565959', marginBottom: 8 }}>
                <span>Subtotal ({count} items)</span><span>Rs.{subtotal.toLocaleString('en-IN')}</span>
              </div>
              <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, color: '#565959', marginBottom: 8 }}>
                <span>Shipping</span>
                <span style={{ color: '#007600', fontWeight: 600 }}>{shipping === 0 ? 'FREE' : `Rs.${shipping}`}</span>
              </div>
              {discount > 0 && (
                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, color: '#007600', fontWeight: 600, marginBottom: 8 }}>
                  <span>Coupon Discount</span><span>- Rs.{discount}</span>
                </div>
              )}
              <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: 17, fontWeight: 700, color: '#0F1111', marginTop: 12, paddingTop: 12, borderTop: '1px solid #ddd' }}>
                <span>Order Total</span><span>Rs.{total.toLocaleString('en-IN')}</span>
              </div>
            </div>

            <button onClick={() => navigate('/checkout')} style={{ width: '100%', padding: '13px', background: 'linear-gradient(to bottom,#f7dfa5,#f0c14b)', border: '1px solid #a88734', borderRadius: 20, cursor: 'pointer', fontSize: 15, fontWeight: 700, color: '#111', marginBottom: 8, boxShadow: '0 2px 4px rgba(0,0,0,.1)' }}>
              Proceed to Checkout →
            </button>

            <button onClick={() => navigate('/shop')} style={{ width: '100%', padding: '10px', background: 'linear-gradient(to bottom,#f7dfa5,#f0c14b)', border: '1px solid #a88734', borderRadius: 20, cursor: 'pointer', fontSize: 13, fontWeight: 700, color: '#111' }}>
              ← Continue Shopping
            </button>

            {/* Security */}
            <div style={{ marginTop: 14, textAlign: 'center' }}>
              <div style={{ fontSize: 11, color: '#565959', lineHeight: 1.8 }}>
                🔒 <strong>Secure transaction</strong><br/>
                Your information is safe & encrypted
              </div>
            </div>
          </div>

          {/* Delivery Info */}
          <div style={{ background: '#fff', borderRadius: 8, padding: 16, border: '1px solid #ddd', marginTop: 12 }}>
            <div style={{ fontSize: 13, fontWeight: 700, color: '#0F1111', marginBottom: 10 }}>Delivery Information</div>
            {[
              ['🚚', 'FREE delivery on orders above Rs.499'],
              ['⚡', 'Express delivery at Rs.99'],
              ['📦', 'Easy 30-day returns'],
              ['💳', 'Pay on delivery available'],
              ['🏷️', 'GST invoice available'],
            ].map(([icon, text]) => (
              <div key={text} style={{ fontSize: 12, color: '#565959', marginBottom: 6, display: 'flex', gap: 6 }}>
                <span>{icon}</span><span>{text}</span>
              </div>
            ))}
          </div>
        </div>

      </div>
    </div>
  );
}
