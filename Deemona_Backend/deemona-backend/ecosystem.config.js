// ecosystem.config.js — PM2 Process Manager Config
// Start:   pm2 start ecosystem.config.js --env production
// Monitor: pm2 monit
// Logs:    pm2 logs deemona-api
// Reload:  pm2 reload deemona-api   ← zero-downtime reload

module.exports = {
  apps: [
    {
      name:         'deemona-api',
      script:       './server.js',
      instances:    'max',          // one per CPU core
      exec_mode:    'cluster',      // Node cluster mode for zero-downtime reloads
      autorestart:  true,
      watch:        false,          // never watch in production
      max_memory_restart: '512M',   // restart if memory exceeds 512 MB

      // ── Environment ────────────────────────────────────
      env: {
        NODE_ENV: 'development',
        PORT:     3000,
      },
      env_production: {
        NODE_ENV:    'production',
        PORT:        3000,
        DISABLE_JOBS:'false',       // enable cron jobs in prod
      },
      env_staging: {
        NODE_ENV:     'staging',
        PORT:         3000,
        DISABLE_JOBS: 'true',       // disable jobs in staging
      },

      // ── Logging ─────────────────────────────────────────
      error_file:    './logs/pm2-error.log',
      out_file:      './logs/pm2-out.log',
      merge_logs:    true,
      log_date_format: 'YYYY-MM-DD HH:mm:ss Z',

      // ── Graceful shutdown ────────────────────────────────
      kill_timeout:       10000,    // 10s to finish in-flight requests
      listen_timeout:     5000,
      shutdown_with_message: true,

      // ── Crash protection ─────────────────────────────────
      min_uptime:      '10s',       // consider crashed if dies before 10s
      max_restarts:    10,
      restart_delay:   2000,        // wait 2s between restarts

      // ── Node.js flags ────────────────────────────────────
      node_args: [
        '--max-old-space-size=460',  // respect 512MB limit
        '--enable-source-maps',
      ],

      // ── Monitoring ────────────────────────────────────────
      // pm2 plus / keymetrics monitoring keys (optional)
      // monitoring: { enable: true },
    },
  ],

  // ── Deployment config ─────────────────────────────────
  deploy: {
    production: {
      user:         process.env.DEPLOY_USER  || 'ubuntu',
      host:         process.env.DEPLOY_HOST  || 'your-server-ip',
      ref:          'origin/main',
      repo:         process.env.DEPLOY_REPO  || 'git@github.com:yourorg/deemona-api.git',
      path:         '/var/www/deemona',
      'pre-deploy-local': '',
      'post-deploy':
        'npm ci --only=production && pm2 reload ecosystem.config.js --env production',
      'pre-setup': 'apt-get install -y git curl',
    },
  },
};
