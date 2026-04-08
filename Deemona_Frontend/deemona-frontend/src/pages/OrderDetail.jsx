// OrderDetail.jsx
import React, { useEffect, useState } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { Orders as OrdersAPI, Shipping } from '../api/index.js';
import { useToast } from '../context/ToastContext.jsx';
import Spinner from '../components/Spinner.jsx';

export default function OrderDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { add: toast } = useToast();
  const [order,   setOrder]   = useState(null);
  const [loading, setLoading] = useState(true);
  const [cancelling, setCancel] = useState(false);

  useEffect(() => {
    OrdersAPI.get(id).then(d => setOrder(d.data)).catch(() => navigate('/orders')).finally(() => setLoading(false));
  }, [id]);

  if (loading) return <Spinner full />;
  if (!order)  return null;

  const { items = [], payment, shipping } = order;

  const handleCancel = async () => {
    setCancel(true);
    try {
      await OrdersAPI.cancel(id);
      toast('Order cancelled', 'success');
      const d = await OrdersAPI.get(id);
      setOrder(d.data);
    } catch (e) { toast(e?.error || 'Cannot cancel', 'error'); }
    finally { setCancel(false); }
  };

  const STATUS_STEPS = ['pending','confirmed','processing','shipped','delivered'];
  const stepIdx = STATUS_STEPS.indexOf(order.Status);

  return (
    <div className="page-enter">
      <div className="container" style={{ padding: '40px 24px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 32 }}>
          <button onClick={() => navigate('/orders')} style={{ background: 'none', border: 'none', cursor: 'pointer', color: 'var(--gold)', fontSize: 14, fontWeight: 600 }}>← My Orders</button>
          <span style={{ color: 'var(--muted)' }}>›</span>
          <span style={{ fontSize: 14, color: 'var(--sub)' }}>Order #{id}</span>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 340px', gap: 32 }}>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 24 }}>

            {/* Progress tracker */}
            {!['cancelled','returned','refunded'].includes(order.Status) && (
              <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
                <h3 style={{ fontSize: 15, fontWeight: 700, marginBottom: 20 }}>Order Progress</h3>
                <div style={{ display: 'flex', justifyContent: 'space-between', position: 'relative' }}>
                  <div style={{ position: 'absolute', top: 16, left: '10%', right: '10%', height: 2, background: 'var(--border)', zIndex: 0 }}>
                    <div style={{ height: '100%', background: 'var(--gold)', width: `${(stepIdx / (STATUS_STEPS.length - 1)) * 100}%`, transition: 'width .5s ease' }}/>
                  </div>
                  {STATUS_STEPS.map((s, i) => (
                    <div key={s} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 8, position: 'relative', zIndex: 1 }}>
                      <div style={{ width: 32, height: 32, borderRadius: '50%', background: i <= stepIdx ? 'var(--gold)' : 'var(--cream)', border: `2px solid ${i <= stepIdx ? 'var(--gold)' : 'var(--border)'}`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 14, transition: 'all .3s' }}>
                        {i < stepIdx ? 'OK' : i === stepIdx ? '●' : '○'}
                      </div>
                      <span style={{ fontSize: 11, fontWeight: 600, color: i <= stepIdx ? 'var(--gold)' : 'var(--muted)', textTransform: 'capitalize', textAlign: 'center' }}>{s}</span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Items */}
            <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
              <h3 style={{ fontSize: 15, fontWeight: 700, marginBottom: 16 }}>Items Ordered</h3>
              {items.map(item => (
                <div key={item.OrderItemID || item.ProductID} style={{ display: 'flex', gap: 14, padding: '12px 0', borderBottom: '1px solid var(--border)' }}>
                  <div style={{ width: 60, height: 60, background: 'var(--cream)', borderRadius: 8, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 24, border: '1px solid var(--border)', flexShrink: 0 }}>[Box]</div>
                  <div style={{ flex: 1 }}>
                    <Link to={`/product/${item.ProductID}`} style={{ fontSize: 14, fontWeight: 600, color: 'var(--ink)', display: 'block', marginBottom: 2 }}>{item.ProductName || item.Name}</Link>
                    <div style={{ fontSize: 12, color: 'var(--muted)' }}>Qty: {item.Quantity} · ₹{item.UnitPrice?.toLocaleString('en-IN')} each</div>
                  </div>
                  <div style={{ fontWeight: 700, fontSize: 14 }}>₹{(item.Quantity * item.UnitPrice)?.toLocaleString('en-IN')}</div>
                </div>
              ))}
            </div>

            {/* Shipping */}
            {shipping && (
              <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
                <h3 style={{ fontSize: 15, fontWeight: 700, marginBottom: 12 }}>Shipping Details</h3>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12, fontSize: 14 }}>
                  <div><span style={{ color: 'var(--muted)' }}>Carrier:</span> <strong>{shipping.Carrier || '—'}</strong></div>
                  <div><span style={{ color: 'var(--muted)' }}>Status:</span> <strong style={{ textTransform: 'capitalize' }}>{shipping.ShippingStatus}</strong></div>
                  <div><span style={{ color: 'var(--muted)' }}>Tracking #:</span> <strong>{shipping.TrackingNumber || '—'}</strong></div>
                  <div><span style={{ color: 'var(--muted)' }}>Est. Delivery:</span> <strong>{shipping.EstimatedDeliveryDate ? new Date(shipping.EstimatedDeliveryDate).toLocaleDateString('en-IN') : '—'}</strong></div>
                </div>
              </div>
            )}
          </div>

          {/* Sidebar */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
            <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
              <h3 style={{ fontSize: 15, fontWeight: 700, marginBottom: 12 }}>Order Summary</h3>
              {[
                ['Order ID',    `#${order.OrderID}`],
                ['Date',        new Date(order.OrderDate).toLocaleDateString('en-IN')],
                ['Status',      order.Status],
                ['Payment',     order.PaymentMethod || '—'],
                ['Subtotal',    `₹${order.SubTotal?.toLocaleString('en-IN') || 0}`],
                ['Shipping',    order.ShippingAmount === 0 ? 'Free' : `₹${order.ShippingAmount}`],
                ['Discount',    order.DiscountAmount > 0 ? `-₹${order.DiscountAmount?.toLocaleString('en-IN')}` : '—'],
                ['Total',       `₹${order.TotalAmount?.toLocaleString('en-IN')}`],
              ].map(([k, v]) => (
                <div key={k} style={{ display: 'flex', justifyContent: 'space-between', padding: '7px 0', borderBottom: '1px solid var(--border)', fontSize: 13 }}>
                  <span style={{ color: 'var(--muted)' }}>{k}</span>
                  <span style={{ fontWeight: k === 'Total' ? 700 : 500, textTransform: k === 'Status' ? 'capitalize' : 'none', fontSize: k === 'Total' ? 15 : 13 }}>{v}</span>
                </div>
              ))}
            </div>

            {['pending','confirmed'].includes(order.Status) && (
              <button onClick={handleCancel} disabled={cancelling} className="btn btn-danger" style={{ width: '100%', justifyContent: 'center' }}>
                {cancelling ? 'Cancelling…' : 'Cancel Order'}
              </button>
            )}

            {order.Status === 'delivered' && (
              <Link to={`/product/${items[0]?.ProductID}`} className="btn btn-outline" style={{ textAlign: 'center', justifyContent: 'center' }}>
                Write a Review
              </Link>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
