const fs = require('fs');
const file = '/app/routes/../public/index.html';

// Fix Navbar inside the built JS
const assetsDir = '/var/www/frontend/assets';
const jsFiles = require('fs').readdirSync(assetsDir).filter(f => f.endsWith('.js'));
console.log('JS files:', jsFiles);
