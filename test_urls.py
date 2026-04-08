import urllib.request

# Test each URL and find broken ones
headers = {"User-Agent": "Mozilla/5.0"}

broken_skus = {
    "CLO-005": "https://images.unsplash.com/photo-1620799139507-2a76f79a2f4d?w=500&q=80&fm=jpg",
    "APP-007": "https://images.unsplash.com/photo-1513506003901-1e6a35d44e07?w=500&q=80&fm=jpg",
    "APP-009": "https://images.unsplash.com/photo-1600147131759-880e94a6185f?w=500&q=80&fm=jpg",
    "SPT-002": "https://images.unsplash.com/photo-1540747913346-19212a4cf528?w=500&q=80&fm=jpg",
    "SPT-003": "https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=500&q=80&fm=jpg",
    "ELC-005": "https://images.unsplash.com/photo-1601944179066-29786cb9d32a?w=500&q=80&fm=jpg",
}

for sku, url in broken_skus.items():
    try:
        req = urllib.request.Request(url, headers=headers)
        r = urllib.request.urlopen(req, timeout=5)
        print(f"OK: {sku}")
    except Exception as e:
        print(f"BROKEN: {sku} - {e}")
