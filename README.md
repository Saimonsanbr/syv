<div align="center">

<img src="assets/logo.png" width="120" alt="SYV logo" />

# SYV — Save Your Video

**A clean, interactive CLI for downloading videos — one command, no fuss**

[![License](https://img.shields.io/badge/license-MIT-black?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-black?style=flat-square)](#)
[![Powered by yt-dlp](https://img.shields.io/badge/powered_by-yt--dlp-black?style=flat-square)](https://github.com/yt-dlp/yt-dlp)

</div>

---

## What is this?

SYV is a terminal app that wraps `yt-dlp` with a clean, interactive interface.

Paste a URL, pick your quality, get a file.

No browser extensions. No GUIs to install. Just a shell script with arrow-key navigation powered by [gum](https://github.com/charmbracelet/gum).

---

## Supported platforms

| Platform | Support |
|---|---|
| YouTube | ✅ Default, 1080p, MP3 |
| Twitter / X | ✅ |
| Instagram | ✅ |
| TikTok | ✅ |

> **Windows** — not yet supported. Coming soon.

---

## Requirements

- macOS or Linux
- [Homebrew](https://brew.sh) (macOS) or your distro's package manager (Linux)
- `yt-dlp` and `gum` — installed automatically on first run (macOS)

**Linux users** — install deps manually before running:

```bash
# Debian / Ubuntu
sudo apt install yt-dlp
brew install gum   # or: go install github.com/charmbracelet/gum@latest

# Arch
sudo pacman -S yt-dlp
brew install gum

# Fedora
sudo dnf install yt-dlp
brew install gum
```

---

## Install

**One-liner:**

```bash
curl -fsSL https://raw.githubusercontent.com/Saimosanbr/syv/main/install.sh | bash
```

**Or clone the repo:**

```bash
git clone https://github.com/Saimosanbr/syv.git
cd syv
chmod +x install.sh
./install.sh
```

Then reload your shell:

```bash
source ~/.zshrc   # or ~/.bashrc
```

---

## Usage

```bash
yt
```

1. Enter a destination folder — or press Enter to use the current directory
2. Choose a platform
3. Choose quality (YouTube only: Default / 1080p / MP3)
4. Paste the video URL and hit Enter
5. Done ✅

After each download, you can:

- **Download another** — keeps the same platform and quality, just paste a new URL
- **Change platform / quality** — goes back to the beginning
- **Exit**

---

## Uninstall

```bash
rm -rf ~/.syv
```

Then remove these lines from your `~/.zshrc` (or `~/.bashrc`):

```bash
# SYV — Save Your Video
export PATH="$HOME/.syv:$PATH"
alias yt="$HOME/.syv/syv"
```

---

## Project structure

```
syv/
├── syv.sh        # Main script
├── install.sh    # Installer
└── README.md
```

---

## Powered by

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) — the actual downloader
- [gum](https://github.com/charmbracelet/gum) — interactive terminal UI

---

## License

MIT