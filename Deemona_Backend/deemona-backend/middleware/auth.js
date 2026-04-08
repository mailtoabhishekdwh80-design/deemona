// middleware/auth.js  — Complete Auth System (MySQL)
'use strict';
const jwt    = require('jsonwebtoken');
const crypto = require('crypto');
const pool   = require('../config/db');

const ACCESS_SECRET  = process.env.JWT_SECRET         || 'deemona-access-change-me';
const REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'deemona-refresh-change-me';
const ACCESS_TTL     = process.env.JWT_ACCESS_TTL     || '15m';
const REFRESH_TTL    = process.env.JWT_REFRESH_TTL    || '7d';

const ROLE_LEVELS = { customer:0, support:1, manager:2, admin:3, super_admin:4 };

const signAccess  = (payload) => jwt.sign(payload, ACCESS_SECRET,  { expiresIn: ACCESS_TTL });
const signRefresh = (payload) => jwt.sign(payload, REFRESH_SECRET, { expiresIn: REFRESH_TTL });
const generateRefreshToken = () => crypto.randomBytes(40).toString('hex');
const hashToken = (token) => crypto.createHash('sha256').update(token).digest('hex');

async function saveRefreshToken(userID, userType, token, req) {
  const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000);
  await pool.execute(
    `INSERT INTO RefreshTokens(UserID,UserType,TokenHash,ExpiresAt,IPAddress,UserAgent)
     VALUES(?,?,?,?,?,?)`,
    [userID, userType, hashToken(token), expiresAt,
     req?.ip || null,
     req?.headers?.['user-agent']?.slice(0,200) || null]
  );
}

async function denylistToken(jti, expiresAt) {
  if (!jti) return;
  await pool.execute(
    'INSERT INTO TokenDenylist(JTI,ExpiresAt) VALUES(?,?)',
    [jti, new Date(expiresAt * 1000)]
  );
}

// Check if token JTI is denylisted
async function isTokenDenylisted(jti) {
  if (!jti) return false;
  const [rows] = await pool.execute(
    'SELECT 1 FROM TokenDenylist WHERE JTI=? AND ExpiresAt > NOW()',
    [jti]
  );
  return rows.length > 0;
}

// Middleware: verify JWT access token
const authenticate = async (req, res, next) => {
  const h = req.headers['authorization'];
  if (!h?.startsWith('Bearer ')) return res.status(401).json({ success:false, error:'Bearer token required' });
  try {
    const payload = jwt.verify(h.slice(7), ACCESS_SECRET);
    if (await isTokenDenylisted(payload.jti)) {
      return res.status(401).json({ success:false, error:'Token has been revoked' });
    }
    req.user = payload;
    next();
  } catch {
    res.status(401).json({ success:false, error:'Invalid or expired token' });
  }
};

// Optional auth — attaches user if token present, doesn't fail if absent
const optionalAuth = async (req, res, next) => {
  const h = req.headers['authorization'];
  if (h?.startsWith('Bearer ')) {
    try {
      req.user = jwt.verify(h.slice(7), ACCESS_SECRET);
    } catch {}
  }
  next();
};

// RBAC: require minimum role level
const requireRole = (minRole) => (req, res, next) => {
  const userLevel  = ROLE_LEVELS[req.user?.role] ?? -1;
  const minLevel   = ROLE_LEVELS[minRole] ?? 99;
  if (userLevel < minLevel)
    return res.status(403).json({ success:false, error:`Requires ${minRole} or higher` });
  next();
};

const adminOnly   = requireRole('admin');
const managerOnly = requireRole('manager');
const supportOnly = requireRole('support');

const selfOrAdmin = (paramKey = 'id') => (req, res, next) => {
  if ((ROLE_LEVELS[req.user?.role] ?? -1) >= ROLE_LEVELS.admin) return next();
  if (req.user?.id === parseInt(req.params[paramKey])) return next();
  return res.status(403).json({ success:false, error:'Access denied' });
};

module.exports = {
  signAccess, signRefresh, generateRefreshToken, saveRefreshToken,
  denylistToken, hashToken, authenticate, optionalAuth,
  requireRole, adminOnly, managerOnly, supportOnly, selfOrAdmin,
  ROLE_LEVELS,
};
