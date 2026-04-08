import React, { useState, useEffect, useRef } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";
import { useCart } from "../context/CartContext.jsx";
import { Search } from "../api/index.js";

const ALL_CATS = ["Electronics","Mobiles","Computers","Cameras","Audio","TVs","Clothing","Footwear","Watches","Bags & Luggage","Books","Home Decor","Home Appliances","Kitchen","Furniture","Gym Accessories","Sports","Medicines","Beauty","Personal Care","Baby Products","Toys & Games","Groceries","Pet Supplies","Musical Instruments","Garden","Automotive","Office Supplies","Jewellery","Stationery"];
const CATEGORIES = [
  "Electronics","Mobiles","Computers","Cameras","Audio","TVs",
  "Clothing","Footwear","Watches","Bags & Luggage","Jewellery",
  "Books","Home Decor","Home Appliances","Kitchen","Furniture","Garden",
  "Gym Accessories","Sports","Medicines","Beauty","Personal Care",
  "Baby Products","Toys & Games","Groceries","Pet Supplies",
  "Musical Instruments","Automotive","Office Supplies","Stationery"
];

export default function Navbar() {
  const { isAuthed, isAdmin, user, logout } = useAuth();
  const { count } = useCart();
  const navigate = useNavigate();
  const location = useLocation();
  const [query, setQuery] = useState("");
  const [searchCat, setSearchCat] = useState("All");
  const [suggestions, setSuggestions] = useState([]);
  const [showSug, setShowSug] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);
  const [userMenu, setUserMenu] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const searchRef = useRef(null);
  const userRef = useRef(null);
  const sugTimer = useRef(null);

  useEffect(() => {
    const fn = () => setScrolled(window.scrollY > 40);
    window.addEventListener("scroll", fn, { passive: true });
    return () => window.removeEventListener("scroll", fn);
  }, []);

  useEffect(() => { setMenuOpen(false); setUserMenu(false); }, [location]);

  useEffect(() => {
    clearTimeout(sugTimer.current);
    if (!query || query.length < 2) { setSuggestions([]); setShowSug(false); return; }
    sugTimer.current = setTimeout(async () => {
      try {
        const d = await Search.autocomplete(query);
        setSuggestions(d.data || []);
        setShowSug(true);
      } catch { setSuggestions([]); }
    }, 250);
    return () => clearTimeout(sugTimer.current);
  }, [query]);

  useEffect(() => {
    const fn = e => {
      if (searchRef.current && !searchRef.current.contains(e.target)) setShowSug(false);
      if (userRef.current && !userRef.current.contains(e.target)) setUserMenu(false);
    };
    document.addEventListener("mousedown", fn);
    return () => document.removeEventListener("mousedown", fn);
  }, []);

  const handleSearch = e => {
    e.preventDefault();
    if (!query.trim() && searchCat !== "All") {
      navigate("/shop/" + encodeURIComponent(searchCat));
      setShowSug(false);
      return;
    }
    if (!query.trim()) return;
    const cat = searchCat !== "All" ? "&category=" + encodeURIComponent(searchCat) : "";
    navigate("/search?q=" + encodeURIComponent(query.trim()) + cat);
    setShowSug(false);
  };

  const handleLogout = async () => { await logout(); navigate("/"); };

  const navLink = { padding: "4px 10px", border: "1px solid transparent", borderRadius: 4, color: "#fff", textDecoration: "none", transition: "border-color .15s" };

  return (
    <header style={{ position: "sticky", top: 0, zIndex: 1000, background: "#1B3A6B", boxShadow: scrolled ? "0 2px 8px rgba(0,0,0,.25)" : "none" }}>
      <div style={{ maxWidth: 1400, margin: "0 auto", padding: "0 16px", display: "flex", alignItems: "center", gap: 12, height: 60 }}>

        <Link to="/" style={{ textDecoration: "none" }}>
          <span style={{ fontSize: 22, fontWeight: 800, color: "#fff" }}>Deemona</span>
        </Link>

        <div style={{ display: "flex", flexDirection: "column", padding: "4px 6px" }}>
          <span style={{ fontSize: 11, color: "rgba(255,255,255,.65)" }}>Deliver to</span>
          <span style={{ fontSize: 13, fontWeight: 700, color: "#fff" }}>India</span>
        </div>

        <div ref={searchRef} style={{ flex: 1, position: "relative", display: "flex", borderRadius: 6, overflow: "hidden" }}>
          <select
            id="nav-cat"
            value={searchCat}
            onChange={e => { setSearchCat(e.target.value); if (e.target.value !== "All") navigate("/shop/" + encodeURIComponent(e.target.value)); }}
            style={{ padding: "0 8px", background: "#f3f3f3", border: "none", fontSize: 12, color: "#555", cursor: "pointer", borderRight: "1px solid #ccc", outline: "none", height: 40, minWidth: 80 }}
          >
            <option value="All">All</option>
            {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
          </select>
          <form onSubmit={handleSearch} style={{ flex: 1, display: "flex" }}>
            <input
              type="text" value={query} onChange={e => setQuery(e.target.value)}
              placeholder="Search Deemona.com"
              style={{ flex: 1, height: 40, padding: "0 14px", border: "none", fontSize: 14, outline: "none", color: "#111", background: "#fff" }}
            />
            <button type="submit" style={{ width: 50, height: 40, background: "#00ACC1", border: "none", cursor: "pointer", color: "#fff", fontSize: 13, fontWeight: 600 }}>Go</button>
          </form>
          {showSug && suggestions.length > 0 && (
            <div style={{ position: "absolute", top: "110%", left: 0, right: 0, background: "#fff", border: "1px solid #ddd", borderRadius: 4, boxShadow: "0 4px 16px rgba(0,0,0,.15)", zIndex: 500 }}>
              {suggestions.slice(0, 8).map(p => (
                <div key={p.ProductID}
                  onClick={() => { navigate("/product/" + p.ProductID); setShowSug(false); setQuery(""); }}
                  style={{ display: "flex", justifyContent: "space-between", padding: "9px 16px", cursor: "pointer", fontSize: 14, color: "#111", borderBottom: "1px solid #f5f5f5" }}
                  onMouseEnter={e => e.currentTarget.style.background = "#f5f5f5"}
                  onMouseLeave={e => e.currentTarget.style.background = "#fff"}
                >
                  <span>{p.Name}</span>
                  <span style={{ color: "#B12704", fontWeight: 600 }}>Rs.{p.Price}</span>
                </div>
              ))}
            </div>
          )}
        </div>

        <div style={{ display: "flex", alignItems: "center", gap: 4 }}>
          {isAuthed ? (
            <div ref={userRef} style={{ position: "relative" }}>
              <button onClick={() => setUserMenu(!userMenu)}
                style={{ ...navLink, display: "flex", flexDirection: "column", background: "none", cursor: "pointer", textAlign: "left" }}
                onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
                onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
              >
                <span style={{ fontSize: 11, color: "rgba(255,255,255,.8)" }}>Hello, {user?.FirstName || "Account"}</span>
                <span style={{ fontSize: 13, fontWeight: 700, color: "#fff" }}>Account</span>
              </button>
              {userMenu && (
                <div style={{ position: "absolute", top: "110%", right: 0, width: 200, background: "#fff", border: "1px solid #ddd", borderRadius: 6, boxShadow: "0 4px 20px rgba(0,0,0,.15)", zIndex: 600 }}>
                  <div style={{ padding: "12px 16px", background: "#f5f5f5", borderBottom: "1px solid #ddd" }}>
                    <div style={{ fontSize: 13, fontWeight: 600 }}>{user?.FirstName} {user?.LastName}</div>
                    <div style={{ fontSize: 12, color: "#555" }}>{user?.Email}</div>
                  </div>
                  {[{ label: "My Orders", to: "/orders" }, { label: "Wishlist", to: "/wishlist" }, { label: "Profile", to: "/profile" }, ...(isAdmin ? [{ label: "Admin Panel", to: "/admin" }] : [])].map(item => (
                    <Link key={item.to} to={item.to} style={{ display: "block", padding: "10px 16px", fontSize: 13, color: "#111", borderBottom: "1px solid #f5f5f5", textDecoration: "none" }}
                      onMouseEnter={e => e.target.style.background = "#f5f5f5"}
                      onMouseLeave={e => e.target.style.background = "transparent"}
                    >{item.label}</Link>
                  ))}
                  <button onClick={handleLogout} style={{ width: "100%", padding: "10px 16px", textAlign: "left", fontSize: 13, color: "#B12704", background: "transparent", border: "none", cursor: "pointer" }}>Sign Out</button>
                </div>
              )}
            </div>
          ) : (
            <Link to="/auth" style={{ ...navLink, display: "flex", flexDirection: "column" }}
              onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
              onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
            >
              <span style={{ fontSize: 11, color: "rgba(255,255,255,.8)" }}>Hello, sign in</span>
              <span style={{ fontSize: 13, fontWeight: 700 }}>Account</span>
            </Link>
          )}

          <Link to="/orders" style={{ ...navLink, display: "flex", flexDirection: "column" }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >
            <span style={{ fontSize: 11, color: "rgba(255,255,255,.8)" }}>Returns</span>
            <span style={{ fontSize: 13, fontWeight: 700 }}>Orders</span>
          </Link>

          <Link to="/cart" style={{ ...navLink, display: "flex", alignItems: "center", gap: 6, position: "relative" }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >
            <div style={{ position: "relative" }}>
              <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
              </svg>
              {count > 0 && <span style={{ position: "absolute", top: -8, right: -8, background: "#F0C14B", color: "#111", width: 18, height: 18, borderRadius: "50%", fontSize: 11, fontWeight: 800, display: "flex", alignItems: "center", justifyContent: "center" }}>{count > 9 ? "9+" : count}</span>}
            </div>
            <span style={{ fontSize: 14, fontWeight: 700 }}>Cart</span>
          </Link>
        </div>
      </div>

      <div style={{ background: "#0F2D55", padding: "0 16px", display: "flex", alignItems: "center", gap: 4, minHeight: 44, overflowX: "auto", flexWrap: "nowrap" }}>
        <button onClick={() => setMenuOpen(!menuOpen)}
          style={{ padding: "8px 12px", color: "#fff", background: "none", border: "1px solid transparent", borderRadius: 4, fontSize: 13, fontWeight: 700, cursor: "pointer", whiteSpace: "nowrap" }}
          onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
          onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
        >All Categories</button>
        {CATEGORIES.map(c => (
          <Link key={c} to={"/shop/" + encodeURIComponent(c)}
            style={{ padding: "8px 12px", color: "#fff", fontSize: 13, fontWeight: 500, whiteSpace: "nowrap", textDecoration: "none", border: "1px solid transparent", borderRadius: 4 }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >{c}</Link>
        ))}
        <Link to="/shop?featured=true" style={{ padding: "8px 12px", color: "#00ACC1", fontSize: 13, fontWeight: 700, whiteSpace: "nowrap", textDecoration: "none", marginLeft: "auto" }}>Today Deals</Link>
      </div>

      {menuOpen && (
        <div style={{ background: "#fff", borderBottom: "1px solid #ddd", padding: "16px", display: "grid", gridTemplateColumns: "repeat(4,1fr)", gap: 8 }}>
          {CATEGORIES.map(c => (
            <Link key={c} to={"/shop/" + encodeURIComponent(c)}
              style={{ padding: "10px 14px", borderRadius: 6, color: "#111", fontSize: 13, fontWeight: 600, textDecoration: "none" }}
              onMouseEnter={e => e.currentTarget.style.background = "#f5f5f5"}
              onMouseLeave={e => e.currentTarget.style.background = "transparent"}
            >{c}</Link>
          ))}
        </div>
      )}
    </header>
  );
}