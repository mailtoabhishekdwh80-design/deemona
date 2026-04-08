// NotFound.jsx
import React from 'react';
import { Link } from 'react-router-dom';

export default function NotFound() {
  return (
    <div style={{ minHeight: '70vh', display: 'flex', alignItems: 'center', justifyContent: 'center', textAlign: 'center', padding: '60px 24px' }}>
      <div>
        <div style={{ fontFamily: 'var(--display)', fontSize: 'clamp(80px,15vw,160px)', fontWeight: 700, color: 'var(--border2)', lineHeight: 1 }}>404</div>
        <h1 style={{ fontFamily: 'var(--display)', fontSize: 'clamp(24px,4vw,40px)', fontWeight: 600, marginBottom: 12 }}>Page <em style={{ color: 'var(--gold)', fontStyle: 'italic' }}>Not Found</em></h1>
        <p style={{ fontSize: 15, color: 'var(--muted)', marginBottom: 32 }}>The page you're looking for doesn't exist or has been moved.</p>
        <div style={{ display: 'flex', gap: 12, justifyContent: 'center', flexWrap: 'wrap' }}>
          <Link to="/" className="btn btn-gold">Go Home</Link>
          <Link to="/shop" className="btn btn-outline">Browse Products</Link>
        </div>
      </div>
    </div>
  );
}
