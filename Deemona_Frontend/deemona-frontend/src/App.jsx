import React, { Suspense, lazy } from 'react';
import { Routes, Route, Navigate, useLocation } from 'react-router-dom';
import Navbar    from './components/Navbar.jsx';
import Footer    from './components/Footer.jsx';
import Spinner   from './components/Spinner.jsx';
import { useAuth } from './context/AuthContext.jsx';

// Lazy-load pages for code splitting
const Home        = lazy(() => import('./pages/Home.jsx'));
const Shop        = lazy(() => import('./pages/Shop.jsx'));
const Product     = lazy(() => import('./pages/Product.jsx'));
const Cart        = lazy(() => import('./pages/Cart.jsx'));
const Checkout    = lazy(() => import('./pages/Checkout.jsx'));
const Auth        = lazy(() => import('./pages/Auth.jsx'));
const Profile     = lazy(() => import('./pages/Profile.jsx'));
const Orders      = lazy(() => import('./pages/Orders.jsx'));
const OrderDetail = lazy(() => import('./pages/OrderDetail.jsx'));
const Wishlist    = lazy(() => import('./pages/Wishlist.jsx'));
const NotFound    = lazy(() => import('./pages/NotFound.jsx'));

// Admin pages
const AdminLayout    = lazy(() => import('./pages/admin/AdminLayout.jsx'));
const AdminDashboard = lazy(() => import('./pages/admin/Dashboard.jsx'));
const AdminProducts  = lazy(() => import('./pages/admin/Products.jsx'));
const AdminOrders    = lazy(() => import('./pages/admin/Orders.jsx'));
const AdminCustomers = lazy(() => import('./pages/admin/Customers.jsx'));
const AdminInventory = lazy(() => import('./pages/admin/Inventory.jsx'));

function RequireAuth({ children }) {
  const { isAuthed, loading } = useAuth();
  const location = useLocation();
  if (loading) return <Spinner full />;
  if (!isAuthed) return <Navigate to="/auth" state={{ from: location }} replace />;
  return children;
}

function RequireAdmin({ children }) {
  const { isAuthed, isAdmin, loading } = useAuth();
  const location = useLocation();
  if (loading) return <Spinner full />;
  if (!isAuthed) return <Navigate to="/auth" state={{ from: location }} replace />;
  if (!isAdmin)  return <Navigate to="/" replace />;
  return children;
}

function RedirectIfAuthed({ children }) {
  const { isAuthed } = useAuth();
  return isAuthed ? <Navigate to="/" replace /> : children;
}

// No footer on admin pages
const NO_FOOTER = ['/admin'];

export default function App() {
  const { pathname } = useLocation();
  const hideFooter = NO_FOOTER.some(p => pathname.startsWith(p));

  return (
    <div className="app">
      <Navbar />
      <main>
        <Suspense fallback={<Spinner full />}>
          <Routes>
            {/* Public */}
            <Route path="/"             element={<Home />} />
            <Route path="/shop"         element={<Shop />} />
            <Route path="/shop/:category" element={<Shop />} />
            <Route path="/product/:id"  element={<Product />} />
            <Route path="/search"       element={<Shop />} />

            {/* Auth */}
            <Route path="/auth"         element={<RedirectIfAuthed><Auth /></RedirectIfAuthed>} />
            <Route path="/auth/reset-password/:token" element={<Auth mode="reset" />} />

            {/* Protected customer routes */}
            <Route path="/cart"         element={<RequireAuth><Cart /></RequireAuth>} />
            <Route path="/checkout"     element={<RequireAuth><Checkout /></RequireAuth>} />
            <Route path="/orders"       element={<RequireAuth><Orders /></RequireAuth>} />
            <Route path="/orders/:id"   element={<RequireAuth><OrderDetail /></RequireAuth>} />
            <Route path="/wishlist"     element={<RequireAuth><Wishlist /></RequireAuth>} />
            <Route path="/profile"      element={<RequireAuth><Profile /></RequireAuth>} />

            {/* Admin */}
            <Route path="/admin" element={<RequireAdmin><AdminLayout /></RequireAdmin>}>
              <Route index         element={<AdminDashboard />} />
              <Route path="products"  element={<AdminProducts />} />
              <Route path="orders"    element={<AdminOrders />} />
              <Route path="customers" element={<AdminCustomers />} />
              <Route path="inventory" element={<AdminInventory />} />
            </Route>

            <Route path="*" element={<NotFound />} />
          </Routes>
        </Suspense>
      </main>
      {!hideFooter && <Footer />}
    </div>
  );
}
