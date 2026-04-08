// routes/auth.js  — Complete Authentication Routes (MySQL)
'use strict';
const router    = require('express').Router();
const bcrypt    = require('bcryptjs');
const crypto    = require('crypto');
const speakeasy = require('speakeasy');
const qrcode    = require('qrcode');
const { body, param } = require('express-validator');
const pool      = require('../config/db');
const {
  signAccess, signRefresh, generateRefreshToken,
  saveRefreshToken, denylistToken, hashToken,
  authenticate, adminOnly,
} = require('../middleware/auth');
const { ok, fail, wrap, validate } = require('../middleware/index');
const EmailService = require('../services/email');

const userPayload = (c, role='customer') => ({ id:c.CustomerID, email:c.Email, role, jti:crypto.randomUUID() });
const adminPayload = (a) => ({ id:a.AdminID, email:a.Email, role:a.Role, jti:crypto.randomUUID() });

// POST /api/auth/register
router.post('/register',
  [body('firstName').notEmpty().trim(), body('lastName').notEmpty().trim(),
   body('email').isEmail().normalizeEmail(),
   body('password').isLength({min:8}).matches(/[A-Z]/).withMessage('Needs uppercase').matches(/[0-9]/).withMessage('Needs number'),
   body('phone').optional().isMobilePhone()], validate,
  wrap(async (req,res) => {
    const { firstName, lastName, email, phone, password } = req.body;
    const [ex] = await pool.execute('SELECT 1 FROM Customers WHERE Email=?', [email]);
    if (ex.length) return fail(res, 'Email already registered', 409);

    const hash = await bcrypt.hash(password, 12);
    const [result] = await pool.execute(
      'INSERT INTO Customers(FirstName,LastName,Email,PhoneNumber,PasswordHash,LoyaltyPoints) VALUES(?,?,?,?,?,100)',
      [firstName, lastName, email, phone||null, hash]
    );
    const customerID = result.insertId;
    const [rows] = await pool.execute('SELECT CustomerID,FirstName,LastName,Email,LoyaltyPoints FROM Customers WHERE CustomerID=?', [customerID]);
    const customer = rows[0];
    const payload  = userPayload(customer);
    const access   = signAccess(payload);
    const refresh  = generateRefreshToken();
    await saveRefreshToken(customer.CustomerID, 'customer', refresh, req);
    EmailService.sendWelcome(customer).catch(console.error);
    ok(res, { accessToken:access, refreshToken:refresh, expiresIn:900, customer }, 201);
  })
);

// POST /api/auth/login
router.post('/login',
  [body('email').isEmail().normalizeEmail(), body('password').notEmpty()], validate,
  wrap(async (req,res) => {
    const { email, password, totpCode } = req.body;
    const [rows] = await pool.execute(
      'SELECT CustomerID,FirstName,LastName,Email,PasswordHash,AccountStatus,FailedLoginAttempts,LockedUntil,TwoFAEnabled,TwoFASecret,LoyaltyPoints,LoyaltyTier FROM Customers WHERE Email=?',
      [email]
    );
    if (!rows.length) return fail(res, 'Invalid credentials', 401);
    const c = rows[0];

    if (c.AccountStatus !== 'active') return fail(res, `Account is ${c.AccountStatus}`, 403);
    if (c.LockedUntil && new Date(c.LockedUntil) > new Date())
      return fail(res, `Account locked until ${new Date(c.LockedUntil).toISOString()}`, 429);

    const valid = await bcrypt.compare(password, c.PasswordHash);
    if (!valid) {
      const attempts = (c.FailedLoginAttempts || 0) + 1;
      if (attempts >= 5) {
        const lockUntil = new Date(Date.now() + 30*60*1000);
        await pool.execute('UPDATE Customers SET FailedLoginAttempts=?,LockedUntil=? WHERE CustomerID=?', [attempts, lockUntil, c.CustomerID]);
        return fail(res, 'Too many failed attempts. Account locked for 30 minutes.', 429);
      }
      await pool.execute('UPDATE Customers SET FailedLoginAttempts=? WHERE CustomerID=?', [attempts, c.CustomerID]);
      return fail(res, 'Invalid credentials', 401);
    }

    if (c.TwoFAEnabled) {
      if (!totpCode) return ok(res, { requires2FA:true });
      const ok2fa = speakeasy.totp.verify({ secret:c.TwoFASecret, encoding:'base32', token:totpCode, window:1 });
      if (!ok2fa) return fail(res, 'Invalid 2FA code', 401);
    }

    await pool.execute('UPDATE Customers SET FailedLoginAttempts=0,LockedUntil=NULL,LastLogin=NOW() WHERE CustomerID=?', [c.CustomerID]);
    const payload = userPayload(c);
    const access  = signAccess(payload);
    const refresh = generateRefreshToken();
    await saveRefreshToken(c.CustomerID, 'customer', refresh, req);
    ok(res, { accessToken:access, refreshToken:refresh, expiresIn:900, customer:{ CustomerID:c.CustomerID, FirstName:c.FirstName, LastName:c.LastName, Email:c.Email, LoyaltyPoints:c.LoyaltyPoints, LoyaltyTier:c.LoyaltyTier } });
  })
);

