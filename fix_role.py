with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "r", encoding="utf-8") as f:
    code = f.read()

old = """    let d;
    try {
      d = await Auth.adminLogin({ email, password, ...(totpCode && { totpCode }) });
    } catch {
      d = await Auth.login({ email, password, ...(totpCode && { totpCode }) });
    }
    if (d.data?.requires2FA) return { requires2FA: true };
    localStorage.setItem('access_token',  d.data.accessToken);
    localStorage.setItem('refresh_token', d.data.refreshToken);
    setUser(d.data.customer || d.data.admin);
    return d.data;"""

new = """    let d;
    let isAdminLogin = false;
    try {
      d = await Auth.adminLogin({ email, password, ...(totpCode && { totpCode }) });
      isAdminLogin = true;
    } catch {
      d = await Auth.login({ email, password, ...(totpCode && { totpCode }) });
    }
    if (d.data?.requires2FA) return { requires2FA: true };
    localStorage.setItem('access_token',  d.data.accessToken);
    localStorage.setItem('refresh_token', d.data.refreshToken);
    const userData = d.data.customer || d.data.admin || {};
    if (isAdminLogin && !userData.role) userData.role = 'admin';
    setUser(userData);
    return d.data;"""

code = code.replace(old, new)

with open(r"C:\Deemona\Deemona_Frontend\deemona-frontend\src\context\AuthContext.jsx", "w", encoding="utf-8") as f:
    f.write(code)

print("Fixed!")
