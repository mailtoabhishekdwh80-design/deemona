// Orders.jsx
import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Orders as OrdersAPI } from '../api/index.js';
import Spinner from '../components/Spinner.jsx';

const STATUS_COLORS = {
  pending:   { bg: '#fef9c3', color: '#854d0e' },
  confirmed: { bg: '#dbeafe', color: '#1e40af' },
  processing:{ bg: '#ede9fe', color: '#5b21b6' },
  shipped:   { bg: '#d1fae5', color: '#065f46' },
  delivered: { bg: '#d1fae5', color: '#14532d' },
  cancelled: { bg: '#fee2e2', color: '#991b1b' },
  returned:  { bg: '#f3e8ff', color: '#6b21a8' },
  refunded:  { bg: '#fce7f3', color: '#9d174d' },
};

export default function Orders() {
  const [orders,  setOrders]  = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter,  setFilter]  = useState('all');

  useEffect(() => {
    OrdersAPI.list({ limit: 50 }).then(d => setOrders(d.data?.orders || [])).catch(() => []).finally(() => setLoading(false));
  }, []);

  const filtered = filter === 'all' ? orders : orders.filter(o => o.Status === filter);
  const tabs = ['all', 'pending', 'confirmed', 'shipped', 'delivered', 'cancelled'];

  if (loading) return <Spinner full />;

  return (
    <div className="page-enter">
      <div className="container" style={{ padding: '40px 24px' }}>
        <h1 style={{ fontFamily: 'var(--display)', fontSize: 36, fontWeight: 700, marginBottom: 24 }}>My <em style={{ color: 'var(--gold)', fontStyle: 'italic' }}>Orders</em></h1>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 8, borderBottom: '1px solid var(--border)', marginBottom: 24, overflowX: 'auto' }}>
          {tabs.map(t => (
            <button key={t} onClick={() => setFilter(t)} style={{ padding: '10px 20px', fontSize: 13, fontWeight: 600, background: 'none', border: 'none', borderBottom: filter === t ? '2px solid var(--gold)' : '2px solid transparent', color: filter === t ? 'var(--gold)' : 'var(--muted)', cursor: 'pointer', whiteSpace: 'nowrap', textTransform: 'capitalize' }}>
              {t === 'all' ? `All (${orders.length})` : t}
            </button>
          ))}
        </div>

        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '60px 0' }}>
            <div style={{ fontSize: 64, marginBottom: 16 }}>{'📦'}</div>
            <h3 style={{ fontSize: 20, fontFamily: 'var(--display)', marginBottom: 8 }}>No orders yet</h3>
            <Link to="/shop" className="btn btn-gold" style={{ marginTop: 12, display: 'inline-flex' }}>Start Shopping</Link>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            {filtered.map(order => {
              const sc = STATUS_COLORS[order.Status] || STATUS_COLORS.pending;
              return (
                <Link key={order.OrderID} to={`/orders/${order.OrderID}`} style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 14, padding: '20px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 16, textDecoration: 'none', transition: 'all .2s', flexWrap: 'wrap' }}
                  onMouseEnter={e => { e.currentTarget.style.boxShadow='var(--sh2)'; e.currentTarget.style.borderColor='var(--gold)'; }}
                  onMouseLeave={e => { e.currentTarget.style.boxShadow='none'; e.currentTarget.style.borderColor='var(--border)'; }}
                >
                  <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                    {(() => {
                      try {
                        const arr = typeof order.FirstImageURLs === 'string' ? JSON.parse(order.FirstImageURLs) : order.FirstImageURLs;
                        const url = Array.isArray(arr) ? arr[0] : '';
                        return url ? (
                          <div style={{ width: 56, height: 56, borderRadius: 10, overflow: 'hidden', flexShrink: 0, border: '1px solid var(--border)', background: '#f7f8f8' }}>
                            <img src={url} alt="Product" style={{ width: '100%', height: '100%', objectFit: 'cover' }} onError={e => e.target.style.display='none'}/>
                          </div>
                        ) : (
                          <div style={{ width: 56, height: 56, background: 'linear-gradient(135deg,#1B3A6B,#2d5a9e)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0, fontSize: 24 }}>{'📦'}</div>
                        );
                      } catch { return <div style={{ width: 56, height: 56, background: '#f7f8f8', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24 }}>{'📦'}</div>; }
                    })()}
                    <div>
                      <div style={{ fontSize: 15, fontWeight: 700, color: 'var(--ink)', marginBottom: 2 }}>Order #{order.OrderID}</div>
                      <div style={{ fontSize: 13, color: 'var(--muted)' }}>
                        {new Date(order.OrderDate).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' })}
                        {order.ItemCount ? ` · ${order.ItemCount} item${order.ItemCount > 1 ? 's' : ''}` : ''}
                      </div>
                    </div>
                  </div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                    <span style={{ fontSize: 17, fontWeight: 800, color: 'var(--ink)' }}>₹{order.TotalAmount?.toLocaleString('en-IN')}</span>
                    <span style={{ padding: '4px 12px', borderRadius: 100, fontSize: 12, fontWeight: 700, background: sc.bg, color: sc.color, textTransform: 'capitalize' }}>{order.Status}</span>
                    <span style={{ color: 'var(--muted)', fontSize: 18 }}>›</span>
                  </div>
                </Link>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
