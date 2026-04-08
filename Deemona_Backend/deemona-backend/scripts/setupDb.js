// scripts/setupDb.js  — MySQL database setup
'use strict';
require('dotenv').config();
const mysql = require('mysql2/promise');
const path  = require('path');
const fs    = require('fs');

async function setup() {
  // Connect without database first to create it
  const conn = await mysql.createConnection({
    host:     process.env.DB_SERVER || 'localhost',
    port:     parseInt(process.env.DB_PORT || '3306'),
    user:     process.env.DB_USER   || 'root',
    password: process.env.DB_PASS   || 'YourPassword123!',
    multipleStatements: true,
  });

  console.log('✅  Connected to MySQL server');

  const sql = fs.readFileSync(path.join(__dirname, '..', 'migration.sql'), 'utf8');

  // Split on semicolons but preserve multi-line statements
  const statements = sql
    .split(/;\s*\n/)
    .map(s => s.trim())
    .filter(s => s.length > 0 && !s.startsWith('--'));

  let ok = 0, skip = 0, err = 0;
  for (const stmt of statements) {
    try {
      await conn.query(stmt + ';');
      ok++;
    } catch(e) {
      if (e.code === 'ER_TABLE_EXISTS_ERROR' || e.code === 'ER_DUP_ENTRY' || e.code === 'ER_DUP_KEYNAME') {
        skip++;
      } else if (e.code === 'ER_DB_CREATE_EXISTS') {
        skip++;
      } else {
        console.error(`⚠  Statement skipped (${e.code}): ${stmt.slice(0,80)}...`);
        err++;
      }
    }
  }

  await conn.end();
  console.log(`\n✅  Database setup complete`);
  console.log(`   Created/updated: ${ok} | Already existed: ${skip} | Errors: ${err}`);
  console.log(`\n📧  Default admin: admin@deemona.com`);
  console.log(`🔑  Default password: Admin@123456!  ← CHANGE THIS IMMEDIATELY\n`);
}

setup().catch(e => { console.error('❌  Setup failed:', e.message); process.exit(1); });
