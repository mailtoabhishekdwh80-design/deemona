with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# 1. Fix openEdit to extract ImageURL from ImageURLs array
code = code.replace(
    "const openEdit   = p  => { setForm({ ...p, IsFeatured: !!p.IsFeatured }); setEditing(p.ProductID); setModal('edit'); };",
    """const openEdit = p => {
    let imageURL = '';
    try { const arr = typeof p.ImageURLs === 'string' ? JSON.parse(p.ImageURLs) : p.ImageURLs; imageURL = Array.isArray(arr) ? arr[0] || '' : ''; } catch {}
    setForm({ ...p, IsFeatured: !!p.IsFeatured, ImageURL: imageURL });
    setEditing(p.ProductID); setModal('edit');
  };"""
)

# 2. Add ImageURLs to save payload
code = code.replace(
    "        Weight:        form.Weight ? parseFloat(form.Weight) : undefined,",
    "        Weight:        form.Weight ? parseFloat(form.Weight) : undefined,\n        ImageURLs:     form.ImageURL ? JSON.stringify([form.ImageURL]) : undefined,"
)

# 3. Add image field + preview in form - add before the featured checkbox
code = code.replace(
    """                <input type="checkbox" id="featured" checked={form.IsFeatured} onChange={upd('IsFeatured')} style={{ width: 16, height: 16, accentColor: 'var(--gold)' }}/>
                <label htmlFor="featured" style={{ fontSize: 14, fontWeight: 500, cursor: 'pointer' }}>Featured product</label>""",
    """                <input type="checkbox" id="featured" checked={form.IsFeatured} onChange={upd('IsFeatured')} style={{ width: 16, height: 16, accentColor: 'var(--gold)' }}/>
                <label htmlFor="featured" style={{ fontSize: 14, fontWeight: 500, cursor: 'pointer' }}>Featured product</label>
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

              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginTop: 4 }}"""
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\admin\Products.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Image field added!")
