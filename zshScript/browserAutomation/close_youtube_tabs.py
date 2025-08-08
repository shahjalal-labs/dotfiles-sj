import asyncio
from urllib.parse import urlparse
from playwright.async_api import async_playwright

async def close_youtube_tabs():
    async with async_playwright() as p:
        browser = await p.chromium.connect_over_cdp("http://localhost:9222")
        context = browser.contexts[0]
        pages = context.pages

        for page in pages:
            url = page.url
            hostname = urlparse(url).hostname or ""
            if "youtube.com" in hostname.lower():
                print(f"Closing YouTube tab: {await page.title()} ({url})")
                await page.close()

asyncio.run(close_youtube_tabs())




