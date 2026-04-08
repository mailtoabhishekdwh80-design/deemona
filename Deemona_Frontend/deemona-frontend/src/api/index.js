// api/index.js — Complete API layer connecting all backend endpoints
import axios from 'axios';

const BASE = import.meta.env.VITE_API_URL || '/api';

// ── Axios instance ────────────────────────────────────────
const api = axios.create({
  baseURL: BASE,
  timeout: 30000,
  headers: { 'Content-Type': 'application/json' },
});

// Attach access token to every request
api.interceptors.request.use(cfg => {
  const token = localStorage.getItem('access_token');
  if (token) cfg.headers.Authorization = `Bearer ${token}`;
  return cfg;
});

// Auto-refresh on 401 with token expired message
let isRefreshing = false;
let queue = [];

api.interceptors.response.use(
  res => res.data,
  async err => {
    const original = err.config;
    const status   = err.response?.status;
    const msg      = err.response?.data?.error || '';

    if (status === 401 && msg.includes('expired') && !original._retry) {
      original._retry = true;

      if (isRefreshing) {
        return new Promise((res, rej) => queue.push({ res, rej }))
          .then(token => { original.headers.Authorization = `Bearer ${token}`; return api(original); });
      }

      isRefreshing = true;
      try {
        const refresh = localStorage.getItem('refresh_token');
        if (!refresh) throw new Error('no refresh token');
        const data = await api.post('/auth/token/refresh', { refreshToken: refresh });
        const newToken = data.accessToken;
        localStorage.setItem('access_token',  newToken);
        localStorage.setItem('refresh_token', data.refreshToken);
        queue.forEach(p => p.res(newToken));
        queue = [];
        original.headers.Authorization = `Bearer ${newToken}`;
        return api(original);
      } catch {
        queue.forEach(p => p.rej(new Error('session expired')));
        queue = [];
        localStorage.clear();
        window.location.href = '/auth';
      } finally {
        isRefreshing = false;
      }
    }
    return Promise.reject(err.response?.data || err);
  }
);

// ═══════════════════════════════════════════════════════════
//  AUTH
// ═══════════════════════════════════════════════════════════
export const Auth = {
  register:       body => api.post('/auth/register', body),
  login:          body => api.post('/auth/login', body),
  logout:         body => api.post('/auth/logout', body),
  logoutAll:      ()   => api.post('/auth/logout/all'),
  refresh:        body => api.post('/auth/token/refresh', body),
  me:             ()   => api.get('/auth/me'),
  changePassword: body => api.put('/auth/change-password', body),
  forgotPassword: body => api.post('/auth/forgot-password', body),
  resetPassword:  (token, body) => api.post(`/auth/reset-password/${token}`, body),
  setup2FA:       ()   => api.post('/auth/2fa/setup'),
  verify2FA:      body => api.post('/auth/2fa/verify', body),
  disable2FA:     body => api.delete('/auth/2fa', { data: body }),
  adminLogin:     body => api.post('/auth/admin/login', body),
  adminMe:        ()   => api.get('/auth/admin/me'),
};

// ═══════════════════════════════════════════════════════════
//  PRODUCTS & CATALOGUE
// ═══════════════════════════════════════════════════════════
export const Products = {
  list:         params  => api.get('/products', { params }),
  get:          id      => api.get(`/products/${id}`),
  reviews:      id      => api.get(`/products/${id}/reviews`),
  priceHistory: id      => api.get(`/products/${id}/price-history`),
  create:       body    => api.post('/products', body),
  update:       (id, b) => api.put(`/products/${id}`, b),
  updateStock:  (id, b) => api.patch(`/products/${id}/stock`, b),
  remove:       id      => api.delete(`/products/${id}`),
  bulkImport:   body    => api.post('/admin/products/bulk', body),
};

export const Categories = {
  list:     ()    => api.get('/categories'),
  get:      id    => api.get(`/categories/${id}`),
  products: (id, params) => api.get(`/categories/${id}/products`, { params }),
  create:   body  => api.post('/categories', body),
  update:   (id, b) => api.put(`/categories/${id}`, b),
  remove:   id    => api.delete(`/categories/${id}`),
};

export const Search = {
  query:        params => api.get('/search', { params }),
  autocomplete: q      => api.get('/search/autocomplete', { params: { q } }),
};

export const Inventory = {
  list:   params => api.get('/inventory', { params }),
  get:    id     => api.get(`/inventory/${id}`),
  alerts: ()     => api.get('/inventory/alerts/all'),
  create: body   => api.post('/inventory', body),
  update: (id,b) => api.put(`/inventory/${id}`, b),
};

// ═══════════════════════════════════════════════════════════
//  CART
// ═══════════════════════════════════════════════════════════
export const Cart = {
  get:         ()         => api.get('/cart'),
  add:         body       => api.post('/cart', body),
  update:      (id, body) => api.put(`/cart/${id}`, body),
  remove:      id         => api.delete(`/cart/${id}`),
  clear:       ()         => api.delete('/cart'),
  validate:    ()         => api.post('/cart/validate'),
};

