with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Add JWT decoder helper at top
jwt_helper = """
// Decode JWT payload without verification
const decodeJWT = token => {
  try {
    const payload = token.split('.')[1];
    return JSON.parse(atob(payload.replace(/-/g,'+').replace(/_/g,'/')));
  } catch { return {}; }
};

"""

# Add before AuthProvider
code = code.replace(
    "const AuthCtx = createContext(null);",
    "const AuthCtx = createContext(null);\n" + jwt_helper
)

# Fix login to decode JWT for user data
old = """    const userData = d.data.customer || d.data.admin || {};
    if (isAdminLogin && !userData.role) userData.role = 'admin';
    setUser(userData);"""

new = """    let userData = d.data.customer || d.data.admin || {};
    if (!userData.email && d.data.accessToken) {
      const decoded = decodeJWT(d.data.accessToken);
      userData = { ...userData, ...decoded, id: decoded.id, email: decoded.email, role: decoded.role, FirstName: decoded.email?.split('@')[0] || 'Admin' };
    }
    setUser(userData);"""

code = code.replace(old, new)

# Also fix Auth.me to handle admin token
old2 = """      Auth.me()
        .then(d => setUser(d.data))"""

new2 = """      Auth.me()
        .then(d => {
          const userData = d.data.customer || d.data.admin || d.data || {};
          if (!userData.role) {
            const decoded = decodeJWT(token);
            userData.role = decoded.role;
            userData.FirstName = userData.FirstName || decoded.email?.split('@')[0] || 'Admin';
          }
          setUser(userData);
        })"""

code = code.replace(old2, new2)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
