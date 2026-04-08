// Customers.jsx
import React, { useEffect, useState, useCallback } from 'react';
import { Customers as CustomersAPI } from '../../api/index.js';
import { useToast } from '../../context/ToastContext.jsx';
import Spinner from '../../components/Spinner.jsx';

const TIER_COLORS = { Platinum: '#7c3aed', Gold: '#b45309', Silver: '#64748b', Bronze: '#92400e' };

export default function AdminCustomers() {
  const { add: toast } = useToast();
  const [customers, setCustomers] = useState([]);
  const [loading,   setLoading]   = useState(true);
  const [search,    setSearch]    = useState('');
  const [page,      setPage]      = useState(1);
  const [total,     setTotal]     = useState(0);
  const LIMIT = 25;

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const d = await CustomersAPI.list({ page, limit: LIMIT, search: search || undefined });
      setCustomers(d.data?.customers || []);
      setTotal(d.data?.pagination?.total || 0);
    } catch { toast('Failed to load customers', 'error'); }
    finally { setLoading(false); }
  }, [page, search]);

  useEffect(() => { setPage(1); }, [search]);
  useEffect(() => { load(); }, [load]);

  const toggleStatus = async (id, current) => {
    const newStatus = current === 'active' ? 'suspended' : 'active';
    try {
      await CustomersAPI.updateStatus(id, { status: newStatus });
      toast(`Customer ${newStatus}`, 'success');
      load();
    } catch (e) { toast(e?.error || 'Update failed', 'error'); }
  };

  return (
    <div className="page-enter">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24, flexWrap: 'wrap', gap: 12 }}>
        <div>
          <h1 style={{ fontFamily: 'var(--display)', fontSize: 28, fontWeight: 700 }}>Customers</h1>
          <p style={{ fontSize: 13, color: 'var(--muted)', marginTop: 2 }}>{total.toLocaleString('en-IN')} registered accounts</p>
        </div>
        <input value={search} onChange={e => setSearch(e.target.value)} className="input" placeholder="Search by name or email…" style={{ width: 260, fontSize: 13 }}/>
      </div>

      {loading ? <Spinner full /> : (
        <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', minWidth: 700 }}>
            <thead>
              <tr style={{ background: 'var(--cream)' }}>
                {['Customer', 'Email', 'Phone', 'Points', 'Tier', 'Status', 'Joined', 'Action'].map(h => (
                  <th key={h} style={{ padding: '12px 16px', fontSize: 11, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '.07em', color: 'var(--muted)', textAlign: 'left', borderBottom: '1px solid var(--border)', whiteSpace: 'nowrap' }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {customers.length === 0 ? (
                <tr><td colSpan={8} style={{ padding: '40px', textAlign: 'center', color: 'var(--muted)' }}>No customers found</td></tr>
              ) : customers.map((c, i) => (
                <tr key={c.CustomerID} style={{ borderBottom: '1px solid var(--border)', background: i % 2 ? 'var(--cream)' : 'var(--white)' }}>
                  <td style={{ padding: '12px 16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                      <div style={{ width: 34, height: 34, borderRadius: '50%', background: 'var(--navy)', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 13, fontWeight: 700, flexShrink: 0 }}>{(c.FirstName || 'U')[0]}</div>
                      <div style={{ fontSize: 13, fontWeight: 600 }}>{c.FirstName} {c.LastName}</div>
                    </div>
                  </td>
                  <td style={{ padding: '12px 16px', fontSize: 13, color: 'var(--sub)' }}>{c.Email}</td>
                  <td style={{ padding: '12px 16px', fontSize: 13, color: 'var(--muted)' }}>{c.PhoneNumber || '—'}</td>
                  <td style={{ padding: '12px 16px', fontSize: 13, fontWeight: 600, color: 'var(--amber)' }}>{c.LoyaltyPoints?.toLocaleString('en-IN') || 0}</td>
                  <td style={{ padding: '12px 16px' }}>
                    <span style={{ fontSize: 12, fontWeight: 700, color: TIER_COLORS[c.LoyaltyTier] || '#6b7280' }}>{c.LoyaltyTier || 'Bronze'}</span>
                  </td>
                  <td style={{ padding: '12px 16px' }}>
                    <span style={{ padding: '3px 10px', borderRadius: 100, fontSize: 11, fontWeight: 700, background: c.AccountStatus === 'active' ? 'var(--green-l)' : 'var(--red-l)', color: c.AccountStatus === 'active' ? 'var(--green)' : 'var(--red)', textTransform: 'capitalize' }}>
                      {c.AccountStatus}
                    </span>
                  </td>
                  <td style={{ padding: '12px 16px', fontSize: 12, color: 'var(--muted)', whiteSpace: 'nowrap' }}>
                    {new Date(c.RegistrationDate).toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: '2-digit' })}
                  </td>
                  <td style={{ padding: '12px 16px' }}>
                    <button onClick={() => toggleStatus(c.CustomerID, c.AccountStatus)}
                      style={{ fontSize: 11, padding: '5px 12px', borderRadius: 6, border: '1px solid var(--border)', background: 'transparent', cursor: 'pointer', fontWeight: 600, color: c.AccountStatus === 'active' ? 'var(--red)' : 'var(--green)' }}>
                      {c.AccountStatus === 'active' ? 'Suspend' : 'Activate'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

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
