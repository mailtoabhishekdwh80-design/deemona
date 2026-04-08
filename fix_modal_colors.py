with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix Modal to use explicit colors instead of CSS variables
code = code.replace(
    """function Modal({ title, onClose, children }) {
  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(10,15,30,.7)', zIndex: 2000, display: 'flex', alignItems: 'flex-start', justifyContent: 'center', padding: '40px 20px', overflowY: 'auto' }}
      onClick={e => e.target === e.currentTarget && onClose()}>
      <div style={{ background: 'var(--white)', borderRadius: 20, width: '100%', maxWidth: 680, boxShadow: '0 32px 64px rgba(0,0,0,.3)', flexShrink: 0 }}>
        <div style={{ padding: '20px 28px', borderBottom: '1px solid var(--border)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <h3 style={{ fontSize: 17, fontWeight: 700 }}>{title}</h3>
          <button onClick={onClose} style={{ width: 32, height: 32, borderRadius: '50%', background: 'var(--cream)', border: 'none', cursor: 'pointer', fontSize: 18, color: 'var(--muted)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>×</button>
        </div>
        <div style={{ padding: '24px 28px' }}>{children}</div>
      </div>
    </div>
  );
}""",
    """function Modal({ title, onClose, children }) {
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
}"""
)

# Fix all input styles to use explicit colors
code = code.replace(
    'className="input-group"',
    'style={{ marginBottom: 4 }}'
)
code = code.replace(
    'className="input-label"',
    'style={{ fontSize: 12, fontWeight: 600, color: "#374151", marginBottom: 5, display: "block", textTransform: "uppercase", letterSpacing: ".05em" }}'
)
code = code.replace(
    'className="input" rows={3} style={{ resize: \'vertical\' }}',
    'rows={3} style={{ resize: "vertical", width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}'
)
code = code.replace(
    'className="input" step={t === \'number\' ? \'0.01\' : undefined}',
    'step={t === "number" ? "0.01" : undefined} style={{ width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}'
)
code = code.replace(
    'className="input" required>',
    'required style={{ width: "100%", padding: "9px 12px", border: "1px solid #d1d5db", borderRadius: 8, fontSize: 13, color: "#111827", outline: "none", boxSizing: "border-box", background: "#fff" }}>'
)

# Fix label color in featured checkbox
code = code.replace(
    '<label htmlFor="featured" style={{ fontSize: 14, fontWeight: 500, cursor: \'pointer\' }}>Featured product</label>',
    '<label htmlFor="featured" style={{ fontSize: 14, fontWeight: 500, cursor: "pointer", color: "#111827" }}>Featured product</label>'
)

# Fix buttons in modal
code = code.replace(
    'className="btn btn-outline">Cancel</button>',
    'style={{ padding: "10px 20px", borderRadius: 8, border: "1px solid #d1d5db", background: "#fff", color: "#374151", cursor: "pointer", fontSize: 13, fontWeight: 600 }}>Cancel</button>'
)
code = code.replace(
    'className="btn btn-gold">{saving',
    'style={{ padding: "10px 20px", borderRadius: 8, border: "none", background: "#F0C14B", color: "#111", cursor: "pointer", fontSize: 13, fontWeight: 700 }}>{saving'
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Modal fixed with explicit colors!")
