with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix the CTA button - make it bright gold with dark text
code = code.replace(
    '<button className="btn btn-gold btn-lg" onClick={() => navigate(`/shop/${banner.cat}`)}>{banner.cta}</butt',
    '<button onClick={() => navigate(`/shop/${banner.cat}`)} style={{ background: "#F0C14B", color: "#111", border: "none", padding: "14px 32px", fontSize: 16, fontWeight: 800, borderRadius: 8, cursor: "pointer", letterSpacing: ".03em", boxShadow: "0 4px 15px rgba(0,0,0,.3)", transition: "all .2s" }} onMouseEnter={e => { e.currentTarget.style.background="#e6b800"; e.currentTarget.style.transform="translateY(-2px)"; }} onMouseLeave={e => { e.currentTarget.style.background="#F0C14B"; e.currentTarget.style.transform="translateY(0)"; }}>{banner.cta}</butt'
)

# Fix the secondary button
code = code.replace(
    '<button className="btn btn-outline btn-lg" style={{ borderColor: \'rgba(255,255,255,.3)\', color: \'#fff\' }}',
    '<button style={{ background: "rgba(255,255,255,.15)", color: "#fff", border: "2px solid rgba(255,255,255,.8)", padding: "14px 32px", fontSize: 16, fontWeight: 700, borderRadius: 8, cursor: "pointer", backdropFilter: "blur(4px)", transition: "all .2s" }} onMouseEnter={e => { e.currentTarget.style.background="rgba(255,255,255,.25)"; }} onMouseLeave={e => { e.currentTarget.style.background="rgba(255,255,255,.15)"; }}'
)

# Remove non-ASCII
clean = "".join(c if ord(c) < 128 else "" for c in code)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\pages\Home.jsx", "w", encoding="utf-8") as f:
    f.write(clean)

print("Done!")
