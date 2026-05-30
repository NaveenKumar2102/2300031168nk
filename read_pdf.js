const fs = require('fs');
const pdf = require('pdf-parse');

const pdfPath = "C:\\Users\\Naveen Kumar\\Downloads\\Telegram Desktop\\2024-25 ACCELERATION REGISTRATION GUIDELINES .pdf";

async function run() {
    try {
        const parser = new pdf.PDFParse({ url: pdfPath });
        await parser.load();
        
        const textObj = await parser.getText();
        console.log("textObj type:", typeof textObj);
        console.log("textObj keys:", Object.keys(textObj));
        
        if (textObj.text) {
            console.log("Found text property!");
            console.log(textObj.text.substring(0, 4000));
        } else {
            console.log("textObj structure:", textObj);
        }
        
        await parser.destroy();
    } catch (err) {
        console.error("Error:", err);
    }
}

run();
