import { chromium } from "playwright";

(async () => {
  const browser = await chromium.connectOverCDP("http://localhost:9222");
  const context = browser.contexts()[0];
  const pages = context.pages();

  const focused = pages.find(
    async (p) => await p.evaluate("document.hasFocus()"),
  );

  for (const page of pages) {
    if (page !== focused && page.url().startsWith("http")) {
      console.log(`Reloading: ${page.url()}`);
      await page.reload();
    }
  }

  await browser.close();
})();
