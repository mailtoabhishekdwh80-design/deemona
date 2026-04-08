// services/upload.js  — File Upload Service (Multer + Cloudinary)
'use strict';
const multer     = require('multer');
const path       = require('path');
const fs         = require('fs');
const crypto     = require('crypto');
const { fail }   = require('../middleware/index');

// ── Allowed types ──────────────────────────────────────────
const IMAGE_MIME  = ['image/jpeg','image/png','image/webp','image/gif'];
const MAX_SIZE    = 5 * 1024 * 1024;   // 5 MB
const MAX_FILES   = 6;

// ── Local storage ──────────────────────────────────────────
const LOCAL_DIR = process.env.UPLOAD_DIR || path.join(__dirname, '..', 'public', 'uploads');
if (!fs.existsSync(LOCAL_DIR)) fs.mkdirSync(LOCAL_DIR, { recursive: true });

const localStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    const sub = file.fieldname === 'productImages' ? 'products'
              : file.fieldname === 'avatar'        ? 'avatars'
              : 'misc';
    const dir = path.join(LOCAL_DIR, sub);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uid  = crypto.randomBytes(8).toString('hex');
    const ext  = path.extname(file.originalname).toLowerCase();
    cb(null, `${Date.now()}-${uid}${ext}`);
  },
});

// ── Cloudinary upload (if CLOUDINARY_URL set) ─────────────
let cloudinaryUpload = null;
if (process.env.CLOUDINARY_URL || process.env.CLOUDINARY_CLOUD_NAME) {
  try {
    const cloudinary   = require('cloudinary').v2;
    const { CloudinaryStorage } = require('multer-storage-cloudinary');
    cloudinary.config({
      cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
      api_key:    process.env.CLOUDINARY_API_KEY,
      api_secret: process.env.CLOUDINARY_API_SECRET,
    });
    cloudinaryUpload = new CloudinaryStorage({
      cloudinary,
      params: (req, file) => ({
        folder: `deemona/${file.fieldname === 'productImages' ? 'products' : 'misc'}`,
        allowed_formats: ['jpg','jpeg','png','webp'],
        transformation: [{ quality: 'auto', fetch_format: 'auto' }],
        public_id: `${Date.now()}-${crypto.randomBytes(6).toString('hex')}`,
      }),
    });
    console.log('[UPLOAD] ✅ Cloudinary configured');
  } catch {
    console.warn('[UPLOAD] Cloudinary packages not installed — using local storage');
  }
}

// ── File filter ────────────────────────────────────────────
const fileFilter = (req, file, cb) => {
  if (!IMAGE_MIME.includes(file.mimetype)) {
    return cb(new Error(`Invalid file type: ${file.mimetype}. Allowed: JPEG, PNG, WebP, GIF`));
  }
  cb(null, true);
};

// ── Multer instances ───────────────────────────────────────
const storage   = cloudinaryUpload || localStorage;
const uploader  = multer({ storage, fileFilter, limits: { fileSize: MAX_SIZE } });

// ── Middleware factories ───────────────────────────────────
const uploadProductImages = uploader.array('productImages', MAX_FILES);
const uploadAvatar        = uploader.single('avatar');
const uploadSingle        = uploader.single('file');

// ── Error handler for multer errors ───────────────────────
const handleUploadError = (err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    if (err.code === 'LIMIT_FILE_SIZE')  return fail(res, `File too large. Max ${MAX_SIZE/1024/1024}MB`, 400);
    if (err.code === 'LIMIT_FILE_COUNT') return fail(res, `Max ${MAX_FILES} files allowed`, 400);
    return fail(res, `Upload error: ${err.message}`, 400);
  }
  if (err?.message?.includes('Invalid file type')) return fail(res, err.message, 400);
  next(err);
};

// ── Extract URLs from uploaded files ──────────────────────
const getFileURLs = (files, req) => {
  if (!files) return [];
  const arr = Array.isArray(files) ? files : [files];
  return arr.map(f => {
    // Cloudinary provides .path as a URL directly
    if (f.path?.startsWith('http')) return f.path;
    // Local: build URL from filename
    const sub  = f.destination?.includes('products') ? 'products' : f.destination?.includes('avatars') ? 'avatars' : 'misc';
    const base = process.env.APP_URL || `http://localhost:${process.env.PORT || 3000}`;
    return `${base}/uploads/${sub}/${f.filename}`;
  });
};

// ── Delete file helper ─────────────────────────────────────
const deleteFile = async (urlOrPublicId) => {
  if (!urlOrPublicId) return;
  // Cloudinary deletion
  if (cloudinaryUpload && process.env.CLOUDINARY_CLOUD_NAME) {
    try {
      const cloudinary = require('cloudinary').v2;
      // Extract public_id from URL
      const match = urlOrPublicId.match(/\/v\d+\/(.+)\.\w+$/);
      if (match) await cloudinary.uploader.destroy(match[1]);
    } catch(e) { console.warn('[UPLOAD] Cloudinary delete failed:', e.message); }
    return;
  }
  // Local deletion
  try {
    const filePath = path.join(LOCAL_DIR, urlOrPublicId.replace(/.*\/uploads\//, ''));
    if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
  } catch(e) { console.warn('[UPLOAD] Local delete failed:', e.message); }
};

module.exports = {
  uploadProductImages,
  uploadAvatar,
  uploadSingle,
  handleUploadError,
  getFileURLs,
  deleteFile,
};
