const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'node_modules', 'pdf-parse', 'dist', 'pdf-parse', 'cjs', 'index.cjs');
if (fs.existsSync(filePath)) {
    const content = fs.readFileSync(filePath, 'utf8');
    const hsMatch = content.match(/function Hs\([^)]*\)\{[^}]*\}/);
    if (hsMatch) {
        console.log("Found Hs function:");
        console.log(hsMatch[0]);
    } else {
        console.log("Hs function pattern not found, printing surrounding context of load():");
        const loadIndex = content.indexOf('async load()');
        if (loadIndex !== -1) {
            console.log(content.substring(loadIndex - 500, loadIndex + 500));
        }
    }
} else {
    console.log("File not found:", filePath);
}
