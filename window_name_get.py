import pygetwindow as gw

windows = gw.getAllTitles()
for i, title in enumerate(windows):
    if title.strip():  # Ignore empty titles
        print(f"{i + 1}. {title}")
