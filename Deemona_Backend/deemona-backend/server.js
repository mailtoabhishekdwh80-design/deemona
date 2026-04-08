
// ============================================================
//  DEEMONA — Complete Backend Server  (server.js)
//  Ready-to-run: node server.js  |  Dev: npm run dev
//  Docs: http://localhost:3000/api-docs
//  Health: http://localhost:3000/api/health
// ============================================================
'use strict';
require('dotenv').config();

const express  = require('express');
const cors     = require('cors');
const helmet   = require('helmet');
const morgan   = require('morgan');
const path     = require('path');

const authRoutes      = require('./routes/auth');
const customerRoutes  = require('./routes/customers');
const catalogueRoutes = require('./routes/catalogue');
const commerceRoutes  = require('./routes/commerce');
const extrasRoutes    = require('./routes/extras');
const missingRoutes   = require('./routes/missing');
const paymentRoutes   = require('./routes/payments');
const inventoryRoutes = require('./routes/inventory');
const { limiters }    = require('./middleware');
const jobs            = require('./services/jobs');

const app  = express();
const PORT = process.env.PORT || 3000;

app.set('trust proxy', 1);

// Raw body for webhooks
app.use('/api/payments/webhook', express.raw({ type: 'application/json' }));

// Security
app.use(helmet({ contentSecurityPolicy: false, crossOriginEmbedderPolicy: false }));

const allowedOrigins = (process.env.CORS_ORIGIN || '*').split(',').map(o => o.trim());
app.use(cors({
  origin: (origin, cb) => {
    if (!origin || allowedOrigins.includes('*') || allowedOrigins.includes(origin)) cb(null, true);
    else cb(new Error('Not allowed by CORS'));
  },
  methods: ['GET','POST','PUT','PATCH','DELETE','OPTIONS'],
  allowedHeaders: ['Content-Type','Authorization','X-Referral-Code'],
  credentials: true,
}));

app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true, limit: '2mb' }));
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));
app.use(express.static(path.join(__dirname, 'public')));

// Rate limiting
app.use('/api/', limiters.api);
app.use('/api/auth/', limiters.auth);
app.use('/api/search', limiters.search);

// Health check
app.get('/api/health', async (req, res) => {
  let dbStatus = 'unknown';
  try {
    const pool = require('./config/db');
    await pool.execute('SELECT 1');
    dbStatus = 'connected';
  } catch(e) {
    dbStatus = 'offline';
  }
  res.status(dbStatus === 'connected' ? 200 : 503).json({
    status:    dbStatus === 'connected' ? 'ok' : 'degraded',
    service:   'Deemona E-Commerce API',
    version:   '1.0.0',
    timestamp: new Date().toISOString(),
    database:  dbStatus,
    env:       process.env.NODE_ENV || 'development',
  });
});

app.get('/api/version', (req, res) => {
  res.json({ name: 'Deemona API', version: '1.0.0', nodeVersion: process.version });
});

// Routes
app.use('/api/auth',      authRoutes);
app.use('/api/customers', customerRoutes);
app.use('/api/inventory', inventoryRoutes);
app.use('/api',           catalogueRoutes);
app.use('/api',           commerceRoutes);
app.use('/api/payments',  paymentRoutes);
app.use('/api',           extrasRoutes);
app.use('/api',           missingRoutes);

// 404
app.use('/api/*', (req, res) => {
  res.status(404).json({ success: false, error: `API endpoint not found: ${req.method} ${req.path}` });
});

// SPA fallback
app.get('*', (req, res) => {
  const indexPath = path.join(__dirname, 'public', 'index.html');
  res.sendFile(indexPath, err => {
    if (err) res.status(200).send('<h1>Deemona API is running.</h1>');
  });
});

// Error handler
app.use((err, req, res, _next) => {
  console.error(`[${new Date().toISOString()}] ${req.method} ${req.path}`, err.message);
  res.status(500).json({ success: false, error: err.message || 'An unexpected error occurred.' });
});

// Start
const server = app.listen(PORT, async () => {
  console.log(`\n  DEEMONA API v1.0.0 running on port ${PORT}\n`);
  try {
    const pool = require('./config/db');
    await pool.execute('SELECT 1');
    console.log('  Database connected successfully');
    jobs.start();
  } catch(e) {
    console.warn('  Database offline:', e.message);
  }
});

server.on('error', err => {
  if (err.code === 'EADDRINUSE') {
    console.error(`Port ${PORT} is already in use.`);
    process.exit(1);
  }
  throw err;
});

process.on('SIGTERM', () => { jobs.stop(); server.close(() => process.exit(0)); });
process.on('SIGINT',  () => { jobs.stop(); server.close(() => process.exit(0)); });

module.exports = app;
