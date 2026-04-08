content = """import React, { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";

const NAV = [
  { label: "Dashboard",  path: "/admin",            icon: "grid" },
  { label: "Products",   path: "/admin/products",   icon: "box" },
  { label: "Orders",     path: "/admin/orders",     icon: "list" },
  { label: "Customers",  path: "/admin/customers",  icon: "users" },
  { label: "Inventory",  path: "/admin/inventory",  icon: "layers" },
];

const ICONS = {
  grid: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>,
  box: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>,
  list: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"/><rect x="9" y="3" width="6" height="4" rx="2"/><line x1="9" y1="12" x2="15" y2="12"/><line x1="9" y1="16" x2="13" y2="16"/></svg>,
  users: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>,
  layers: <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>,
};

export default function AdminLayout({ children }) {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const [collapsed, setCollapsed] = useState(false);

  const handleLogout = async () => { await logout(); navigate("/"); };

  return (
    <div style={{ display:"flex", minHeight:"100vh", fontFamily:"system-ui,-apple-system,sans-serif" }}>

      {/* Sidebar */}
      <aside style={{
        width: collapsed ? 68 : 240,
        flexShrink: 0,
        background: "#0f172a",
        borderRight: "1px solid #1e3a5f",
        transition: "width .3s ease",
        overflow: "hidden",
        position: "sticky",
        top: 0,
        height: "100vh",
        display: "flex",
        flexDirection: "column",
      }}>

        {/* Logo */}
        <div style={{ padding:"16px 14px", borderBottom:"1px solid #1e3a5f",
          display:"flex", alignItems:"center", gap:10, minHeight:64 }}>
          <div style={{ width:36, height:36, borderRadius:10, flexShrink:0,
            background:"linear-gradient(135deg,#3b82f6,#6366f1)",
            display:"flex", alignItems:"center", justifyContent:"center",
            fontSize:18, fontWeight:800, color:"#fff" }}>D</div>
          {!collapsed && (
            <div style={{ overflow:"hidden" }}>
              <div style={{ fontSize:15, fontWeight:800, color:"#ffffff", whiteSpace:"nowrap" }}>Deemona</div>
              <div style={{ fontSize:10, color:"#94a3b8", textTransform:"uppercase",
                letterSpacing:".1em", fontFamily:"monospace" }}>Admin Panel</div>
            </div>
          )}
          <button onClick={()=>setCollapsed(!collapsed)} style={{
            marginLeft:"auto", background:"#1e293b", border:"1px solid #334155",
            borderRadius:6, width:28, height:28, cursor:"pointer", color:"#94a3b8",
            fontSize:13, display:"flex", alignItems:"center", justifyContent:"center", flexShrink:0
          }}>{collapsed ? ">" : "<"}</button>
        </div>

        {/* User Info */}
        {!collapsed && (
          <div style={{ padding:"14px 16px", borderBottom:"1px solid #1e293b" }}>
            <div style={{ display:"flex", alignItems:"center", gap:10 }}>
              <div style={{ width:38, height:38, borderRadius:"50%", flexShrink:0,
                background:"linear-gradient(135deg,#6366f1,#8b5cf6)",
                display:"flex", alignItems:"center", justifyContent:"center",
                color:"#fff", fontSize:15, fontWeight:700 }}>
                {(user?.FirstName||user?.email||"A")[0].toUpperCase()}
              </div>
              <div style={{ overflow:"hidden" }}>
                <div style={{ fontSize:13, fontWeight:700, color:"#f1f5f9",
                  whiteSpace:"nowrap", overflow:"hidden", textOverflow:"ellipsis" }}>
                  {user?.FirstName||"Admin"} {user?.LastName||""}
                </div>
                <div style={{ fontSize:11, color:"#818cf8", fontWeight:600, textTransform:"capitalize" }}>
                  {(user?.role||"super_admin").replace("_"," ")}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* Nav */}
        <nav style={{ padding:"12px 8px", flex:1, overflowY:"auto" }}>
          {!collapsed && (
            <div style={{ fontSize:9, fontWeight:700, color:"#475569",
              textTransform:"uppercase", letterSpacing:".12em",
              padding:"4px 12px 10px", fontFamily:"monospace" }}>Main Menu</div>
          )}
          {NAV.map(item => {
            const active = location.pathname === item.path ||
              (item.path !== "/admin" && location.pathname.startsWith(item.path));
            return (
              <Link key={item.path} to={item.path} style={{
                display:"flex", alignItems:"center", gap:12,
                padding:"11px 12px", borderRadius:10, marginBottom:3,
                textDecoration:"none",
                color: active ? "#ffffff" : "#cbd5e1",
                background: active
                  ? "linear-gradient(135deg,#3b82f6,#6366f1)"
                  : "transparent",
                border: active ? "none" : "1px solid transparent",
                boxShadow: active ? "0 4px 15px rgba(99,102,241,0.4)" : "none",
                transition:"all .15s",
                whiteSpace:"nowrap", overflow:"hidden",
              }}
                onMouseEnter={e => {
                  if (!active) {
                    e.currentTarget.style.background = "#1e293b";
                    e.currentTarget.style.color = "#ffffff";
                    e.currentTarget.style.borderColor = "#334155";
                  }
                }}
                onMouseLeave={e => {
                  if (!active) {
                    e.currentTarget.style.background = "transparent";
                    e.currentTarget.style.color = "#cbd5e1";
                    e.currentTarget.style.borderColor = "transparent";
                  }
                }}
              >
                <span style={{ flexShrink:0, color: active ? "#ffffff" : "#94a3b8",
                  display:"flex", alignItems:"center" }}>
                  {ICONS[item.icon]}
                </span>
                {!collapsed && (
                  <span style={{ fontSize:13, fontWeight: active ? 700 : 500 }}>{item.label}</span>
                )}
              </Link>
            );
          })}
        </nav>

        {/* Bottom */}
        <div style={{ padding:"10px 8px", borderTop:"1px solid #1e293b" }}>
          <Link to="/" style={{
            display:"flex", alignItems:"center", gap:12, padding:"10px 12px",
            borderRadius:10, textDecoration:"none", color:"#94a3b8",
            marginBottom:4, transition:"all .15s", whiteSpace:"nowrap", overflow:"hidden",
          }}
            onMouseEnter={e => { e.currentTarget.style.color="#e2e8f0"; e.currentTarget.style.background="#1e293b"; }}
            onMouseLeave={e => { e.currentTarget.style.color="#94a3b8"; e.currentTarget.style.background="transparent"; }}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
              <polyline points="9 22 9 12 15 12 15 22"/>
            </svg>
            {!collapsed && <span style={{ fontSize:13, fontWeight:500 }}>View Store</span>}
          </Link>
          <button onClick={handleLogout} style={{
            display:"flex", alignItems:"center", gap:12, padding:"10px 12px",
            borderRadius:10, background:"transparent", border:"none", cursor:"pointer",
            color:"#94a3b8", width:"100%", textAlign:"left",
            whiteSpace:"nowrap", overflow:"hidden", transition:"all .15s",
          }}
            onMouseEnter={e => { e.currentTarget.style.color="#f87171"; e.currentTarget.style.background="rgba(248,113,113,0.1)"; }}
            onMouseLeave={e => { e.currentTarget.style.color="#94a3b8"; e.currentTarget.style.background="transparent"; }}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
              <polyline points="16 17 21 12 16 7"/>
              <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            {!collapsed && <span style={{ fontSize:13, fontWeight:500 }}>Sign Out</span>}
          </button>
        </div>
      </aside>

      {/* Content */}
      <div style={{ flex:1, overflow:"auto", background:"#0f172a" }}>
        {children}
      </div>
    </div>
  );
}
"""

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\AdminLayout.jsx", "w", encoding="utf-8") as f:
    f.write(content)
print("Done!")
