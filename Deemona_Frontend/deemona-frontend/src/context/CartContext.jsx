import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { Cart as CartAPI } from '../api/index.js';
import { useAuth } from './AuthContext.jsx';

const CartCtx = createContext(null);

export function CartProvider({ children }) {
  const { isAuthed } = useAuth();
  const [items,   setItems]   = useState([]);
  const [summary, setSummary] = useState({ subtotal: 0, total: 0, count: 0 });
  const [loading, setLoading] = useState(false);

  const fetchCart = useCallback(async () => {
    if (!isAuthed) { setItems([]); setSummary({ subtotal: 0, total: 0, count: 0 }); return; }
    setLoading(true);
    try {
      const d = await CartAPI.get();
      setItems(d.data.items || []);
      setSummary(d.data.summary || {});
    } catch {
      setItems([]);
    } finally {
      setLoading(false);
    }
  }, [isAuthed]);

  useEffect(() => { fetchCart(); }, [fetchCart]);

  const addItem = useCallback(async (productID, quantity = 1) => {
    await CartAPI.add({ productID, quantity });
    fetchCart();
  }, [fetchCart]);

  const updateItem = useCallback(async (cartItemId, quantity) => {
    if (quantity < 1) return removeItem(cartItemId);
    await CartAPI.update(cartItemId, { quantity });
    fetchCart();
  }, [fetchCart]);

  const removeItem = useCallback(async cartItemId => {
    await CartAPI.remove(cartItemId);
    fetchCart();
  }, [fetchCart]);

  const clearCart = useCallback(async () => {
    await CartAPI.clear();
    setItems([]); setSummary({ subtotal: 0, total: 0, count: 0 });
  }, []);

  const count = items.reduce((s, i) => s + i.Quantity, 0);

  return (
    <CartCtx.Provider value={{ items, summary, loading, count, fetchCart, addItem, updateItem, removeItem, clearCart }}>
      {children}
    </CartCtx.Provider>
  );
}

export const useCart = () => useContext(CartCtx);
