import React, { useEffect, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useCart } from '../context/CartContext.jsx';
import { useAuth } from '../context/AuthContext.jsx';
import { useToast } from '../context/ToastContext.jsx';
import { Orders, Payments, Addresses } from '../api/index.js';

const PAYMENT_METHODS = [
  { value: 'upi',         label: 'UPI',              icon: '[Phone]', desc: 'PhonePe, GPay, Paytm' },
  { value: 'credit_card', label: 'Credit Card',      icon: '[Card]', desc: 'Visa, Mastercard, Amex' },
  { value: 'debit_card',  label: 'Debit Card',       icon: '[Card]', desc: 'All bank debit cards' },
  { value: 'net_banking', label: 'Net Banking',       icon: '🏦', desc: 'All major banks' },
  { value: 'cod',         label: 'Cash on Delivery',  icon: '💵', desc: '+₹29 handling fee' },
];

function loadRazorpay() {
  return new Promise(resolve => {
    if (window.Razorpay) { resolve(true); return; }
    const s = document.createElement('script');
    s.src = 'https://checkout.razorpay.com/v1/checkout.js';
    s.onload  = () => resolve(true);
    s.onerror = () => resolve(false);
    document.head.appendChild(s);
  });
}

export default function Checkout() {
  const navigate  = useNavigate();
  const location  = useLocation();
  const { user }  = useAuth();
  const { items, summary, clearCart } = useCart();
  const { add: toast } = useToast();

  const [addresses, setAddresses] = useState([]);
  const [selAddr,   setSelAddr]   = useState(null);
  const [payMethod, setPayMethod] = useState('upi');
  const [placing,   setPlacing]   = useState(false);
  const [newAddr,   setNewAddr]   = useState(false);
  const [addr, setAddr] = useState({ fullName: '', phone: '', line1: '', city: '', state: '', pinCode: '', country: 'India' });

  const discount  = location.state?.discount;
  const discAmt   = discount?.discountAmount || discount?.savings || 0;
  const subtotal  = summary.subtotal || 0;
  const shipping  = subtotal >= 499 ? 0 : 49;
  const total     = Math.max(0, subtotal - discAmt) + shipping + (payMethod === 'cod' ? 29 : 0);

  useEffect(() => {
    Addresses.list().then(d => {
      const list = d.data || [];
      setAddresses(list);
      const def = list.find(a => a.IsDefault) || list[0];
      if (def) setSelAddr(def.AddressID);
      else setNewAddr(true);
    }).catch(() => setNewAddr(true));
  }, []);

  const placeOrder = async () => {
    if (!selAddr && !newAddr) { toast('Select a delivery address', 'error'); return; }
    if (items.length === 0)   { toast('Your cart is empty', 'error'); return; }

    setPlacing(true);
    try {
      const shippingAddress = selAddr
        ? (() => { const a = addresses.find(x => x.AddressID === selAddr); return JSON.stringify(a); })()
        : JSON.stringify(addr);

      // 1. Place order
      const orderRes = await Orders.place({
        items:           items.map(i => ({ productID: i.ProductID, quantity: i.Quantity })),
        shippingAddress,
        paymentMethod:   payMethod,
        ...(discount?.couponCode && { couponCode: discount.couponCode }),
        shippingOption:  'standard',
      });
      const orderData = orderRes.data;
      const orderID   = orderData.orderID;

      if (payMethod === 'cod') {
        clearCart();
        toast('Order placed! Pay on delivery.', 'success');
        navigate(`/orders/${orderID}`);
        return;
      }

      // 2. Initiate gateway payment
      const payRes    = await Payments.initiate({ orderID, gateway: 'razorpay' });
      const payData   = payRes.data;

      const loaded = await loadRazorpay();
      if (!loaded) { toast('Payment gateway unavailable. Try again.', 'error'); setPlacing(false); return; }

      // 3. Open Razorpay modal
      const rzp = new window.Razorpay({
        key:         payData.keyID || import.meta.env.VITE_RAZORPAY_KEY_ID,
        order_id:    payData.gatewayOrderID,
        amount:      Math.round(total * 100),
        currency:    'INR',
        name:        'Deemona',
        description: `Order #${orderID}`,
        prefill:     payData.prefill || { name: user?.FirstName, email: user?.Email, contact: user?.PhoneNumber },
        theme:       { color: '#c9973a' },

        handler: async response => {
          try {
            // 4. Verify signature server-side
            await Payments.verify({
              orderID,
              gateway:          'razorpay',
              gatewayOrderID:   response.razorpay_order_id,
              gatewayPaymentID: response.razorpay_payment_id,
              signature:        response.razorpay_signature,
            });
            clearCart();
            toast('Payment successful! Order confirmed.', 'success');
            navigate(`/orders/${orderID}`);
          } catch (e) {
            toast(e?.error || 'Payment verification failed', 'error');
            navigate(`/orders/${orderID}`);
          }
        },

        modal: { ondismiss: () => { setPlacing(false); toast('Payment cancelled', 'info'); } }
      });

      rzp.on('payment.failed', e => {
        toast(`Payment failed: ${e.error?.description || 'Unknown error'}`, 'error');
        setPlacing(false);
      });

      rzp.open();

    } catch (e) {
      toast(e?.error || 'Could not place order', 'error');
      setPlacing(false);
    }
  };

  return (
    <div className="page-enter">
      <div className="container" style={{ padding: '40px 24px' }}>
        <h1 style={{ fontFamily: 'var(--display)', fontSize: 36, fontWeight: 700, marginBottom: 32 }}>
          Secure <em style={{ color: 'var(--gold)', fontStyle: 'italic' }}>Checkout</em>
        </h1>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 380px', gap: 32, alignItems: 'start' }}>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 24 }}>

            {/* Delivery address */}
            <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
              <h3 style={{ fontSize: 17, fontWeight: 700, marginBottom: 16 }}>Delivery Address</h3>

              {addresses.map(a => (
                <label key={a.AddressID} style={{ display: 'flex', alignItems: 'flex-start', gap: 12, padding: '14px 0', borderBottom: '1px solid var(--border)', cursor: 'pointer' }}>
                  <input type="radio" name="addr" checked={selAddr === a.AddressID && !newAddr} onChange={() => { setSelAddr(a.AddressID); setNewAddr(false); }} style={{ accentColor: 'var(--gold)', marginTop: 3 }}/>
                  <div>
                    <div style={{ fontSize: 14, fontWeight: 600 }}>{a.FullName} <span className="badge badge-gray" style={{ fontSize: 10 }}>{a.AddressType}</span></div>
                    <div style={{ fontSize: 13, color: 'var(--sub)', marginTop: 2 }}>{a.Line1}{a.Line2 ? ', ' + a.Line2 : ''}, {a.City}, {a.State} — {a.PinCode}</div>
                    <div style={{ fontSize: 13, color: 'var(--muted)' }}>{a.Phone}</div>
                  </div>
                </label>
              ))}

              <label style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '14px 0', cursor: 'pointer' }}>
                <input type="radio" name="addr" checked={newAddr} onChange={() => { setNewAddr(true); setSelAddr(null); }} style={{ accentColor: 'var(--gold)' }}/>
                <span style={{ fontSize: 14, fontWeight: 600, color: 'var(--gold)' }}>+ Add New Address</span>
              </label>

              {newAddr && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12, marginTop: 12 }}>
                  {[['fullName','Full Name',''], ['phone','Phone Number',''], ['line1','Address Line 1',''], ['city','City',''], ['state','State',''], ['pinCode','PIN Code','']].map(([k,p]) => (
                    <div key={k} className="input-group" style={{ gridColumn: k === 'line1' ? 'span 2' : 'auto' }}>
                      <label className="input-label">{p}</label>
                      <input value={addr[k]} onChange={e => setAddr(a => ({ ...a, [k]: e.target.value }))} className="input" placeholder={p} required/>
                    </div>
                  ))}
                </div>
              )}
            </div>

            {/* Payment method */}
            <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24 }}>
              <h3 style={{ fontSize: 17, fontWeight: 700, marginBottom: 16 }}>Payment Method</h3>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 0 }}>
                {PAYMENT_METHODS.map(m => (
                  <label key={m.value} style={{ display: 'flex', alignItems: 'center', gap: 14, padding: '14px 0', borderBottom: '1px solid var(--border)', cursor: 'pointer', transition: 'background .1s' }}>
                    <input type="radio" name="pay" value={m.value} checked={payMethod === m.value} onChange={() => setPayMethod(m.value)} style={{ accentColor: 'var(--gold)', width: 18, height: 18 }}/>
                    <span style={{ fontSize: 20 }}>{m.icon}</span>
                    <div>
                      <div style={{ fontSize: 14, fontWeight: 600 }}>{m.label}</div>
                      <div style={{ fontSize: 12, color: 'var(--muted)' }}>{m.desc}</div>
                    </div>
                  </label>
                ))}
              </div>
            </div>
          </div>

          {/* Order summary */}
          <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, padding: 24, position: 'sticky', top: 100 }}>
            <h3 style={{ fontSize: 17, fontWeight: 700, marginBottom: 16 }}>Order Summary</h3>

            <div style={{ display: 'flex', flexDirection: 'column', gap: 0, marginBottom: 20, maxHeight: 240, overflowY: 'auto' }}>
              {items.map(item => (
                <div key={item.CartItemID} style={{ display: 'flex', gap: 12, padding: '10px 0', borderBottom: '1px solid var(--border)', fontSize: 13 }}>
                  <div style={{ flex: 1, color: 'var(--ink)', fontWeight: 500 }}>{item.ProductName || item.Name}</div>
                  <div style={{ fontWeight: 600, whiteSpace: 'nowrap' }}>×{item.Quantity} · ₹{((item.Price || item.UnitPrice) * item.Quantity)?.toLocaleString('en-IN')}</div>
                </div>
              ))}
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
              {[
                ['Subtotal', `₹${subtotal.toLocaleString('en-IN')}`],
                ['Shipping', shipping === 0 ? '🆓 Free' : `₹${shipping}`],
                ...(discAmt > 0 ? [['Discount', `-₹${discAmt.toLocaleString('en-IN')}`]] : []),
                ...(payMethod === 'cod' ? [['COD handling', '₹29']] : []),
              ].map(([k, v]) => (
                <div key={k} style={{ display: 'flex', justifyContent: 'space-between', fontSize: 14 }}>
                  <span style={{ color: 'var(--sub)' }}>{k}</span>
                  <span style={{ fontWeight: 600, color: k === 'Discount' ? 'var(--green)' : 'inherit' }}>{v}</span>
                </div>
              ))}
              <div style={{ borderTop: '2px solid var(--border)', paddingTop: 12, display: 'flex', justifyContent: 'space-between', fontSize: 18, fontWeight: 800 }}>
                <span>Total</span>
                <span>₹{total.toLocaleString('en-IN')}</span>
              </div>
            </div>

            <button onClick={placeOrder} disabled={placing} className="btn btn-gold btn-lg" style={{ width: '100%', justifyContent: 'center', marginTop: 20 }}>
              {placing ? 'Processing…' : payMethod === 'cod' ? 'OK Place Order (COD)' : `[Lock] Pay ₹${total.toLocaleString('en-IN')}`}
            </button>

            <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginTop: 16, flexWrap: 'wrap' }}>
              {['UPI','Visa','Mastercard','RuPay'].map(p => <span key={p} style={{ fontSize: 10, padding: '2px 6px', background: 'var(--cream)', borderRadius: 4, color: 'var(--muted)', fontWeight: 600 }}>{p}</span>)}
            </div>
            <p style={{ fontSize: 11, color: 'var(--muted)', textAlign: 'center', marginTop: 10 }}>
              [Lock] Secured by Razorpay. Your payment info is never stored.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
