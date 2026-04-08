import React, { useEffect, useState, useCallback } from 'react';
import { Products, Categories } from '../../api/index.js';
import { useToast } from '../../context/ToastContext.jsx';
import Spinner from '../../components/Spinner.jsx';

const EMPTY = { Name: '', Description: '', SKU: '', Brand: '', CategoryID: '', Price: '', MRP: '', CostPrice: '', StockQuantity: '', ReorderLevel: 10, Tags: '', Weight: '', IsFeatured: false, ImageURL: '' };

function Modal({ title, onClose, children }) {
  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,.75)', zIndex: 2000, display: 'flex', alignItems: 'flex-start', justifyContent: 'center', padding: '40px 20px', overflowY: 'auto' }}
      onClick={e => e.target === e.currentTarget && onClose()}>
      <div style={{ background: '#ffffff', borderRadius: 16, width: '100%', maxWidth: 700, boxShadow: '0 32px 64px rgba(0,0,0,.4)', flexShrink: 0 }}>
        <div style={{ padding: '20px 28px', borderBottom: '1px solid #e5e7eb', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <h3 style={{ fontSize: 17, fontWeight: 700, color: '#111827', margin: 0 }}>{title}</h3>
          <button onClick={onClose} style={{ width: 32, height: 32, borderRadius: '50%', background: '#f3f4f6', border: 'none', cursor: 'pointer', fontSize: 18, color: '#6b7280', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>x</button>
        </div>
        <div style={{ padding: '24px 28px', background: '#ffffff', borderRadius: '0 0 16px 16px', color: '#111827' }}>{children}</div>
      </div>
    </div>
  );
}

export default function AdminProducts() {
  const { add: toast } = useToast();
  const [products,   setProducts]   = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading,    setLoading]    = useState(true);
  const [modal,      setModal]      = useState(null); // null | 'create' | 'edit'
  const [editing,    setEditing]    = useState(null);
  const [form,       setForm]       = useState(EMPTY);
  const [saving,     setSaving]     = useState(false);
  const [search,     setSearch]     = useState('');
  const [page,       setPage]       = useState(1);
  const [total,      setTotal]      = useState(0);
  const LIMIT = 20;

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const [p, c] = await Promise.all([
        Products.list({ page, limit: LIMIT, search: search || undefined }),
        Categories.list(),
      ]);
      setProducts(p.data?.products || []);
      setTotal(p.data?.pagination?.total || 0);
      setCategories(c.data || []);
    } catch { toast('Failed to load products', 'error'); }
    finally { setLoading(false); }
  }, [page, search]);

  useEffect(() => { load(); }, [load]);

  const openCreate = () => { setForm(EMPTY); setEditing(null); setModal('create'); };
  const openEdit = p => {
    let imageURL = '';
    try { const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs; imageURL = Array.isArray(arr) ? arr[0] || '' : ''; } catch {}
    setForm({ ...p, IsFeatured: !!p.IsFeatured, ImageURL: imageURL });
    setEditing(p.ProductID); setModal('edit');
  };
  const closeModal = () => { setModal(null); setEditing(null); };

  const handleSave = async e => {
    e.preventDefault(); setSaving(true);
    try {
      const payload = {
        ...form,
        Price:         parseFloat(form.Price),
        MRP:           parseFloat(form.MRP),
        CostPrice:     parseFloat(form.CostPrice),
        StockQuantity: parseInt(form.StockQuantity),
        ReorderLevel:  parseInt(form.ReorderLevel),
        CategoryID:    parseInt(form.CategoryID),
        Weight:        form.Weight ? parseFloat(form.Weight) : undefined,
        ImageURLs:     form.ImageURL ? JSON.stringify([form.ImageURL]) : undefined,
      };
      if (editing) {
        await Products.update(editing, payload);
        toast('Product updated', 'success');
      } else {
        await Products.create(payload);
        toast('Product created', 'success');
      }
      closeModal(); load();
    } catch (e) { toast(e?.error || 'Save failed', 'error'); }
    finally { setSaving(false); }
  };

  const handleDelete = async id => {
    if (!confirm('Delete this product?')) return;
    try { await Products.remove(id); toast('Deleted', 'success'); load(); }
    catch (e) { toast(e?.error || 'Delete failed', 'error'); }
  };

  const upd = k => e => setForm(f => ({ ...f, [k]: e.target.type === 'checkbox' ? e.target.checked : e.target.value }));

  return (
    <div className="page-enter">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24, flexWrap: 'wrap', gap: 12 }}>
        <div>
          <h1 style={{ fontFamily: 'var(--display)', fontSize: 28, fontWeight: 700 }}>Products</h1>
          <p style={{ fontSize: 13, color: 'var(--muted)', marginTop: 2 }}>{total.toLocaleString('en-IN')} total products</p>
        </div>
        <div style={{ display: 'flex', gap: 10 }}>
          <input value={search} onChange={e => { setSearch(e.target.value); setPage(1); }} className="input" placeholder="Search products…" style={{ width: 220, fontSize: 13 }}/>
          <button onClick={openCreate} style={{ padding: "10px 20px", background: "#F0C14B", color: "#111", border: "none", borderRadius: 8, fontSize: 13, fontWeight: 700, cursor: "pointer", boxShadow: "0 2px 8px rgba(240,193,75,.4)" }}>+ Add Product</button>
        </div>
      </div>

      {loading ? <Spinner full /> : (
        <>
          <div style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 16, overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ background: 'var(--cream)' }}>
                  {['', 'Product', 'SKU', 'Category', 'Price', 'Stock', 'Status', 'Actions'].map(h => (
                    <th key={h} style={{ padding: '12px 16px', fontSize: 11, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '.08em', color: 'var(--muted)', textAlign: 'left', borderBottom: '1px solid var(--border)', whiteSpace: 'nowrap' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {products.length === 0 ? (
                  <tr><td colSpan={7} style={{ padding: '40px', textAlign: 'center', color: 'var(--muted)' }}>No products found</td></tr>
                ) : products.map((p, i) => (
                  <tr key={p.ProductID} style={{ borderBottom: '1px solid var(--border)', background: i % 2 ? 'var(--cream)' : 'var(--white)' }}>
                    <td style={{ padding: '10px 16px', width: 60 }}>
                      {(() => { try { const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs; const url = Array.isArray(arr) ? arr[0] : ''; return url ? <img src={url} alt={p.Name} style={{ width: 48, height: 48, objectFit: 'cover', borderRadius: 8, border: '1px solid var(--border)' }} onError={e => e.target.style.display='none'}/> : <div style={{ width: 48, height: 48, borderRadius: 8, background: 'var(--cream)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 20 }}>{'?'}</div>; } catch { return null; } })()}
                    </td>
                    <td style={{ padding: '10px 16px' }}>
                      <div style={{ fontSize: 13, fontWeight: 600, maxWidth: 200, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>{p.Name}</div>
                      {p.Brand && <div style={{ fontSize: 11, color: 'var(--muted)' }}>{p.Brand}</div>}
                    </td>
                    <td style={{ padding: '12px 16px', fontSize: 12, fontFamily: 'var(--mono)', color: 'var(--muted)' }}>{p.SKU}</td>
                    <td style={{ padding: '12px 16px', fontSize: 12, color: 'var(--sub)' }}>{p.CategoryName}</td>
                    <td style={{ padding: '12px 16px' }}>
                      <div style={{ fontSize: 13, fontWeight: 700 }}>Rs.{Number(p.Price).toLocaleString('en-IN')}</div>
                      {p.MRP > p.Price && <div style={{ fontSize: 11, color: 'var(--muted)', textDecoration: 'line-through' }}>Rs.{Number(p.MRP).toLocaleString('en-IN')}</div>}
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <span style={{ fontSize: 13, fontWeight: 600, color: p.StockQuantity <= 0 ? 'var(--red)' : p.StockQuantity <= 10 ? 'var(--amber)' : 'var(--green)' }}>
                        {p.StockQuantity}
                      </span>
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <span style={{ padding: '3px 10px', borderRadius: 100, fontSize: 11, fontWeight: 600, background: p.IsActive ? 'var(--green-l)' : 'var(--red-l)', color: p.IsActive ? 'var(--green)' : 'var(--red)' }}>
                        {p.IsActive ? 'Active' : 'Inactive'}
                      </span>
                    </td>
                    <td style={{ padding: '12px 16px' }}>
                      <div style={{ display: 'flex', gap: 6 }}>
                        <button onClick={() => openEdit(p)} style={{ padding: "6px 12px", borderRadius: 6, border: "1px solid #d1d5db", background: "#fff", color: "#374151", cursor: "pointer", fontSize: 12, fontWeight: 600 }}>Edit</button>
                        <button onClick={() => handleDelete(p.ProductID)} style={{ padding: '6px 12px', borderRadius: 6, border: 'none', background: 'var(--red-l)', color: 'var(--red)', cursor: 'pointer', fontSize: 12, fontWeight: 600 }}>Del</button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Pagination */}
          {Math.ceil(total / LIMIT) > 1 && (
            <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginTop: 24 }}>
              <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1} className="btn btn-outline btn-sm">← Prev</button>
              <span style={{ padding: '8px 16px', fontSize: 13, color: 'var(--muted)' }}>Page {page} of {Math.ceil(total / LIMIT)}</span>
              <button onClick={() => setPage(p => Math.min(Math.ceil(total / LIMIT), p + 1))} disabled={page === Math.ceil(total / LIMIT)} className="btn btn-outline btn-sm">Next →</button>
            </div>
          )}
        </>
      )}

      {/* Create / Edit Modal */}
      {modal && (
        <Modal title={modal === 'create' ? 'Add New Product' : 'Edit Product'} onClose={closeModal}>
          <form onSubmit={handleSave}>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 14 }}>
              {[
                ['Name', 'Name', 'text', 'span 2'],
                ['Description', 'Description', 'text', 'span 2'],
                ['SKU', 'SKU', 'text', ''],
                ['Brand', 'Brand', 'text', ''],
                ['Price', 'Price (₹)', 'number', ''],
                ['MRP', 'MRP (₹)', 'number', ''],
                ['CostPrice', 'Cost Price (₹)', 'number', ''],
                ['StockQuantity', 'Stock Qty', 'number', ''],
                ['Weight', 'Weight (kg)', 'number', ''],
                ['Tags', 'Tags (comma-sep)', 'text', 'span 2'],
              ].map(([k, l, t, gc]) => (
                <div key={k} style={{ marginBottom: 4, gridColumn: gc || 'auto' }}>
                  <label style={{ fontSize: 12, fontWeight: 600, color: "#374151", marginBottom: 5, display: "block", textTransform: "uppercase", letterSpacing: ".05em" }}>{l}</label>
                  {k === 'Description' ? (
                    <textarea value={form[k]} onChange={upd(k)} rows={3} style={{ resize: "vertical", width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}/>
                  ) : (
                    <input type={t} value={form[k]} onChange={upd(k)} step={t === "number" ? "0.01" : undefined} style={{ width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}/>
                  )}
                </div>
              ))}

              <div style={{ marginBottom: 4 }}>
                <label style={{ fontSize: 12, fontWeight: 600, color: "#374151", marginBottom: 5, display: "block", textTransform: "uppercase", letterSpacing: ".05em" }}>Category</label>
                <select value={form.CategoryID} onChange={upd('CategoryID')} required style={{ width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}>
                  <option value="">Select category</option>
                  {categories.map(c => <option key={c.CategoryID} value={c.CategoryID}>{c.CategoryName}</option>)}
                </select>
              </div>

              <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginTop: 22 }}>
                <input type="checkbox" id="featured" checked={form.IsFeatured} onChange={upd('IsFeatured')} style={{ width: 16, height: 16, accentColor: 'var(--gold)' }}/>
                <label htmlFor="featured" style={{ fontSize: 14, fontWeight: 500, cursor: "pointer", color: "#111827" }}>Featured product</label>
              </div>

              {/* Image URL */}
              <div style={{ marginTop: 8 }}>
                <label style={{ fontSize: 12, fontWeight: 700, color: 'var(--muted)', textTransform: 'uppercase', letterSpacing: '.06em', display: 'block', marginBottom: 6 }}>Product Image URL</label>
                <input
                  type="url"
                  placeholder="https://images.unsplash.com/photo-xxx?w=600"
                  value={form.ImageURL || ''}
                  onChange={e => setForm(f => ({ ...f, ImageURL: e.target.value }))}
                  style={{ width: '100%', padding: '10px 14px', border: '1px solid var(--border)', borderRadius: 10, fontSize: 13, outline: 'none', boxSizing: 'border-box' }}
                />
                {form.ImageURL && (
                  <div style={{ marginTop: 10, display: 'flex', alignItems: 'center', gap: 12 }}>
                    <img src={form.ImageURL} alt="Preview"
                      style={{ width: 80, height: 80, objectFit: 'cover', borderRadius: 10, border: '1px solid var(--border)' }}
                      onError={e => e.target.style.display='none'}
                    />
                    <span style={{ fontSize: 12, color: 'var(--muted)' }}>Image preview</span>
                  </div>
                )}
                <div style={{ marginTop: 8, fontSize: 11, color: 'var(--muted)', lineHeight: 1.5 }}>
                  Tip: Use Unsplash (images.unsplash.com) or Pexels (images.pexels.com) URLs for best results
                </div>
              </div>

              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 4 }}>
              </div>
            </div>

            <div style={{ display: 'flex', gap: 12, justifyContent: 'flex-end', marginTop: 24, paddingTop: 20, borderTop: '1px solid var(--border)' }}>
              <button type="button" onClick={closeModal} style={{ padding: "10px 20px", borderRadius: 8, border: "1px solid #d1d5db", background: "#fff", color: "#374151", cursor: "pointer", fontSize: 13, fontWeight: 600 }}>Cancel</button>
              <button type="submit" disabled={saving} style={{ padding: "10px 20px", borderRadius: 8, border: "none", background: "#F0C14B", color: "#111", cursor: "pointer", fontSize: 13, fontWeight: 700 }}>{saving ? 'Saving…' : modal === 'create' ? 'Create Product' : 'Save Changes'}</button>
            </div>
          </form>
        </Modal>
      )}
    </div>
  );
}
