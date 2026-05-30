const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'node_modules', 'pdf-parse', 'dist', 'pdf-parse', 'cjs', 'index.cjs');
if (fs.existsSync(filePath)) {
    const content = fs.readFileSync(filePath, 'utf8');
    const index = content.indexOf('function Hs(');
    if (index !== -1) {
        console.log("Hs function body:");
        console.log(content.substring(index, index + 1000));
    } else {
        console.log("function Hs not found");
    }
} else {
    console.log("File not found");
}
