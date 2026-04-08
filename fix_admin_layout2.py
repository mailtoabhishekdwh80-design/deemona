content = """import React, { useState } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";

const NAV = [
  { label: "Dashboard",  path: "/admin",            icon: "#" },
  { label: "Products",   path: "/admin/products",   icon: "+" },
  { label: "Orders",     path: "/admin/orders",     icon: "@" },
  { label: "Customers",  path: "/admin/customers",  icon: "*" },
  { label: "Inventory",  path: "/admin/inventory",  icon: "!" },
];

const C = {
  bg:"#0f172a", bg2:"#1e293b", border:"rgba(255,255,255,0.07)",
  text:"#e8eaf0", muted:"#7a8299", blue:"#5b8df6",
};

export default function AdminLayout({ children }) {
  const location = useLocation();
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const [collapsed, setCollapsed] = useState(false);

  const handleLogout = async () => { await logout(); navigate("/"); };

  return (
    <div style={{ display:"flex", minHeight:"100vh", background:C.bg, fontFamily:"system-ui,-apple-system,sans-serif" }}>

      <aside style={{ width:collapsed?64:240, flexShrink:0, background:C.bg2,
        borderRight:`1px solid ${C.border}`, transition:"width .3s ease",
        overflow:"hidden", position:"sticky", top:0, height:"100vh",
        display:"flex", flexDirection:"column" }}>

        <div style={{ padding:"18px 14px", borderBottom:`1px solid ${C.border}`,
          display:"flex", alignItems:"center", gap:10, minHeight:64 }}>
          <div style={{ width:34, height:34, borderRadius:10,
            background:"linear-gradient(135deg,#3b82f6,#6366f1)",
            display:"flex", alignItems:"center", justifyContent:"center",
            flexShrink:0, fontSize:16, fontWeight:800, color:"#fff" }}>D</div>
          {!collapsed&&<div style={{ overflow:"hidden" }}>
            <div style={{ fontSize:15, fontWeight:800, color:C.text, whiteSpace:"nowrap" }}>Deemona</div>
            <div style={{ fontSize:10, color:C.muted, textTransform:"uppercase", letterSpacing:".1em", fontFamily:"monospace" }}>Admin Panel</div>
          </div>}
          <button onClick={()=>setCollapsed(!collapsed)} style={{ marginLeft:"auto",
            background:"rgba(255,255,255,0.06)", border:`1px solid ${C.border}`,
            borderRadius:6, width:26, height:26, cursor:"pointer", color:C.muted,
            fontSize:12, display:"flex", alignItems:"center", justifyContent:"center", flexShrink:0 }}>
            {collapsed?">":"<"}
          </button>
        </div>

        {!collapsed&&<div style={{ padding:"12px 16px", borderBottom:`1px solid rgba(255,255,255,0.04)` }}>
          <div style={{ display:"flex", alignItems:"center", gap:10 }}>
            <div style={{ width:36, height:36, borderRadius:"50%",
              background:"linear-gradient(135deg,#6366f1,#8b5cf6)",
              display:"flex", alignItems:"center", justifyContent:"center",
              color:"#fff", fontSize:14, fontWeight:700, flexShrink:0 }}>
              {(user?.FirstName||user?.email||"A")[0].toUpperCase()}
            </div>
            <div style={{ overflow:"hidden" }}>
              <div style={{ fontSize:13, fontWeight:700, color:C.text, whiteSpace:"nowrap", overflow:"hidden", textOverflow:"ellipsis" }}>
                {user?.FirstName||"Admin"} {user?.LastName||""}
              </div>
              <div style={{ fontSize:11, color:"#6366f1", fontWeight:600, textTransform:"capitalize" }}>
                {(user?.role||"super_admin").replace("_"," ")}
              </div>
            </div>
          </div>
        </div>}

        <nav style={{ padding:"10px 8px", flex:1, overflowY:"auto" }}>
          {!collapsed&&<div style={{ fontSize:9, fontWeight:700, color:"#475569",
            textTransform:"uppercase", letterSpacing:".12em",
            padding:"6px 10px 8px", fontFamily:"monospace" }}>Navigation</div>}
          {NAV.map(item=>{
            const active = location.pathname===item.path ||
              (item.path!=="/admin" && location.pathname.startsWith(item.path));
            return (
              <Link key={item.path} to={item.path} style={{
                display:"flex", alignItems:"center", gap:12, padding:"10px 12px",
                borderRadius:10, marginBottom:2, textDecoration:"none",
                color:active?"#fff":C.muted,
                background:active?"linear-gradient(135deg,rgba(59,130,246,0.25),rgba(99,102,241,0.15))":"transparent",
                border:active?`1px solid rgba(99,102,241,0.3)`:`1px solid transparent`,
                boxShadow:active?"0 2px 12px rgba(99,102,241,0.15)":"none",
                transition:"all .15s", whiteSpace:"nowrap", overflow:"hidden",
              }}
                onMouseEnter={e=>{if(!active){e.currentTarget.style.background="rgba(255,255,255,0.05)";e.currentTarget.style.color=C.text;}}}
                onMouseLeave={e=>{if(!active){e.currentTarget.style.background="transparent";e.currentTarget.style.color=C.muted;}}}
              >
                <span style={{ flexShrink:0, fontSize:16, width:20, textAlign:"center",
                  color:active?"#60a5fa":C.muted, fontWeight:700 }}>{item.icon}</span>
                {!collapsed&&<span style={{ fontSize:13, fontWeight:600 }}>{item.label}</span>}
                {active&&!collapsed&&<div style={{ marginLeft:"auto", width:6, height:6,
                  borderRadius:"50%", background:"#60a5fa" }}/>}
              </Link>
            );
          })}
        </nav>

        <div style={{ padding:"10px 8px", borderTop:`1px solid ${C.border}` }}>
          <Link to="/" style={{ display:"flex", alignItems:"center", gap:12, padding:"9px 12px",
            borderRadius:10, textDecoration:"none", color:C.muted,
            marginBottom:4, transition:"all .15s", whiteSpace:"nowrap", overflow:"hidden" }}
            onMouseEnter={e=>e.currentTarget.style.color=C.text}
            onMouseLeave={e=>e.currentTarget.style.color=C.muted}
          >
            <span style={{ fontSize:15, width:20, textAlign:"center" }}>{"<"}</span>
            {!collapsed&&<span style={{ fontSize:13, fontWeight:500 }}>View Store</span>}
          </Link>
          <button onClick={handleLogout} style={{ display:"flex", alignItems:"center", gap:12,
            padding:"9px 12px", borderRadius:10, background:"transparent", border:"none",
            cursor:"pointer", color:C.muted, width:"100%", textAlign:"left",
            whiteSpace:"nowrap", overflow:"hidden", transition:"all .15s" }}
            onMouseEnter={e=>{e.currentTarget.style.color="#f87171";e.currentTarget.style.background="rgba(248,113,113,0.08)";}}
            onMouseLeave={e=>{e.currentTarget.style.color=C.muted;e.currentTarget.style.background="transparent";}}
          >
            <span style={{ fontSize:15, width:20, textAlign:"center" }}>x</span>
            {!collapsed&&<span style={{ fontSize:13, fontWeight:500 }}>Sign Out</span>}
          </button>
        </div>
      </aside>

      <div style={{ flex:1, overflow:"auto", background:C.bg }}>
        {children}
      </div>
    </div>
  );
}
"""

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\AdminLayout.jsx", "w", encoding="utf-8") as f:
    f.write(content)
print("AdminLayout.jsx updated!")
