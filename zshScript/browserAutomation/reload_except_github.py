import asyncio
from urllib.parse import urlparse
from playwright.async_api import async_playwright

async def reload_except_github():
    async with async_playwright() as p:
        browser = await p.chromium.connect_over_cdp("http://localhost:9222")
        context = browser.contexts[0]
        pages = context.pages

        tasks = []
        for page in pages:
            url = page.url
            hostname = urlparse(url).hostname or ""
            if "github" not in hostname.lower() and url.startswith("http"):
                print(f"Reloading: {await page.title()} ({url})")
                tasks.append(page.reload())

        await asyncio.gather(*tasks)

asyncio.run(reload_except_github())

