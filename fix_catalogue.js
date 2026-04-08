const fs = require('fs');
const file = '/app/routes/catalogue.js';
let c = fs.readFileSync(file, 'utf8');

// Replace LIMIT ? OFFSET ? with embedded template literals
c = c.replace(/`([^`]*?)LIMIT \? OFFSET \?`\s*,\s*\[\.\.\.params,\s*Number\(limit\),\s*Number\(offset\)\]/gs, 
  (match, before) => '`' + before + 'LIMIT ${Number(limit)} OFFSET ${Number(offset)}`, [...params]');

c = c.replace(/`([^`]*?)LIMIT \? OFFSET \?`\s*,\s*\[toInt\(req\.params\.id\),\s*Number\(limit\),\s*Number\(offset\)\]/gs,
  (match, before) => '`' + before + 'LIMIT ${Number(limit)} OFFSET ${Number(offset)}`, [toInt(req.params.id)]');

fs.writeFileSync(file, c, 'utf8');

// Verify
const lines = c.split('\n');
lines.forEach((l,i) => { if(l.includes('LIMIT') && l.includes('OFFSET')) console.log(i+1, l.trim()); });
console.log('Fix complete!');
