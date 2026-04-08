// Profile.jsx
import React, { useState } from 'react';
import { useAuth } from '../context/AuthContext.jsx';
import { Auth as AuthAPI, Customers } from '../api/index.js';
import { useToast } from '../context/ToastContext.jsx';

export default function Profile() {
  const { user, updateUser, logout } = useAuth();
  const { add: toast } = useToast();
  const [tab,     setTab]     = useState('profile');
  const [saving,  setSaving]  = useState(false);
  const [form,    setForm]    = useState({
    firstName: user?.FirstName || '', lastName: user?.LastName || '',
    phone: user?.PhoneNumber || '', city: user?.City || '',
    state: user?.State || '', address: user?.Address || '',
  });
  const [pwd,  setPwd]  = useState({ currentPassword: '', newPassword: '', confirmPassword: '' });

  const update = k => e => setForm(f => ({ ...f, [k]: e.target.value }));

  const saveProfile = async e => {
    e.preventDefault(); setSaving(true);
    try {
      await Customers.update(user.CustomerID, {
        firstName: form.firstName,
        lastName:  form.lastName,
        phone:     form.phone,
        city:      form.city,
        state:     form.state,
        address:   form.address,
      });
      toast('Profile updated successfully', 'success');
    } catch { toast('Could not save changes', 'error'); }
    finally { setSaving(false); }
  };

  const changePassword = async e => {
    e.preventDefault();
    if (pwd.newPassword !== pwd.confirmPassword) { toast('Passwords do not match', 'error'); return; }
    setSaving(true);
    try {
      await AuthAPI.changePassword({ currentPassword: pwd.currentPassword, newPassword: pwd.newPassword });
      toast('Password changed successfully', 'success');
      setPwd({ currentPassword: '', newPassword: '', confirmPassword: '' });
    } catch (e) { toast(e?.error || 'Failed to change password', 'error'); }
    finally { setSaving(false); }
  };

  const TABS = [['profile','Profile'],['security','Security'],['loyalty','Loyalty']];

  return (
    <div className="page-enter">
      <div className="container" style={{ padding: '40px 24px', maxWidth: 900 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 20, marginBottom: 36 }}>
          <div style={{ width: 72, height: 72, borderRadius: '50%', background: 'var(--navy)', color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 28, fontWeight: 700, fontFamily: 'var(--display)' }}>
            {(user?.FirstName || 'U')[0]?.toUpperCase()}
          </div>
          <div>
            <h1 style={{ fontFamily: 'var(--display)', fontSize: 28, fontWeight: 700 }}>{user?.FirstName} {user?.LastName}</h1>
            <div style={{ fontSize: 14, color: 'var(--muted)' }}>{user?.Email}</div>
            <div style={{ display: 'flex', gap: 8, marginTop: 6 }}>
              <span className="badge badge-gold">{user?.LoyaltyTier || 'Bronze'}</span>
              <span className="badge badge-gray">{user?.LoyaltyPoints || 0} pts</span>
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 4, borderBottom: '1px solid var(--border)', marginBottom: 32 }}>
          {TABS.map(([k, l]) => (
            <button key={k} onClick={() => setTab(k)} style={{ padding: '10px 20px', fontSize: 14, fontWeight: 600, background: 'none', border: 'none', borderBottom: tab === k ? '2px solid var(--gold)' : '2px solid transparent', color: tab === k ? 'var(--gold)' : 'var(--muted)', cursor: 'pointer', marginBottom: -1 }}>{l}</button>
          ))}
        </div>

        {tab === 'profile' && (
          <form onSubmit={saveProfile} style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16, maxWidth: 600 }}>
            {[['firstName','First Name'],['lastName','Last Name'],['phone','Phone'],['city','City'],['state','State'],['address','Address']].map(([k, label]) => (
              <div key={k} className="input-group" style={{ gridColumn: k === 'address' ? 'span 2' : 'auto' }}>
                <label className="input-label">{label}</label>
                <input value={form[k]} onChange={update(k)} className="input" placeholder={label}/>
              </div>
            ))}
            <div style={{ gridColumn: 'span 2' }}>
              <button type="submit" disabled={saving} className="btn btn-navy">{saving ? 'Saving…' : 'Save Changes'}</button>
            </div>
          </form>
        )}

        {tab === 'security' && (
          <div style={{ maxWidth: 480 }}>
            <h3 style={{ fontSize: 17, fontWeight: 700, marginBottom: 20 }}>Change Password</h3>
            <form onSubmit={changePassword} style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
              {[['currentPassword','Current Password'],['newPassword','New Password'],['confirmPassword','Confirm New Password']].map(([k, l]) => (
                <div key={k} className="input-group">
                  <label className="input-label">{l}</label>
                  <input type="password" value={pwd[k]} onChange={e => setPwd(p => ({ ...p, [k]: e.target.value }))} className="input" placeholder="••••••••" required minLength={k === 'currentPassword' ? 1 : 8}/>
                </div>
              ))}
              <button type="submit" disabled={saving} className="btn btn-navy" style={{ alignSelf: 'flex-start' }}>{saving ? 'Updating…' : 'Change Password'}</button>
            </form>
          </div>
        )}

        {tab === 'loyalty' && (
          <div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3,1fr)', gap: 16, marginBottom: 32 }}>
              {[
                { label: 'Loyalty Points', value: user?.LoyaltyPoints?.toLocaleString('en-IN') || '0', icon: '🎯' },
                { label: 'Current Tier', value: user?.LoyaltyTier || 'Bronze', icon: '🏅' },
                { label: 'Points Value', value: `₹${(Math.floor((user?.LoyaltyPoints || 0) * 0.1)).toLocaleString('en-IN')}`, icon: '💰' },
              ].map(c => (
                <div key={c.label} style={{ background: 'var(--white)', border: '1px solid var(--border)', borderRadius: 14, padding: 24, textAlign: 'center' }}>
                  <div style={{ fontSize: 32, marginBottom: 8 }}>{c.icon}</div>
                  <div style={{ fontSize: 24, fontWeight: 800, fontFamily: 'var(--display)', marginBottom: 4 }}>{c.value}</div>
                  <div style={{ fontSize: 13, color: 'var(--muted)' }}>{c.label}</div>
                </div>
              ))}
            </div>
            <div style={{ background: 'var(--cream)', borderRadius: 14, padding: 24 }}>
              <h4 style={{ fontSize: 15, fontWeight: 700, marginBottom: 12 }}>Tier Benefits</h4>
              {[
                { tier: '💎 Platinum', min: '₹1,00,000+', perks: '3× points · Free express shipping · 15% extra discount' },
                { tier: '🥇 Gold',     min: '₹50,000+',   perks: '2× points · Free standard shipping · 10% extra discount' },
                { tier: '🥈 Silver',   min: '₹10,000+',   perks: '1.5× points · 5% extra discount · Early sale access' },
                { tier: '🥉 Bronze',   min: '₹0+',        perks: '1× points · Standard benefits' },
              ].map(t => (
                <div key={t.tier} style={{ display: 'flex', gap: 16, padding: '10px 0', borderBottom: '1px solid var(--border)', alignItems: 'center' }}>
                  <div style={{ width: 80, fontSize: 13, fontWeight: 700 }}>{t.tier}</div>
                  <div style={{ width: 80, fontSize: 12, color: 'var(--muted)' }}>{t.min}</div>
                  <div style={{ fontSize: 13, color: 'var(--sub)' }}>{t.perks}</div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
