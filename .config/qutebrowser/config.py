config.load_autoconfig()

# force X11 (fixes onshape color issues)
c.qt.force_platform = 'xcb'

# stop being blocked by google
config.set("content.headers.user_agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36", "google.com")
config.set("content.blocking.enabled", False, "google.com")
