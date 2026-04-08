with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Add deliveryCity state after searchCat state
code = code.replace(
    'const [searchCat,   setSearchCat]   = useState("All");',
    'const [searchCat,   setSearchCat]   = useState("All");\n  const [deliveryCity, setDeliveryCity] = useState(localStorage.getItem("deliveryCity") || "India");\n  const [showCityPicker, setShowCityPicker] = useState(false);\n  const cityRef = useRef(null);'
)

# Add cityRef to existing useEffect for outside click
code = code.replace(
    'if (userRef.current   && !userRef.current.contains(e.target))   setUserMenu(false);',
    'if (userRef.current   && !userRef.current.contains(e.target))   setUserMenu(false);\n      if (cityRef.current   && !cityRef.current.contains(e.target))   setShowCityPicker(false);'
)

# Replace static Deliver to section with interactive one
code = code.replace(
    '''<div style={{ display: "flex", flexDirection: "column", padding: "4px 6px" }}>
          <span style={{ fontSize: 11, color: "rgba(255,255,255,.65)" }}>Deliver to</span>
          <span style={{ fontSize: 13, fontWeight: 700, color: "#fff" }}>India</span>
        </div>''',
    '''<div ref={cityRef} style={{ position: "relative" }}>
          <div onClick={() => setShowCityPicker(!showCityPicker)}
            style={{ display: "flex", flexDirection: "column", padding: "4px 8px", cursor: "pointer", border: "1px solid transparent", borderRadius: 4, transition: "border-color .15s" }}
            onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
            onMouseLeave={e => e.currentTarget.style.borderColor = "transparent"}
          >
            <span style={{ fontSize: 11, color: "rgba(255,255,255,.65)" }}>Deliver to</span>
            <span style={{ fontSize: 13, fontWeight: 700, color: "#fff" }}>{deliveryCity}</span>
          </div>
          {showCityPicker && (
            <div style={{ position: "absolute", top: "110%", left: 0, width: 220, background: "#fff", border: "1px solid #ddd", borderRadius: 6, boxShadow: "0 4px 20px rgba(0,0,0,.15)", zIndex: 700, overflow: "hidden" }}>
              <div style={{ padding: "10px 14px", background: "#f5f5f5", borderBottom: "1px solid #ddd", fontSize: 12, fontWeight: 700, color: "#555" }}>SELECT DELIVERY LOCATION</div>
              {["India","Delhi","Mumbai","Bangalore","Hyderabad","Chennai","Kolkata","Pune","Ahmedabad","Jaipur","Surat","Lucknow","Kanpur","Nagpur","Indore","Bhopal","Chandigarh","Noida","Gurgaon","Patna"].map(city => (
                <div key={city} onClick={() => { setDeliveryCity(city); localStorage.setItem("deliveryCity", city); setShowCityPicker(false); }}
                  style={{ padding: "9px 14px", fontSize: 13, color: deliveryCity === city ? "#00ACC1" : "#111", fontWeight: deliveryCity === city ? 700 : 400, cursor: "pointer", borderBottom: "1px solid #f5f5f5", background: deliveryCity === city ? "#f0fafa" : "#fff" }}
                  onMouseEnter={e => e.currentTarget.style.background = "#f5f5f5"}
                  onMouseLeave={e => e.currentTarget.style.background = deliveryCity === city ? "#f0fafa" : "#fff"}
                >{city}</div>
              ))}
            </div>
          )}
        </div>'''
)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\components\Navbar.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Done!")
