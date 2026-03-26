# SYV — Save Your Video

A clean, interactive CLI wrapper for `yt-dlp`.

Some people say it means "Steal Your Video".

They're wrong.

...probably.

---

## ✨ Features

- Interactive menus with arrow-key navigation (powered by [gum](https://github.com/charmbracelet/gum))
- Clean output — no log spam
- YouTube quality selection: Default, 1080p, MP3
- Support for YouTube, Twitter/X, Instagram, TikTok
- Auto dependency check + Homebrew installer
- Custom download folder per session

---

## 📋 Requirements

- macOS (Homebrew)
- [`yt-dlp`](https://github.com/yt-dlp/yt-dlp)
- [`gum`](https://github.com/charmbracelet/gum)

Missing deps are detected automatically and offered for installation on first run.

---

## 🚀 Install

```bash
git clone https://github.com/yourusername/syv.git
cd syv
chmod +x install.sh
./install.sh
```

Then reload your shell:

```bash
source ~/.zshrc   # or ~/.bashrc
```

And run:

```bash
yt
```

---

## 🗑️ Uninstall

```bash
rm -rf ~/.syv
# Then remove the alias and PATH lines from ~/.zshrc (or ~/.bashrc)
```

---

## 🛠️ Usage

Just type `yt` and follow the prompts:

1. Enter a destination folder (or press Enter to use the current directory)
2. Choose a platform
3. Choose quality (YouTube only)
4. Paste the video URL
5. Done ✅

---

## 📁 Project Structure

```
syv/
├── syv.sh        # Main script
├── install.sh    # Installer
└── README.md
```

---

## 📄 License

MIT