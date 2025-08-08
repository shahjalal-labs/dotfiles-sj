
import asyncio
from playwright.async_api import async_playwright

async def reload_tabs():
    async with async_playwright() as p:
        browser = await p.chromium.connect_over_cdp("http://localhost:9222")
        context = browser.contexts[0]
        pages = context.pages

        focused_page = None
        for page in pages:
            try:
                if await page.evaluate("document.hasFocus()"):
                    focused_page = page
                    break
            except:
                pass

        tasks = []
        for page in pages:
            if page != focused_page and page.url.startswith("http"):
                print(f"Reloading: {await page.title()} ({page.url})")
                tasks.append(page.reload())

        await asyncio.gather(*tasks)

asyncio.run(reload_tabs())