// POST /api/auth/token/refresh
router.post('/token/refresh', wrap(async (req,res) => {
  const { refreshToken } = req.body;
  if (!refreshToken) return fail(res, 'Refresh token required', 400);
  const [rows] = await pool.execute(
    `SELECT rt.*, c.CustomerID,c.Email,c.AccountStatus,c.LoyaltyTier,c.LoyaltyPoints,
            a.AdminID,a.Email AS AdminEmail,a.Role
     FROM RefreshTokens rt
     LEFT JOIN Customers c ON rt.UserType='customer' AND c.CustomerID=rt.UserID
     LEFT JOIN AdminUsers a ON rt.UserType='admin'   AND a.AdminID=rt.UserID
     WHERE rt.TokenHash=? AND rt.IsRevoked=0 AND rt.ExpiresAt > NOW()`,
    [hashToken(refreshToken)]
  );
  if (!rows.length) return fail(res, 'Invalid or expired refresh token', 401);
  const row = rows[0];
  if (row.UserType==='customer' && row.AccountStatus!=='active')
    return fail(res, 'Account not active', 403);

  await pool.execute('UPDATE RefreshTokens SET IsRevoked=1,RevokedAt=NOW() WHERE TokenHash=?', [hashToken(refreshToken)]);

  let payload;
  if (row.UserType==='customer') payload = { id:row.CustomerID, email:row.Email, role:'customer', jti:crypto.randomUUID() };
  else                           payload = { id:row.AdminID, email:row.AdminEmail, role:row.Role, jti:crypto.randomUUID() };

  const newAccess  = signAccess(payload);
  const newRefresh = generateRefreshToken();
  await saveRefreshToken(row.UserID, row.UserType, newRefresh, req);
  ok(res, { accessToken:newAccess, refreshToken:newRefresh, expiresIn:900 });
}));

// POST /api/auth/logout
router.post('/logout', wrap(async (req,res) => {
  const { refreshToken } = req.body;
  const h = req.headers['authorization'];
  if (h?.startsWith('Bearer ')) {
    try {
      const p = require('jsonwebtoken').verify(h.slice(7), process.env.JWT_SECRET||'deemona-access-change-me');
      if (p.jti && p.exp) await denylistToken(p.jti, p.exp);
    } catch {}
  }
  if (refreshToken)
    await pool.execute('UPDATE RefreshTokens SET IsRevoked=1,RevokedAt=NOW() WHERE TokenHash=?', [hashToken(refreshToken)]);
  ok(res, { message:'Logged out successfully' });
}));

// POST /api/auth/logout/all
router.post('/logout/all', authenticate, wrap(async (req,res) => {
  await pool.execute('UPDATE RefreshTokens SET IsRevoked=1,RevokedAt=NOW() WHERE UserID=? AND UserType=? AND IsRevoked=0', [req.user.id, 'customer']);
  ok(res, { message:'All sessions terminated' });
}));

