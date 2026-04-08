const fs = require('fs');
const file = '/var/www/frontend/assets/index-ChYG-8Mi.js';
let code = fs.readFileSync(file, 'utf8');

// Find the search navigate call and add category support
// The compiled code will have something like navigate("/search?q="+...)
const before = code.length;

// Add category to search navigation
code = code.replace(
  /navigate\("\/search\?q="\+encodeURIComponent\((\w+)\.trim\(\)\)\)/g,
  (match, queryVar) => {
    return `(()=>{const s=document.getElementById("nav-search-cat");const cat=s&&s.value!=="All"?"&category="+encodeURIComponent(s.value):"";navigate("/search?q="+encodeURIComponent(${queryVar}.trim())+cat)})()`;
  }
);

// Add id to the select - find the select with padding:"0 8px" and add id
code = code.replace(
  /({padding:"0 8px",background:"#f3f3f3",border:"none",fontSize:12,color:"#555",cursor:"pointer",borderRight:"1px solid #ccc",outline:"none",height:40})/g,
  '{id:"nav-search-cat",padding:"0 8px",background:"#f3f3f3",border:"none",fontSize:12,color:"#555",cursor:"pointer",borderRight:"1px solid #ccc",outline:"none",height:40}'
);

const after = code.length;
console.log("Changed:", before !== after ? "YES" : "NO - pattern not found");
console.log("File size before:", before, "after:", after);

// Check if pattern exists
const hasNavigate = code.includes('navigate("/search?q="');
const hasNavSearch = code.includes('navigate(`/search?q=');
console.log("Has navigate search pattern:", hasNavigate, hasNavSearch);

fs.writeFileSync(file, code);
