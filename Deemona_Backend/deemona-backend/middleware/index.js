// middleware/index.js
'use strict';
const jwt        = require('jsonwebtoken');
const rateLimit  = require('express-rate-limit');
const { validationResult } = require('express-validator');

const JWT = process.env.JWT_SECRET || 'deemona-change-in-production';

// ── RESPONSE HELPERS ───────────────────────────────────────
const ok   = (res, data, status = 200) => res.status(status).json({ success: true,  data });
const fail = (res, msg,  status = 400) => res.status(status).json({ success: false, error: msg });
const wrap = fn => (req, res, next) => Promise.resolve(fn(req, res, next)).catch(next);

// ── PAGINATION ─────────────────────────────────────────────
const paginate = q => {
  const page  = Math.max(1, parseInt(q.page  || 1));
  const limit = Math.min(100, Math.max(1, parseInt(q.limit || 20)));
  return { page, limit, offset: (page - 1) * limit };
};

// ── VALIDATION ─────────────────────────────────────────────
const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) return fail(res, errors.array().map(e => e.msg).join('; '), 422);
  next();
};

// ── AUTH ───────────────────────────────────────────────────
const authenticate = (req, res, next) => {
  const h = req.headers['authorization'];
  if (!h?.startsWith('Bearer ')) return fail(res, 'Bearer token required', 401);
  try {
    req.user = jwt.verify(h.slice(7), JWT);
    next();
  } catch {
    fail(res, 'Invalid or expired token', 401);
  }
};

const adminOnly = (req, res, next) => {
  if (!['admin','super_admin','manager','support'].includes(req.user?.role)) return fail(res, 'Admin access required', 403);
  next();
};

const selfOrAdmin = (paramKey = 'id') => (req, res, next) => {
  if (req.user?.role === 'admin') return next();
  if (req.user?.id === parseInt(req.params[paramKey])) return next();
  return fail(res, 'Access denied', 403);
};

// ── RATE LIMITERS ──────────────────────────────────────────
const limiters = {
  api:    rateLimit({ windowMs: 15*60*1000, max: 300, message: { success:false, error:'Too many requests, slow down.' } }),
  auth:   rateLimit({ windowMs: 15*60*1000, max: 20,  message: { success:false, error:'Too many auth attempts.' } }),
  write:  rateLimit({ windowMs:    60*1000, max: 60,  message: { success:false, error:'Write rate limit exceeded.' } }),
  search: rateLimit({ windowMs:    60*1000, max: 120, message: { success:false, error:'Search rate limit exceeded.' } }),
};

// ── INT HELPER ─────────────────────────────────────────────
const toInt = v => parseInt(v, 10);

module.exports = { ok, fail, wrap, paginate, validate, authenticate, adminOnly, selfOrAdmin, limiters, toInt };