// GET /api/auth/me
router.get('/me', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT CustomerID,FirstName,LastName,Email,PhoneNumber,Address,City,State,PostalCode,Country,
            LoyaltyPoints,LoyaltyTier,PreferredPaymentMethod,RegistrationDate,LastLogin,AccountStatus,TwoFAEnabled
     FROM Customers WHERE CustomerID=?`, [req.user.id]
  );
  if (!rows.length) return fail(res, 'User not found', 404);
  ok(res, rows[0]);
}));

// PUT /api/auth/change-password
router.put('/change-password', authenticate,
  [body('currentPassword').notEmpty(), body('newPassword').isLength({min:8})], validate,
  wrap(async (req,res) => {
    const { currentPassword, newPassword } = req.body;
    const [rows] = await pool.execute('SELECT PasswordHash FROM Customers WHERE CustomerID=?', [req.user.id]);
    if (!rows.length) return fail(res, 'User not found', 404);
    if (!await bcrypt.compare(currentPassword, rows[0].PasswordHash)) return fail(res, 'Current password incorrect', 401);
    const hash = await bcrypt.hash(newPassword, 12);
    await pool.execute('UPDATE Customers SET PasswordHash=? WHERE CustomerID=?', [hash, req.user.id]);
    ok(res, { message:'Password changed successfully' });
  })
);

// POST /api/auth/forgot-password
router.post('/forgot-password', [body('email').isEmail().normalizeEmail()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute('SELECT CustomerID,FirstName,Email FROM Customers WHERE Email=?', [req.body.email]);
    if (!rows.length) return ok(res, { message:'If that email exists, a reset link has been sent' });
    const token   = crypto.randomBytes(32).toString('hex');
    const expires = new Date(Date.now() + 60*60*1000);
    await pool.execute('UPDATE Customers SET PasswordResetToken=?,PasswordResetExpiry=? WHERE CustomerID=?', [token, expires, rows[0].CustomerID]);
    EmailService.sendPasswordReset(rows[0], token).catch(console.error);
    ok(res, { message:'If that email exists, a reset link has been sent' });
  })
);

// POST /api/auth/reset-password/:token
router.post('/reset-password/:token', [param('token').notEmpty(), body('password').isLength({min:8})], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute(
      'SELECT CustomerID FROM Customers WHERE PasswordResetToken=? AND PasswordResetExpiry > NOW()',
      [req.params.token]
    );
    if (!rows.length) return fail(res, 'Reset token invalid or expired', 400);
    const hash = await bcrypt.hash(req.body.password, 12);
    await pool.execute('UPDATE Customers SET PasswordHash=?,PasswordResetToken=NULL,PasswordResetExpiry=NULL WHERE CustomerID=?', [hash, rows[0].CustomerID]);
    ok(res, { message:'Password reset successfully' });
  })
);

// POST /api/auth/2fa/setup
router.post('/2fa/setup', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute('SELECT TwoFAEnabled,Email FROM Customers WHERE CustomerID=?', [req.user.id]);
  if (rows[0]?.TwoFAEnabled) return fail(res, '2FA already enabled', 400);
  const secret = speakeasy.generateSecret({ length:20, name:`Deemona (${rows[0].Email})` });
  await pool.execute('UPDATE Customers SET TwoFASecret=? WHERE CustomerID=?', [secret.base32, req.user.id]);
  const qr = await qrcode.toDataURL(secret.otpauth_url);
  ok(res, { secret:secret.base32, qrCode:qr });
}));

// POST /api/auth/2fa/verify
router.post('/2fa/verify', authenticate, [body('token').notEmpty()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute('SELECT TwoFASecret FROM Customers WHERE CustomerID=?', [req.user.id]);
    if (!rows[0]?.TwoFASecret) return fail(res, 'Setup 2FA first', 400);
    const verified = speakeasy.totp.verify({ secret:rows[0].TwoFASecret, encoding:'base32', token:req.body.token, window:1 });
    if (!verified) return fail(res, 'Invalid 2FA token', 400);
    await pool.execute('UPDATE Customers SET TwoFAEnabled=1 WHERE CustomerID=?', [req.user.id]);
    ok(res, { message:'2FA enabled successfully' });
  })
);

// DELETE /api/auth/2fa
router.delete('/2fa', authenticate, [body('password').notEmpty()], validate,
  wrap(async (req,res) => {
    const [rows] = await pool.execute('SELECT PasswordHash,TwoFASecret FROM Customers WHERE CustomerID=?', [req.user.id]);
    if (!await bcrypt.compare(req.body.password, rows[0].PasswordHash)) return fail(res, 'Invalid password', 401);
    await pool.execute('UPDATE Customers SET TwoFAEnabled=0,TwoFASecret=NULL WHERE CustomerID=?', [req.user.id]);
    ok(res, { message:'2FA disabled' });
  })
);

// ── ADMIN AUTH ────────────────────────────────────────────

// POST /api/auth/admin/login
router.post('/admin/login',
  [body('email').isEmail().normalizeEmail(), body('password').notEmpty()], validate,
  wrap(async (req,res) => {
    const { email, password, totpCode } = req.body;
    const [rows] = await pool.execute(
      'SELECT AdminID,FirstName,LastName,Email,PasswordHash,Role,IsActive,FailedAttempts,LockedUntil,TwoFAEnabled,TwoFASecret FROM AdminUsers WHERE Email=?',
      [email]
    );
    if (!rows.length) return fail(res, 'Invalid credentials', 401);
    const a = rows[0];
    if (!a.IsActive) return fail(res, 'Account inactive', 403);
    if (a.LockedUntil && new Date(a.LockedUntil) > new Date())
      return fail(res, 'Account temporarily locked', 429);

    const valid = await bcrypt.compare(password, a.PasswordHash);
    if (!valid) {
      const attempts = (a.FailedAttempts||0)+1;
      if (attempts >= 3) {
        const lockUntil = new Date(Date.now()+60*60*1000);
        await pool.execute('UPDATE AdminUsers SET FailedAttempts=?,LockedUntil=? WHERE AdminID=?', [attempts, lockUntil, a.AdminID]);
        return fail(res, 'Account locked for 1 hour', 429);
      }
      await pool.execute('UPDATE AdminUsers SET FailedAttempts=? WHERE AdminID=?', [attempts, a.AdminID]);
      return fail(res, 'Invalid credentials', 401);
    }

    if (a.TwoFAEnabled) {
      if (!totpCode) return ok(res, { requires2FA:true });
      if (!speakeasy.totp.verify({ secret:a.TwoFASecret, encoding:'base32', token:totpCode, window:1 }))
        return fail(res, 'Invalid 2FA code', 401);
    }

    await pool.execute('UPDATE AdminUsers SET FailedAttempts=0,LockedUntil=NULL,LastLogin=NOW() WHERE AdminID=?', [a.AdminID]);
    await pool.execute(
      'INSERT INTO AdminActivityLog(AdminID,Action,IPAddress,UserAgent) VALUES(?,?,?,?)',
      [a.AdminID, 'login', req.ip||null, req.headers['user-agent']?.slice(0,200)||null]
    );

    const payload = adminPayload(a);
    const access  = signAccess(payload);
    const refresh = generateRefreshToken();
    await saveRefreshToken(a.AdminID, 'admin', refresh, req);
    ok(res, { accessToken:access, refreshToken:refresh, expiresIn:900, admin:{ AdminID:a.AdminID, FirstName:a.FirstName, LastName:a.LastName, Email:a.Email, Role:a.Role } });
  })
);

// GET /api/auth/admin/me
router.get('/admin/me', authenticate, wrap(async (req,res) => {
  const [rows] = await pool.execute('SELECT AdminID,FirstName,LastName,Email,Role,IsActive,LastLogin FROM AdminUsers WHERE AdminID=?', [req.user.id]);
  if (!rows.length) return fail(res, 'Admin not found', 404);
  ok(res, rows[0]);
}));

// GET /api/auth/admin/users
router.get('/admin/users', authenticate, adminOnly, wrap(async (req,res) => {
  const [rows] = await pool.execute('SELECT AdminID,FirstName,LastName,Email,Role,IsActive,LastLogin,CreatedAt FROM AdminUsers ORDER BY CreatedAt DESC');
  ok(res, rows);
}));

// POST /api/auth/admin/users
router.post('/admin/users', authenticate, adminOnly,
  [body('email').isEmail(), body('password').isLength({min:8}), body('role').isIn(['admin','manager','support'])], validate,
  wrap(async (req,res) => {
    const { firstName, lastName, email, password, role } = req.body;
    const [ex] = await pool.execute('SELECT 1 FROM AdminUsers WHERE Email=?', [email]);
    if (ex.length) return fail(res, 'Email already registered', 409);
    const hash = await bcrypt.hash(password, 12);
    const [result] = await pool.execute(
      'INSERT INTO AdminUsers(FirstName,LastName,Email,PasswordHash,Role) VALUES(?,?,?,?,?)',
      [firstName, lastName, email, hash, role]
    );
    ok(res, { adminID:result.insertId, message:'Admin user created' }, 201);
  })
);

// PATCH /api/auth/admin/users/:id/role
router.patch('/admin/users/:id/role', authenticate, adminOnly,
  [param('id').isInt(), body('role').isIn(['admin','manager','support'])], validate,
  wrap(async (req,res) => {
    await pool.execute('UPDATE AdminUsers SET Role=? WHERE AdminID=?', [req.body.role, parseInt(req.params.id)]);
    ok(res, { message:'Role updated' });
  })
);

// DELETE /api/auth/admin/users/:id
router.delete('/admin/users/:id', authenticate, adminOnly, [param('id').isInt()], validate,
  wrap(async (req,res) => {
    await pool.execute('UPDATE AdminUsers SET IsActive=0 WHERE AdminID=?', [parseInt(req.params.id)]);
    ok(res, { message:'Admin user deactivated' });
  })
);

// GET /api/auth/admin/activity
router.get('/admin/activity', authenticate, adminOnly, wrap(async (req,res) => {
  const [rows] = await pool.execute(
    `SELECT al.*,CONCAT(a.FirstName,' ',a.LastName) AS AdminName
     FROM AdminActivityLog al LEFT JOIN AdminUsers a ON a.AdminID=al.AdminID
     ORDER BY al.CreatedAt DESC LIMIT 100`
  );
  ok(res, rows);
}));

module.exports = router;
