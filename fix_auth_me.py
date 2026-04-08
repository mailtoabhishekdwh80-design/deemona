with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "r", encoding="utf-8") as f:
    code = f.read()

# Fix boot - decode JWT to check if admin token, use admin/me endpoint
old = """      Auth.me()
        .then(d => {
          const userData = d.data.customer || d.data.admin || d.data || {};
          if (!userData.role) {
            const decoded = decodeJWT(token);
            userData.role = decoded.role;
            userData.FirstName = userData.FirstName || decoded.email?.split('@')[0] || 'Admin';
          }
          setUser(userData);
        })"""

new = """      (() => {
          const decoded = decodeJWT(token);
          const isAdminToken = decoded.role && ['admin','super_admin','manager','support'].includes(decoded.role);
          const meCall = isAdminToken ? Auth.adminMe() : Auth.me();
          return meCall.then(d => {
            const userData = d.data.admin || d.data.customer || d.data || {};
            if (!userData.role) userData.role = decoded.role;
            if (!userData.email) userData.email = decoded.email;
            if (!userData.FirstName) userData.FirstName = decoded.email?.split('@')[0] || 'Admin';
            setUser(userData);
          });
        })()"""

code = code.replace(old, new)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
