import React, { useEffect, useState, useCallback } from 'react';
import { Orders as OrdersAPI } from '../../api/index.js';
import { useToast } from '../../context/ToastContext.jsx';
import Spinner from '../../components/Spinner.jsx';

const STATUSES = ['pending','confirmed','processing','shipped','delivered','cancelled'];
const STATUS_COLORS = {
  pending: { bg: '#fef9c3', color: '#854d0e' }, confirmed: { bg: '#dbeafe', color: '#1e40af' },
  processing: { bg: '#ede9fe', color: '#5b21b6' }, shipped: { bg: '#cffafe', color: '#155e75' },
  delivered: { bg: '#d1fae5', color: '#065f46' }, cancelled: { bg: '#fee2e2', color: '#991b1b' },
};

export default function AdminOrders() {
  const { add: toast } = useToast();
  const [orders,  setOrders]  = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter,  setFilter]  = useState('all');
  const [page,    setPage]    = useState(1);
  const [total,   setTotal]   = useState(0);
  const [updating,setUpdating]= useState(null);
  const LIMIT = 25;

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const d = await OrdersAPI.adminList({
        page, limit: LIMIT,
        ...(filter !== 'all' && { status: filter }),
      });
      setOrders(d.data?.orders || []);
      setTotal(d.data?.pagination?.total || 0);
    } catch { toast('Failed to load orders', 'error'); }
    finally { setLoading(false); }
  }, [page, filter]);

  useEffect(() => { setPage(1); }, [filter]);
  useEffect(() => { load(); }, [load]);

  const updateStatus = async (orderId, status) => {
    setUpdating(orderId);
    try {
      await OrdersAPI.adminUpdate(orderId, { status });
      toast(`Order #${orderId} → ${status}`, 'success');
      load();
    } catch (e) { toast(e?.error || 'Update failed', 'error'); }
    finally { setUpdating(null); }
  };

  return (
    <div className="page-enter">
      <div style={{ marginBottom: 24 }}>
        <h1 style={{ fontFamily: 'var(--display)', fontSize: 28, fontWeight: 700 }}>Orders</h1>
        <p style={{ fontSize: 13, color: 'var(--muted)', marginTop: 2 }}>{total.toLocaleString('en-IN')} total orders</p>
      </div>

      {/* Status filter tabs */}
      <div style={{ display: 'flex', gap: 6, marginBottom: 20, overflowX: 'auto', paddingBottom: 4 }}>
        {['all', ...STATUSES].map(s => (
          <button key={s} onClick={() => setFilter(s)} style={{
            padding: '7px 16px', borderRadius: 100, fontSize: 12, fontWeight: 600,
            border: filter === s ? 'none' : '1px solid var(--border)',
            background: filter === s ? (STATUS_COLORS[s]?.bg || 'var(--navy)') : 'var(--white)',
            color: filter === s ? (STATUS_COLORS[s]?.color || 'var(--white)') : 'var(--muted)',
            cursor: 'pointer', whiteSpace: 'nowrap', textTransform: 'capitalize',
          }}>{s === 'all' ? `All (${total})` : s}</button>
        ))}
      </div>

      {loading ? <Spinner full /> : (
        <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden' }}>
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: 800 }}>
              <thead>
                <tr style={{ background: 'var(--cream)' }}>
                  {['Order #', 'Customer', 'Items', 'Amount', 'Payment', 'Status', 'Date', 'Actions'].map(h => (
                    <th key={h} style={{ padding: '12px 16px', fontSize: 11, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '.07em', color: 'var(--muted)', textAlign: 'left', borderBottom: '1px solid var(--border)', whiteSpace: 'nowrap' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {orders.length === 0 ? (
                  <tr><td colSpan={8} style={{ padding: '40px', textAlign: 'center', color: 'var(--muted)' }}>No orders found</td></tr>
                ) : orders.map((o, i) => {
                  const sc = STATUS_COLORS[o.Status] || { bg: '#f3f4f6', color: '#6b7280' };
                  return (
                    <tr key={o.OrderID} style={{ borderBottom: '1px solid var(--border)', background: i % 2 ? 'var(--cream)' : 'var(--white)' }}>
                      <td style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--gold)', fontSize: 14 }}>#{o.OrderID}</td>
                      <td style={{ padding: '12px 16px' }}>
                        <div style={{ fontSize: 13, fontWeight: 600 }}>{o.CustomerName || (o.FirstName + ' ' + o.LastName)}</div>
                        <div style={{ fontSize: 11, color: 'var(--muted)' }}>{o.Email}</div>
                      </td>
                      <td style={{ padding: '12px 16px', fontSize: 13, color: 'var(--sub)' }}>{o.ItemCount || '—'}</td>
                      <td style={{ padding: '12px 16px', fontSize: 14, fontWeight: 700 }}>₹{o.TotalAmount?.toLocaleString('en-IN')}</td>
                      <td style={{ padding: '12px 16px', fontSize: 12 }}>
                        <span style={{ textTransform: 'capitalize', color: 'var(--sub)' }}>{o.PaymentMethod?.replace(/_/g, ' ')}</span>
                      </td>
                      <td style={{ padding: '12px 16px' }}>
                        <span style={{ padding: '3px 10px', borderRadius: 100, fontSize: 11, fontWeight: 700, background: sc.bg, color: sc.color, textTransform: 'capitalize' }}>{o.Status}</span>
                      </td>
                      <td style={{ padding: '12px 16px', fontSize: 12, color: 'var(--muted)', whiteSpace: 'nowrap' }}>
                        {new Date(o.OrderDate).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: '2-digit' })}
                      </td>
                      <td style={{ padding: '12px 16px' }}>
                        <select
                          value={o.Status}
                          onChange={e => updateStatus(o.OrderID, e.target.value)}
                          disabled={updating === o.OrderID || ['delivered','cancelled'].includes(o.Status)}
                          style={{ fontSize: 12, padding: '5px 8px', border: '1px solid var(--border)', borderRadius: 6, background: 'var(--white)', cursor: 'pointer', color: 'var(--ink)' }}
                        >
                          {STATUSES.map(s => <option key={s} value={s} style={{ textTransform: 'capitalize' }}>{s}</option>)}
                        </select>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>

          {Math.ceil(total / LIMIT) > 1 && (
            <div style={{ display: 'flex', justifyContent: 'center', gap: 8, padding: '16px', borderTop: '1px solid var(--border)' }}>
              <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1} className="btn btn-outline btn-sm">← Prev</button>
              <span style={{ padding: '8px 16px', fontSize: 13, color: 'var(--muted)' }}>Page {page} of {Math.ceil(total / LIMIT)}</span>
              <button onClick={() => setPage(p => p + 1)} disabled={page >= Math.ceil(total / LIMIT)} className="btn btn-outline btn-sm">Next →</button>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
