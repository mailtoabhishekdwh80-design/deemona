import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Products, Reviews as ReviewsAPI } from '../api/index.js';
import { useCart } from '../context/CartContext.jsx';
import { useAuth } from '../context/AuthContext.jsx';
import { useToast } from '../context/ToastContext.jsx';
import { Wishlist } from '../api/index.js';
import ProductCard from '../components/ProductCard.jsx';
import Spinner from '../components/Spinner.jsx';

export default function Product() {
  const { id }     = useParams();
  const navigate   = useNavigate();
  const { addItem } = useCart();
  const { isAuthed } = useAuth();
  const { add: toast } = useToast();

  const [product,  setProduct]  = useState(null);
  const [reviews,  setReviews]  = useState([]);
  const [qty,      setQty]      = useState(1);
  const [tab,      setTab]      = useState('desc');
  const [adding,   setAdding]   = useState(false);
  const [loading,  setLoading]  = useState(true);
  const [imgIdx,   setImgIdx]   = useState(0);
  const [newRev,   setNewRev]   = useState({ Rating: 5, Comment: '' });
  const [submitting,setSub]     = useState(false);

  useEffect(() => {
    setLoading(true);
    window.scrollTo(0, 0);
    Promise.all([Products.get(id), Products.reviews(id)])
      .then(([p, r]) => {
        setProduct(p.data); setReviews(r.data || []);
      }).catch(() => navigate('/shop'))
      .finally(() => setLoading(false));
  }, [id]);

  if (loading) return <Spinner full />;
  if (!product) return null;

  const {
    Name, Description, Price, MRP, Brand, CategoryName,
    AverageRating, ReviewsCount, StockQuantity, Tags,
    Weight, Dimensions, SKU, related = [],
  } = product;

  const images = (() => {
    try { const raw = product.ImageURLs; const a = Array.isArray(raw) ? raw : JSON.parse(raw || '[]'); return Array.isArray(a) && a.length ? a : [null]; } catch(e) { return [null]; }
  })();
  const discount = MRP > Price ? Math.round((MRP - Price) / MRP * 100) : 0;
  const inStock  = StockQuantity > 0;
  const tagList  = Tags ? Tags.split(',').map(t => t.trim()).filter(Boolean) : [];

  const handleAdd = async () => {
    if (!isAuthed) { navigate('/auth'); return; }
    setAdding(true);
    try {
      await addItem(parseInt(id), qty);
      toast(`Added to cart`, 'success');
    } catch (e) { toast(e?.error || 'Error adding to cart', 'error'); }
    finally { setAdding(false); }
  };

  const handleBuyNow = async () => {
    if (!isAuthed) { navigate('/auth'); return; }
    try { await addItem(parseInt(id), qty); navigate('/cart'); } catch {}
  };

  const handleWishlist = async () => {
    if (!isAuthed) { navigate('/auth'); return; }
    try { await Wishlist.add(parseInt(id)); toast('Added to wishlist', 'success'); } catch {}
  };

  const handleReview = async e => {
    e.preventDefault();
    if (!isAuthed) { navigate('/auth'); return; }
    setSub(true);
    try {
      await ReviewsAPI.create(id, newRev);
      toast('Review submitted for moderation', 'success');
      setNewRev({ Rating: 5, Comment: '' });
      const r = await Products.reviews(id);
      setReviews(r.data || []);
    } catch (e) { toast(e?.error || 'Could not submit review', 'error'); }
    finally { setSub(false); }
  };

  const stars = n => '*'.repeat(Math.min(5, Math.max(0, n))) + '-'.repeat(5 - Math.min(5, Math.max(0, n)));

  return (
    <div className="page-enter">
      {/* Breadcrumb */}
      <div style={{ background: 'var(--white)', borderBottom: '1px solid var(--border)', padding: '12px 0' }}>
        <div className="container" style={{ display: 'flex', gap: 8, fontSize: 13, color: 'var(--muted)', flexWrap: 'wrap' }}>
          <span style={{ cursor: 'pointer', color: 'var(--gold)' }} onClick={() => navigate('/')}>Home</span>
          <span></span>
          <span style={{ cursor: 'pointer', color: 'var(--gold)' }} onClick={() => navigate('/shop')}>Shop</span>
          {CategoryName && <><span></span><span style={{ cursor: 'pointer', color: 'var(--gold)' }} onClick={() => navigate(`/shop/${CategoryName}`)}>{CategoryName}</span></>}
          <span></span>
          <span style={{ color: 'var(--ink)' }}>{Name?.slice(0, 40)}</span>
        </div>
      </div>

      <div className="container" style={{ padding: '40px 24px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 48, marginBottom: 56 }}>

          {/*  Images  */}
          <div>
            <div style={{ background: 'var(--cream)', borderRadius: 16, overflow: 'hidden', aspectRatio: '1', marginBottom: 12, display: 'flex', alignItems: 'center', justifyContent: 'center', border: '1px solid var(--border)' }}>
              {images[imgIdx] ? (
                <img src={images[imgIdx]} alt={Name} style={{ width: '100%', height: '100%', objectFit: 'contain', padding: 16 }}/>
              ) : <div style={{ fontSize: 72 }}>[Box]</div>}
            </div>
            {images.length > 1 && (
              <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
                {images.map((img, i) => (
                  <div key={i} onClick={() => setImgIdx(i)} style={{ width: 64, height: 64, borderRadius: 8, border: `2px solid ${i === imgIdx ? 'var(--gold)' : 'var(--border)'}`, cursor: 'pointer', overflow: 'hidden', background: 'var(--cream)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    {img ? <img src={img} alt="" style={{ width: '100%', height: '100%', objectFit: 'cover' }}/> : <span style={{ fontSize: 24 }}>[Box]</span>}
                  </div>
                ))}
              </div>
            )}
          </div>

          {/*  Details  */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            {Brand && <div style={{ fontSize: 12, fontWeight: 700, color: 'var(--gold)', letterSpacing: '.1em', textTransform: 'uppercase' }}>{Brand}</div>}
            <h1 style={{ fontFamily: 'var(--display)', fontSize: 'clamp(24px,3vw,36px)', fontWeight: 600, lineHeight: 1.2 }}>{Name}</h1>

            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
              <span style={{ color: 'var(--gold)', fontSize: 16 }}>{stars(Math.round(AverageRating || 0))}</span>
              <span style={{ fontSize: 14, color: 'var(--sub)' }}>{Number(AverageRating)?.toFixed(1)} ({ReviewsCount} reviews)</span>
            </div>

            <div style={{ display: 'flex', alignItems: 'baseline', gap: 12 }}>
              <span style={{ fontSize: 34, fontWeight: 800, color: 'var(--ink)' }}>Rs.{Number(Price)?.toLocaleString('en-IN')}</span>
              {discount > 0 && <>
                <span style={{ fontSize: 18, color: 'var(--muted)', textDecoration: 'line-through' }}>Rs.{Number(MRP)?.toLocaleString('en-IN')}</span>
                <span style={{ background: 'var(--red-l)', color: 'var(--red)', fontSize: 13, fontWeight: 700, padding: '3px 10px', borderRadius: 6 }}>Save {discount}%</span>
              </>}
            </div>

            <div style={{ padding: '12px 16px', background: inStock ? 'var(--green-l)' : 'var(--red-l)', borderRadius: 8, display: 'flex', alignItems: 'center', gap: 8 }}>
              <span style={{ color: inStock ? 'var(--green)' : 'var(--red)', fontSize: 13, fontWeight: 600 }}>
                {inStock ? `OK In Stock (${StockQuantity} available)` : ' Out of Stock'}
              </span>
            </div>

            {/* Qty */}
            {inStock && (
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <span style={{ fontSize: 13, fontWeight: 600, color: 'var(--sub)' }}>Quantity:</span>
                <div style={{ display: 'flex', alignItems: 'center', border: '1.5px solid var(--border2)', borderRadius: 8, overflow: 'hidden' }}>
                  <button onClick={() => setQty(q => Math.max(1, q - 1))} style={{ width: 36, height: 36, fontSize: 18, background: 'var(--cream)', border: 'none', cursor: 'pointer', fontWeight: 700 }}></button>
                  <span style={{ width: 40, textAlign: 'center', fontSize: 15, fontWeight: 600 }}>{qty}</span>
                  <button onClick={() => setQty(q => Math.min(StockQuantity, q + 1))} style={{ width: 36, height: 36, fontSize: 18, background: 'var(--cream)', border: 'none', cursor: 'pointer', fontWeight: 700 }}>+</button>
                </div>
              </div>
            )}

            {/* Action buttons */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
              <button onClick={handleAdd} disabled={!inStock || adding} className="btn btn-navy btn-lg" style={{ justifyContent: 'center' }}>
                {adding ? 'Adding' : '[Cart] Add to Cart'}
              </button>
              <button onClick={handleBuyNow} disabled={!inStock} className="btn btn-gold btn-lg" style={{ justifyContent: 'center' }}>
                Buy Now
              </button>
              <button onClick={handleWishlist} className="btn btn-outline btn-lg" style={{ justifyContent: 'center' }}> Add to Wishlist</button>
            </div>

            {/* Meta */}
            <div style={{ borderTop: '1px solid var(--border)', paddingTop: 16, display: 'flex', flexDirection: 'column', gap: 6 }}>
              {SKU && <div style={{ fontSize: 12, color: 'var(--muted)' }}>SKU: <strong>{SKU}</strong></div>}
              {Weight && <div style={{ fontSize: 12, color: 'var(--muted)' }}>Weight: <strong>{Weight} kg</strong></div>}
              {tagList.length > 0 && (
                <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap', marginTop: 4 }}>
                  {tagList.map(t => <span key={t} className="badge badge-gray">{t}</span>)}
                </div>
              )}
            </div>
          </div>
        </div>

        {/*  Tabs: Description / Reviews  */}
        <div style={{ borderBottom: '2px solid var(--border)', display: 'flex', gap: 0, marginBottom: 32 }}>
          {[['desc', 'Description'], ['reviews', `Reviews (${reviews.length})`]].map(([key, label]) => (
            <button key={key} onClick={() => setTab(key)} style={{ padding: '12px 24px', fontSize: 14, fontWeight: 600, background: 'none', border: 'none', cursor: 'pointer', borderBottom: tab === key ? '2px solid var(--gold)' : '2px solid transparent', color: tab === key ? 'var(--gold)' : 'var(--sub)', marginBottom: -2, transition: 'all .15s' }}>
              {label}
            </button>
          ))}
        </div>

        {tab === 'desc' && (
          <div style={{ maxWidth: 720, lineHeight: 1.8, color: 'var(--sub)', fontSize: 15 }}>
            {Description || 'No description available for this product.'}
          </div>
        )}

        {tab === 'reviews' && (
          <div style={{ maxWidth: 720 }}>
            {/* Review summary */}
            <div style={{ display: 'flex', alignItems: 'center', gap: 24, marginBottom: 32, padding: 24, background: 'var(--cream)', borderRadius: 12 }}>
              <div style={{ textAlign: 'center' }}>
                <div style={{ fontSize: 48, fontWeight: 800, fontFamily: 'var(--display)' }}>{Number(AverageRating)?.toFixed(1) || ''}</div>
                <div style={{ color: 'var(--gold)', fontSize: 20 }}>{stars(Math.round(AverageRating || 0))}</div>
                <div style={{ fontSize: 12, color: 'var(--muted)' }}>{ReviewsCount} reviews</div>
              </div>
            </div>

            {/* Reviews list */}
            {reviews.slice(0, 10).map(r => (
              <div key={r.ReviewID} style={{ padding: '20px 0', borderBottom: '1px solid var(--border)' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
                  <div style={{ display: 'flex', gap: 10, alignItems: 'center' }}>
                    <div style={{ width: 36, height: 36, borderRadius: '50%', background: 'var(--navy)', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 14, fontWeight: 700 }}>{(r.CustomerName || r.FirstName || 'A')[0]}</div>
                    <div>
                      <div style={{ fontSize: 14, fontWeight: 600 }}>{r.CustomerName || r.FirstName}</div>
                      <div style={{ color: 'var(--gold)', fontSize: 13 }}>{stars(r.Rating)}</div>
                    </div>
                  </div>
                  <div style={{ fontSize: 12, color: 'var(--muted)' }}>{new Date(r.ReviewDate || r.CreatedAt).toLocaleDateString('en-IN')}</div>
                </div>
                <p style={{ fontSize: 14, color: 'var(--sub)', lineHeight: 1.6 }}>{r.Comment}</p>
              </div>
            ))}

            {/* Write review */}
            <div style={{ marginTop: 32, padding: 24, background: 'var(--cream)', borderRadius: 12 }}>
              <h4 style={{ fontSize: 16, fontWeight: 700, marginBottom: 16 }}>Write a Review</h4>
              <form onSubmit={handleReview} style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                <div>
                  <label className="input-label">Rating</label>
                  <div style={{ display: 'flex', gap: 4 }}>
                    {[1,2,3,4,5].map(n => (
                      <button key={n} type="button" onClick={() => setNewRev(r => ({ ...r, Rating: n }))} style={{ fontSize: 28, background: 'none', border: 'none', cursor: 'pointer', color: n <= newRev.Rating ? 'var(--gold)' : 'var(--dim)', transition: 'transform .1s' }}
                        onMouseEnter={e => e.currentTarget.style.transform='scale(1.2)'}
                        onMouseLeave={e => e.currentTarget.style.transform='scale(1)'}
                      >*</button>
                    ))}
                  </div>
                </div>
                <div className="input-group">
                  <label className="input-label">Your Review</label>
                  <textarea value={newRev.Comment} onChange={e => setNewRev(r => ({ ...r, Comment: e.target.value }))} className="input" rows={4} placeholder="Share your experience with this product" required style={{ resize: 'vertical' }}/>
                </div>
                <button type="submit" disabled={submitting} className="btn btn-navy" style={{ alignSelf: 'flex-start' }}>
                  {submitting ? 'Submitting' : 'Submit Review'}
                </button>
              </form>
            </div>
          </div>
        )}

        {/* Related Products */}
        {related?.length > 0 && (
          <div style={{ marginTop: 56 }}>
            <h2 className="section-title" style={{ marginBottom: 24 }}>Related <em>Products</em></h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 20 }}>
              {related.slice(0,4).map(p => <ProductCard key={p.ProductID} product={p}/>)}
            </div>
          </div>
        )}
      </div>
      <style>{`@media(max-width:768px){.container>div:first-child>div:last-child{grid-template-columns:1fr!important}}`}</style>
    </div>
  );
}
