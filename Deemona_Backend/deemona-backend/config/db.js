// config/db.js  — MySQL connection pool (mysql2/promise)
'use strict';
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host:               process.env.DB_SERVER   || 'localhost',
  database:           process.env.DB_NAME     || 'deemona',
  user:               process.env.DB_USER     || 'root',
  password:           process.env.DB_PASS     || 'YourPassword123!',
  port:               parseInt(process.env.DB_PORT || '3306'),
  waitForConnections: true,
  connectionLimit:    20,
  queueLimit:         0,
  timezone:           '+00:00',
  dateStrings:        false,
  charset:            'utf8mb4',
});

pool.getConnection()
  .then(conn => {
    console.log(`✅  MySQL connected → ${process.env.DB_NAME || 'deemona'}`);
    conn.release();
  })
  .catch(err => console.error('❌  MySQL connection failed:', err.message));

module.exports = pool;