// ═══════════════════════════════════════════════════════════
//  ORDERS
// ═══════════════════════════════════════════════════════════
export const Orders = {
  list:          params    => api.get('/orders', { params }),
  get:           id        => api.get(`/orders/${id}`),
  items:         id        => api.get(`/orders/${id}/items`),
  invoice:       id        => api.get(`/orders/${id}/invoice`),
  place:         body      => api.post('/orders', body),
  cancel:        id        => api.patch(`/orders/${id}/cancel`),
  return:        id        => api.post(`/orders/${id}/return`),
  // Admin
  adminList:     params    => api.get('/admin/orders', { params }),
  adminUpdate:   (id, body)=> api.patch(`/admin/orders/${id}/status`, body),
};

// ═══════════════════════════════════════════════════════════
//  PAYMENTS — full gateway
// ═══════════════════════════════════════════════════════════
export const Payments = {
  initiate:    body        => api.post('/payments/initiate', body),
  verify:      body        => api.post('/payments/verify', body),
  link:        body        => api.post('/payments/link', body),
  get:         id          => api.get(`/payments/${id}`),
  list:        params      => api.get('/payments', { params }),
  refund:      (id, body)  => api.post(`/payments/${id}/refund`, body),
  updateStatus:(id, body)  => api.patch(`/payments/${id}/status`, body),
  attempts:    id          => api.get(`/payments/${id}/attempts`),
  stats:       params      => api.get('/payments/admin/stats', { params }),
};

// ═══════════════════════════════════════════════════════════
//  CUSTOMERS
// ═══════════════════════════════════════════════════════════
export const Customers = {
  list:          params    => api.get('/customers', { params }),
  get:           id        => api.get(`/customers/${id}`),
  create:        body      => api.post('/customers', body),
  update:        (id, b)   => api.put(`/customers/${id}`, b),
  updateStatus:  (id, b)   => api.patch(`/customers/${id}/status`, b),
  updateLoyalty: (id, b)   => api.patch(`/customers/${id}/loyalty`, b),
  remove:        id        => api.delete(`/customers/${id}`),
  orders:        id        => api.get(`/customers/${id}/orders`),
  reviews:       id        => api.get(`/customers/${id}/reviews`),
};

// ═══════════════════════════════════════════════════════════
//  ADDRESSES
// ═══════════════════════════════════════════════════════════
export const Addresses = {
  list:       ()         => api.get('/addresses'),
  create:     body       => api.post('/addresses', body),
  update:     (id, body) => api.put(`/addresses/${id}`, body),
  remove:     id         => api.delete(`/addresses/${id}`),
  setDefault: id         => api.patch(`/addresses/${id}/default`),
};

// ═══════════════════════════════════════════════════════════
//  WISHLIST
// ═══════════════════════════════════════════════════════════
export const Wishlist = {
  get:         ()    => api.get('/wishlist'),
  add:         id    => api.post(`/wishlist/${id}`),
  remove:      id    => api.delete(`/wishlist/${id}`),
  clear:       ()    => api.delete('/wishlist'),
  moveToCart:  id    => api.post(`/wishlist/${id}/move-to-cart`),
};

// ═══════════════════════════════════════════════════════════
//  REVIEWS
// ═══════════════════════════════════════════════════════════
export const Reviews = {
  list:        params     => api.get('/admin/reviews', { params }),
  create:      (pid, b)   => api.post(`/products/${pid}/reviews`, b),
  helpful:     id         => api.patch(`/reviews/${id}/helpful`),
  moderate:    (id, b)    => api.patch(`/admin/reviews/${id}`, b),
  remove:      id         => api.delete(`/admin/reviews/${id}`),
};

// ═══════════════════════════════════════════════════════════
//  DISCOUNTS
// ═══════════════════════════════════════════════════════════
export const Discounts = {
  active:   ()         => api.get('/discounts/active'),
  validate: body       => api.post('/discounts/validate', body),
  list:     params     => api.get('/admin/discounts', { params }),
  get:      id         => api.get(`/discounts/${id}`),
  create:   body       => api.post('/admin/discounts', body),
  update:   (id, body) => api.put(`/admin/discounts/${id}`, body),
  remove:   id         => api.delete(`/admin/discounts/${id}`),
};

// ═══════════════════════════════════════════════════════════
//  ADMIN
// ═══════════════════════════════════════════════════════════
export const Admin = {
  dashboard:    params => api.get('/admin/dashboard', { params }),
  revenue:      params => api.get('/admin/analytics/revenue', { params }),
  customers:    params => api.get('/admin/analytics/customers', { params }),
  adminList:    params => api.get('/admin/customers', { params }),
  salesReport:  params => api.get('/admin/reports/sales', { params }),
  inventoryReport: ()  => api.get('/admin/reports/inventory'),
  customersReport: ()  => api.get('/admin/reports/customers'),
  // Admin user management
  users:        ()          => api.get('/auth/admin/users'),
  createUser:   body        => api.post('/auth/admin/users', body),
  changeRole:   (id, body)  => api.patch(`/auth/admin/users/${id}/role`, body),
  removeUser:   id          => api.delete(`/auth/admin/users/${id}`),
  activity:     ()          => api.get('/auth/admin/activity'),
};

// ═══════════════════════════════════════════════════════════
//  SHIPPING
// ═══════════════════════════════════════════════════════════
export const Shipping = {
  list:         params    => api.get('/shipping', { params }),
  track:        orderId   => api.get(`/shipping/track/${orderId}`),
  update:       (id, b)   => api.patch(`/admin/shipping/${id}`, b),
  addAttempt:   (id, b)   => api.patch(`/admin/shipping/${id}/attempt`, b),
  slaBreaches:  ()        => api.get('/admin/shipping/sla-breaches'),
};

export default api;
