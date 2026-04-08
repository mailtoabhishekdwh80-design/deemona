import React, { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext.jsx';
import { useToast } from '../context/ToastContext.jsx';

const LOGO_SRC = null;

export default function Auth({ mode }) {
  const navigate  = useNavigate();
  const location  = useLocation();
  const { login, register } = useAuth();
  const { add: toast } = useToast();
  const from = location.state?.from?.pathname || '/';

  const [tab,       setTab]     = useState('login');
  const [loading,   setLoading] = useState(false);
  const [requires2FA, set2FA]   = useState(false);
  const [form, setForm] = useState({ email: '', password: '', firstName: '', lastName: '', phone: '', totpCode: '' });

  const update = k => e => setForm(f => ({ ...f, [k]: e.target.value }));

  const handleLogin = async e => {
    e.preventDefault(); setLoading(true);
    try {
      const res = await login(form.email, form.password, form.totpCode || undefined);
      if (res?.requires2FA) { set2FA(true); setLoading(false); return; }
      toast('Welcome back!', 'success');
      navigate(from, { replace: true });
    } catch (err) { toast(err?.error || 'Sign in failed', 'error'); }
    finally { setLoading(false); }
  };

  const handleRegister = async e => {
    e.preventDefault(); setLoading(true);
    try {
      await register({ firstName: form.firstName, lastName: form.lastName, email: form.email, password: form.password, phone: form.phone });
      toast('Account created! Welcome to Deemona', 'success');
      navigate(from, { replace: true });
    } catch (err) { toast(err?.error || 'Registration failed', 'error'); }
    finally { setLoading(false); }
  };

  return (
    <div style={{ minHeight: '80vh', display: 'flex', alignItems: 'flex-start', justifyContent: 'center', padding: '24px 16px', background: '#EAEDED' }}>
      <div style={{ width: '100%', maxWidth: 400 }}>

        <div style={{ textAlign: 'center', marginBottom: 16 }}>
          <div style={{ fontSize:24, fontWeight:800, color:"#1B3A6B" }}>Deemona</div>
        </div>

        <div style={{ background: '#fff', border: '1px solid #ddd', borderRadius: 6, padding: '24px 28px', boxShadow: '0 2px 4px rgba(0,0,0,.08)' }}>
          <div style={{ display: 'flex', gap: 0, marginBottom: 20, borderBottom: '1px solid #eee' }}>
            {['login','register'].map(t => (
              <button key={t} onClick={() => setTab(t)} style={{
                flex: 1, padding: '10px 0', fontSize: 14, fontWeight: tab === t ? 700 : 500,
                background: 'none', border: 'none', borderBottom: tab === t ? '2px solid #00ACC1' : '2px solid transparent',
                color: tab === t ? '#0F1111' : '#565959', cursor: 'pointer', marginBottom: -1,
              }}>{t === 'login' ? 'Sign In' : 'Create account'}</button>
            ))}
          </div>

          {tab === 'login' ? (
            <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              <div>
                <label className="input-label">Email</label>
                <input type="email" value={form.email} onChange={update('email')} className="input" placeholder="you@example.com" required autoFocus/>
              </div>
              <div>
                <label className="input-label">Password</label>
                <input type="password" value={form.password} onChange={update('password')} className="input" placeholder="At least 8 characters" required/>
              </div>
              {requires2FA && (
                <div>
                  <label className="input-label">Authenticator code</label>
                  <input type="text" value={form.totpCode} onChange={update('totpCode')} className="input" placeholder="6-digit code" maxLength={6} inputMode="numeric" autoFocus/>
                </div>
              )}
              <button type="submit" disabled={loading} style={{ width: '100%', padding: '10px 0', borderRadius: 4, background: 'linear-gradient(to bottom,#f7dfa5,#f0c14b)', border: '1px solid #a88734', fontSize: 14, fontWeight: 500, cursor: 'pointer', marginTop: 4 }}>
                {loading ? 'Signing in…' : 'Sign in'}
              </button>
              <div style={{ fontSize: 12, color: '#565959', textAlign: 'center' }}>
                By signing in you agree to Deemona's Terms and Privacy Policy.
              </div>
            </form>
          ) : (
            <form onSubmit={handleRegister} style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                <div>
                  <label className="input-label">First name</label>
                  <input value={form.firstName} onChange={update('firstName')} className="input" placeholder="Priya" required/>
                </div>
                <div>
                  <label className="input-label">Last name</label>
                  <input value={form.lastName} onChange={update('lastName')} className="input" placeholder="Sharma" required/>
                </div>
              </div>
              <div>
                <label className="input-label">Email</label>
                <input type="email" value={form.email} onChange={update('email')} className="input" placeholder="you@example.com" required/>
              </div>
              <div>
                <label className="input-label">Mobile number (optional)</label>
                <input type="tel" value={form.phone} onChange={update('phone')} className="input" placeholder="+91 98765 43210"/>
              </div>
              <div>
                <label className="input-label">Password</label>
                <input type="password" value={form.password} onChange={update('password')} className="input" placeholder="At least 8 characters" required minLength={8}/>
              </div>
              <button type="submit" disabled={loading} style={{ width: '100%', padding: '10px 0', borderRadius: 4, background: 'linear-gradient(to bottom,#f7dfa5,#f0c14b)', border: '1px solid #a88734', fontSize: 14, fontWeight: 500, cursor: 'pointer', marginTop: 4 }}>
                {loading ? 'Creating account…' : 'Create your Deemona account'}
              </button>
              <p style={{ fontSize: 11, color: '#565959' }}>By creating an account you agree to Deemona's Terms of Service and Privacy Notice.</p>
            </form>
          )}
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: 10, margin: '16px 0', color: '#767676', fontSize: 13 }}>
          <div style={{ flex: 1, height: 1, background: '#ddd' }}/>
          <span>New to Deemona?</span>
          <div style={{ flex: 1, height: 1, background: '#ddd' }}/>
        </div>
        <button onClick={() => setTab(tab === 'login' ? 'register' : 'login')} style={{ width: '100%', padding: '10px 0', borderRadius: 4, background: 'linear-gradient(to bottom,#f7f8f8,#e7e9ec)', border: '1px solid #adb1b8', fontSize: 13, fontWeight: 500, cursor: 'pointer' }}>
          {tab === 'login' ? 'Create a new account' : 'Sign in instead'}
        </button>
      </div>
    </div>
  );
}
