import React from 'react';

export default function Spinner({ size = 40, message = 'Loading...' }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'center', padding:'60px 20px', gap:16 }}>
      <div style={{ width:size, height:size, border:'3px solid #EAEDED', borderTop:'3px solid #00ACC1', borderRadius:'50%', animation:'spin 0.8s linear infinite' }}/>
      <style>{`@keyframes spin { to { transform: rotate(360deg); } }`}</style>
      {message && <p style={{ color:'#565959', fontSize:13, margin:0 }}>{message}</p>}
    </div>
  );
}

export function Footer() {
  return (
    <footer style={{ background:'#1B3A6B', color:'rgba(255,255,255,.65)', marginTop:'auto' }}>
      <div onClick={() => window.scrollTo({ top:0, behavior:'smooth' })} style={{ background:'#0F2D55', padding:'14px 0', textAlign:'center', cursor:'pointer', fontSize:13, color:'rgba(255,255,255,.75)' }}>
        Back to top
      </div>
      <div style={{ maxWidth:1500, margin:'0 auto', padding:'32px 20px', display:'grid', gridTemplateColumns:'repeat(auto-fit,minmax(180px,1fr))', gap:28 }}>
        <div>
          <div style={{ fontSize:22, fontWeight:800, color:'#fff', marginBottom:8 }}>Deemona</div>
          <div style={{ fontSize:12, lineHeight:1.7 }}>Discover · Dream · Deliver</div>
        </div>
        <div>
          <div style={{ fontSize:12, fontWeight:700, color:'#fff', marginBottom:10, textTransform:'uppercase' }}>Shop</div>
          {['Electronics','Clothing','Books','Home Decor','Sports','Medicines'].map(c => (
            <div key={c} style={{ fontSize:12, marginBottom:5, cursor:'pointer' }}>{c}</div>
          ))}
        </div>
        <div>
          <div style={{ fontSize:12, fontWeight:700, color:'#fff', marginBottom:10, textTransform:'uppercase' }}>Help</div>
          {['Your Account','Returns','Track Order','Contact Us','FAQ'].map(c => (
            <div key={c} style={{ fontSize:12, marginBottom:5, cursor:'pointer' }}>{c}</div>
          ))}
        </div>
        <div>
          <div style={{ fontSize:12, fontWeight:700, color:'#fff', marginBottom:10, textTransform:'uppercase' }}>About</div>
          {['About Us','Careers','Press','Sustainability'].map(c => (
            <div key={c} style={{ fontSize:12, marginBottom:5, cursor:'pointer' }}>{c}</div>
          ))}
        </div>
      </div>
      <div style={{ borderTop:'1px solid rgba(255,255,255,.1)', padding:'16px 20px', textAlign:'center', fontSize:11 }}>
        © {new Date().getFullYear()} Deemona Commerce Pvt. Ltd. All rights reserved.
      </div>
    </footer>
  );
}