import React, { createContext, useContext, useState, useCallback } from 'react';

const ToastCtx = createContext(null);

let idCounter = 0;

export function ToastProvider({ children }) {
  const [toasts, setToasts] = useState([]);

  const add = useCallback((message, type = 'info', duration = 3500) => {
    const id = ++idCounter;
    setToasts(prev => [...prev, { id, message, type }]);
    setTimeout(() => setToasts(prev => prev.filter(t => t.id !== id)), duration);
  }, []);

  const remove = useCallback(id => setToasts(prev => prev.filter(t => t.id !== id)), []);

  return (
    <ToastCtx.Provider value={{ add, remove }}>
      {children}
      <ToastContainer toasts={toasts} onRemove={remove} />
    </ToastCtx.Provider>
  );
}

export const useToast = () => useContext(ToastCtx);

function ToastContainer({ toasts, onRemove }) {
  if (!toasts.length) return null;
  return (
    <div style={{
      position: 'fixed', bottom: 24, right: 24, zIndex: 9999,
      display: 'flex', flexDirection: 'column', gap: 10, maxWidth: 380,
    }}>
      {toasts.map(t => (
        <div key={t.id} onClick={() => onRemove(t.id)} style={{
          padding: '12px 18px', borderRadius: 10, cursor: 'pointer',
          fontSize: 14, fontWeight: 500, lineHeight: 1.4,
          background: t.type === 'success' ? '#0f172a' : t.type === 'error' ? '#7f1d1d' : t.type === 'warning' ? '#78350f' : '#0f172a',
          color: '#fff', boxShadow: '0 8px 32px rgba(0,0,0,.25)',
          borderLeft: `4px solid ${t.type === 'success' ? '#22c55e' : t.type === 'error' ? '#ef4444' : t.type === 'warning' ? '#f59e0b' : '#c9973a'}`,
          animation: 'slideIn .2s ease',
        }}>
          {t.message}
        </div>
      ))}
      <style>{`@keyframes slideIn{from{transform:translateX(40px);opacity:0}to{transform:none;opacity:1}}`}</style>
    </div>
  );
}
