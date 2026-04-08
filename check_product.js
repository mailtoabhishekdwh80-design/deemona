const fs = require('fs');
const file = '/app/routes/catalogue.js';
let c = fs.readFileSync(file, 'utf8');

// Fix LIMIT 6 in related products query
c = c.replace('ORDER BY AverageRating DESC LIMIT 6`, [rows[0].CategoryID, id]',
              'ORDER BY AverageRating DESC LIMIT 6`, [rows[0].CategoryID, id]');

console.log('Checking product detail route:');
const lines = c.split('\n');
lines.forEach((l,i) => { 
  if(l.includes('products/:id') || l.includes('ProductID=?') || l.includes('LIMIT 6')) 
    console.log(i+1, l.trim()); 
});
