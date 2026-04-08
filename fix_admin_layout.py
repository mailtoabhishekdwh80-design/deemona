content = """import React, { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";

const NAV = [
  { label: "Dashboard",  path: "/admin",            icon: "dashboard" },
  { label: "Products",   path: "/admin/products",   icon: "products"  },
  { label: "Orders",     path: "/admin/orders",     icon: "orders"    },
  { label: "Customers",  path: "/admin/customers",  icon: "customers" },
  { label: "Inventory",  path: "/admin/inventory",  icon: "inventory" },
];

const ICONS = {
  dashboard: (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
      <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
    </svg>
  ),
  products: (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/>
    </svg>
  ),
  orders: (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"/>
      <rect x="9" y="3" width="6" height="4" rx="2"/><line x1="9" y1="12" x2="15" y2="12"/><line x1="9" y1="16" x2="13" y2="16"/>
    </svg>
  ),
  customers: (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
      <circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
    </svg>
  ),
  inventory: (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/>
      <line x1="8" y1="18" x2="21" y2="18"/><line x1="3" y1="6" x2="3.01" y2="6"/>
      <line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/>
    </svg>
  ),
};

export default function AdminLayout({ children }) {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const [collapsed, setCollapsed] = useState(false);

  const handleLogout = async () => {
    await logout();
    navigate("/");
  };

  return (
    <div style={{ display: "flex", minHeight: "100vh", background: "#0f172a", fontFamily: "system-ui,-apple-system,sans-serif" }}>

      {/* Sidebar */}
      <aside style={{
        width: collapsed ? 64 : 240,
        flexShrink: 0,
        background: "#1e293b",
        borderRight: "1px solid rgba(255,255,255,0.08)",
        transition: "width .3s ease",
        overflow: "hidden",
        position: "sticky",
        top: 0,
        height: "100vh",
        display: "flex",
        flexDirection: "column",
      }}>

        {/* Logo */}
        <div style={{ padding: "18px 14px", borderBottom: "1px solid rgba(255,255,255,0.08)", display: "flex", alignItems: "center", gap: 10, minHeight: 64 }}>
          <div style={{ width: 34, height: 34, borderRadius: 10, background: "linear-gradient(135deg,#3b82f6,#6366f1)", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0, fontSize: 16, fontWeight: 800, color: "#fff" }}>D</div>
          {!collapsed && (
            <div style={{ overflow: "hidden" }}>
              <div style={{ fontSize: 15, fontWeight: 800, color: "#f1f5f9", whiteSpace: "nowrap" }}>Deemona</div>
              <div style={{ fontSize: 10, color: "#64748b", textTransform: "uppercase", letterSpacing: ".1em", fontFamily: "monospace" }}>Admin Panel</div>
            </div>
          )}
          <button onClick={() => setCollapsed(!collapsed)} style={{ marginLeft: "auto", background: "rgba(255,255,255,0.06)", border: "1px solid rgba(255,255,255,0.1)", borderRadius: 6, width: 26, height: 26, cursor: "pointer", color: "#94a3b8", fontSize: 12, display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
            {collapsed ? ">" : "<"}
          </button>
        </div>

        {/* User Info */}
        {!collapsed && (
          <div style={{ padding: "14px 16px", borderBottom: "1px solid rgba(255,255,255,0.06)" }}>
            <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
              <div style={{ width: 36, height: 36, borderRadius: "50%", background: "linear-gradient(135deg,#6366f1,#8b5cf6)", display: "flex", alignItems: "center", justifyContent: "center", color: "#fff", fontSize: 14, fontWeight: 700, flexShrink: 0 }}>
                {(user?.FirstName || user?.email || "A")[0].toUpperCase()}
              </div>
              <div style={{ overflow: "hidden" }}>
                <div style={{ fontSize: 13, fontWeight: 700, color: "#f1f5f9", whiteSpace: "nowrap", overflow: "hidden", textOverflow: "ellipsis" }}>{user?.FirstName || "Admin"} {user?.LastName || "User"}</div>
                <div style={{ fontSize: 11, color: "#6366f1", fontWeight: 600, textTransform: "capitalize" }}>{user?.role?.replace("_", " ") || "Super Admin"}</div>
              </div>
            </div>
          </div>
        )}

        {/* Nav Items */}
        <nav style={{ padding: "10px 8px", flex: 1, overflowY: "auto" }}>
          {!collapsed && <div style={{ fontSize: 9, fontWeight: 700, color: "#475569", textTransform: "uppercase", letterSpacing: ".12em", padding: "6px 10px 8px", fontFamily: "monospace" }}>Main Menu</div>}
          {NAV.map(item => {
            const active = location.pathname === item.path || (item.path !== "/admin" && location.pathname.startsWith(item.path));
            return (
              <Link key={item.path} to={item.path} style={{
                display: "flex", alignItems: "center", gap: 12, padding: "10px 12px",
                borderRadius: 10, marginBottom: 2, textDecoration: "none",
                color: active ? "#fff" : "#94a3b8",
                background: active ? "linear-gradient(135deg,rgba(59,130,246,0.3),rgba(99,102,241,0.2))" : "transparent",
                border: active ? "1px solid rgba(99,102,241,0.3)" : "1px solid transparent",
                boxShadow: active ? "0 2px 12px rgba(99,102,241,0.2)" : "none",
                transition: "all .15s", whiteSpace: "nowrap", overflow: "hidden",
              }}
                onMouseEnter={e => { if (!active) { e.currentTarget.style.background = "rgba(255,255,255,0.06)"; e.currentTarget.style.color = "#e2e8f0"; } }}
                onMouseLeave={e => { if (!active) { e.currentTarget.style.background = "transparent"; e.currentTarget.style.color = "#94a3b8"; } }}
              >
                <span style={{ flexShrink: 0, color: active ? "#60a5fa" : "#64748b", display: "flex" }}>{ICONS[item.icon]}</span>
                {!collapsed && <span style={{ fontSize: 13, fontWeight: 600 }}>{item.label}</span>}
                {active && !collapsed && <div style={{ marginLeft: "auto", width: 6, height: 6, borderRadius: "50%", background: "#60a5fa" }} />}
              </Link>
            );
          })}
        </nav>

        {/* Bottom Actions */}
        <div style={{ padding: "10px 8px", borderTop: "1px solid rgba(255,255,255,0.06)" }}>
          <Link to="/" style={{ display: "flex", alignItems: "center", gap: 12, padding: "9px 12px", borderRadius: 10, textDecoration: "none", color: "#64748b", marginBottom: 4, whiteSpace: "nowrap", overflow: "hidden", transition: "all .15s" }}
            onMouseEnter={e => e.currentTarget.style.color = "#94a3b8"}
            onMouseLeave={e => e.currentTarget.style.color = "#64748b"}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ flexShrink: 0 }}>
              <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>
            </svg>
            {!collapsed && <span style={{ fontSize: 13, fontWeight: 500 }}>View Store</span>}
          </Link>
          <button onClick={handleLogout} style={{ display: "flex", alignItems: "center", gap: 12, padding: "9px 12px", borderRadius: 10, background: "transparent", border: "none", cursor: "pointer", color: "#64748b", width: "100%", textAlign: "left", whiteSpace: "nowrap", overflow: "hidden", transition: "all .15s" }}
            onMouseEnter={e => { e.currentTarget.style.color = "#f87171"; e.currentTarget.style.background = "rgba(248,113,113,0.08)"; }}
            onMouseLeave={e => { e.currentTarget.style.color = "#64748b"; e.currentTarget.style.background = "transparent"; }}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ flexShrink: 0 }}>
              <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            {!collapsed && <span style={{ fontSize: 13, fontWeight: 500 }}>Sign Out</span>}
          </button>
        </div>
      </aside>

      {/* Content */}
      <div style={{ flex: 1, overflow: "auto", background: "#0f172a" }}>
        {children}
      </div>
    </div>
  );
}
"""

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\AdminLayout.jsx", "w", encoding="utf-8") as f:
    f.write(content)
print("AdminLayout.jsx rewritten!")
