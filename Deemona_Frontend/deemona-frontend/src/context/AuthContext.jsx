import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { Auth } from '../api/index.js';

const AuthCtx = createContext(null);

// Decode JWT payload without verification
const decodeJWT = token => {
  try {
    const payload = token.split('.')[1];
    return JSON.parse(atob(payload.replace(/-/g,'+').replace(/_/g,'/')));
  } catch { return {}; }
};



export function AuthProvider({ children }) {
  const [user,    setUser]    = useState(null);
  const [loading, setLoading] = useState(true);

  // Boot: restore session from localStorage
  useEffect(() => {
    const token = localStorage.getItem('access_token');
    if (token) {
      (() => {
          const decoded = decodeJWT(token);
          const isAdminToken = decoded.role && ['admin','super_admin','manager','support'].includes(decoded.role);
          const meCall = isAdminToken ? Auth.adminMe() : Auth.me();
          return meCall.then(d => {
            const userData = d.data.admin || d.data.customer || d.data || {};
            if (!userData.role) userData.role = decoded.role;
            if (!userData.email) userData.email = decoded.email;
            if (!userData.FirstName) userData.FirstName = decoded.email?.split('@')[0] || 'Admin';
            setUser(userData);
          });
        })()
        .catch(() => { localStorage.removeItem('access_token'); localStorage.removeItem('refresh_token'); })
        .finally(() => setLoading(false));
    } else {
      setLoading(false);
    }
  }, []);

  const login = useCallback(async (email, password, totpCode) => {
    let d;
    let isAdminLogin = false;
    try {
      d = await Auth.adminLogin({ email, password, ...(totpCode && { totpCode }) });
      isAdminLogin = true;
    } catch {
      d = await Auth.login({ email, password, ...(totpCode && { totpCode }) });
    }
    if (d.data?.requires2FA) return { requires2FA: true };
    localStorage.setItem('access_token',  d.data.accessToken);
    localStorage.setItem('refresh_token', d.data.refreshToken);
    let userData = d.data.customer || d.data.admin || {};
    if (!userData.email && d.data.accessToken) {
      const decoded = decodeJWT(d.data.accessToken);
      userData = { ...userData, ...decoded, id: decoded.id, email: decoded.email, role: decoded.role, FirstName: decoded.email?.split('@')[0] || 'Admin' };
    }
    setUser(userData);
    return d.data;
  }, []);

  const register = useCallback(async body => {
    const d = await Auth.register(body);
    localStorage.setItem('access_token',  d.data.accessToken);
    localStorage.setItem('refresh_token', d.data.refreshToken);
    setUser(d.data.customer);
    return d.data;
  }, []);

  const logout = useCallback(async () => {
    const refresh = localStorage.getItem('refresh_token');
    try { await Auth.logout({ refreshToken: refresh }); } catch {}
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    setUser(null);
  }, []);

  const updateUser = useCallback(data => setUser(prev => ({ ...prev, ...data })), []);

  const isAdmin  = user?.role && ['admin','super_admin','manager','support'].includes(user.role);
  const isAuthed = !!user;

  return (
    <AuthCtx.Provider value={{ user, loading, isAuthed, isAdmin, login, register, logout, updateUser }}>
      {children}
    </AuthCtx.Provider>
  );
}

export const useAuth = () => useContext(AuthCtx);
