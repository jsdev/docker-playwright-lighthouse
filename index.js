const fs = require('fs');
const { execSync } = require('child_process');
const { chromium } = require('playwright');

(async () => {
  const urlsFile = 'urls.txt';
  const urls = fs.readFileSync(urlsFile, 'utf-8').split('\n').filter(Boolean);

  for (const url of urls) {
    console.log(`Processing ${url}`);

    // Launch a Playwright browser.
    const browser = await chromium.launch();
    const page = await browser.newPage();
    
    // Navigate to the URL.
    await page.goto(url, { waitUntil: 'networkidle' });
    
    // Generate Lighthouse report using execSync to run lighthouse command.
    const reportPath = `./reports/${url.replace(/https?:\/\//, '').replace(/\//g, '_')}.html`;
    console.log(`Generating Lighthouse report for ${url} at ${reportPath}`);
    
    try {
      execSync(`lighthouse ${url} --output html --output-path ${reportPath}`, { stdio: 'inherit' });
    } catch (error) {
      console.error(`Error generating report for ${url}: ${error.message}`);
    }
    
    await browser.close();
  }
})();
