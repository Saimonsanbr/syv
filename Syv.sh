#!/bin/bash

# -----------------------------
# 🔍 Verificar dependências
# -----------------------------
check_dep() {
  command -v "$1" >/dev/null 2>&1
}

install_deps() {
  missing=()
  ! check_dep yt-dlp && missing+=("yt-dlp")
  ! check_dep gum    && missing+=("gum")

  if [ ${#missing[@]} -gt 0 ]; then
    echo "📦 Missing dependencies: ${missing[*]}"
    read -rp "Install them now? (y/n): " choice
    if [ "$choice" = "y" ]; then
      if check_dep brew; then
        brew install "${missing[@]}"
      else
        echo "❌ Homebrew not found. Install it first: https://brew.sh"
        exit 1
      fi
    else
      echo "❌ Cannot continue without dependencies."
      exit 1
    fi
  fi
}

install_deps

# -----------------------------
# 📁 Pasta de destino
# -----------------------------
clear
echo ""
read -rp "📁 Enter destination folder (leave empty = current): " folder
[ -z "$folder" ] && folder="."

if ! mkdir -p "$folder" 2>/dev/null; then
  echo "❌ Could not create folder: $folder"
  exit 1
fi

# -----------------------------
# Função: escolher plataforma + qualidade
# -----------------------------
choose_config() {
  clear

  gum style \
    --border double \
    --padding "1 2" \
    --margin "1 2" \
    --align center \
    --foreground 212 \
    --width $(( $(tput cols) - 8 )) \
    "SYV — Save Your Video"

  platform=$(gum choose \
    "YouTube" \
    "Twitter / X" \
    "Instagram" \
    "TikTok" \
    "Exit")

  [ -z "$platform" ] || [ "$platform" = "Exit" ] && exit 0

  quality="Default"
  if [ "$platform" = "YouTube" ]; then
    quality=$(gum choose \
      "Default" \
      "1080p" \
      "MP3")
    [ -z "$quality" ] && exit 0
  fi
}

# -----------------------------
# 🔁 Loop principal
# -----------------------------

# Escolhe config na primeira vez
choose_config

while true; do
  clear

  # Mostra config atual no topo
  if [ "$platform" = "YouTube" ]; then
    config_label="$platform · $quality"
  else
    config_label="$platform"
  fi

  gum style \
    --border double \
    --padding "1 2" \
    --margin "1 2" \
    --align center \
    --foreground 212 \
    --width $(( $(tput cols) - 8 )) \
    "SYV — Save Your Video"

  gum style \
    --align center \
    --foreground 240 \
    --width $(( $(tput cols) - 8 )) \
    "Platform: $config_label"

  echo ""
  read -rp "🔗 Paste video URL: " url
  [ -z "$url" ] && continue

  clear

  # 🎬 Busca título
  title=$(gum spin \
    --spinner dot \
    --title "Fetching video info..." \
    -- yt-dlp --get-title "$url" 2>/dev/null)

  [ -n "$title" ] && gum style --foreground 212 "🎬  $title"
  echo ""

  gum style \
    --border rounded \
    --padding "0 2" \
    --width $(( $(tput cols) - 8 )) \
    "⬇️  Downloading to: $folder"

  echo ""

  # -----------------------------
  # 🎬 Monta comando yt-dlp
  # -----------------------------
  cmd=(yt-dlp --progress --quiet --no-warnings --no-playlist -P "$folder")

  if [ "$platform" = "YouTube" ]; then
    case "$quality" in
      "1080p")
        cmd+=(-f "bestvideo[height<=1080]+bestaudio/best" --merge-output-format mp4)
        ;;
      "MP3")
        cmd+=(-x --audio-format mp3)
        ;;
    esac
  fi

  cmd+=("$url")

  # -----------------------------
  # ▶️ Executa com spinner
  # -----------------------------
  gum spin \
    --spinner line \
    --title "Downloading..." \
    -- "${cmd[@]}"

  if [ $? -eq 0 ]; then
    gum style --foreground 2 "✅  Done! Saved to: $folder"
  else
    gum style --foreground 1 "❌  Download failed. Check the URL and try again."
  fi

  echo ""

  # -----------------------------
  # O que fazer agora?
  # -----------------------------
  next=$(gum choose \
    "⬇️  Download another" \
    "⚙️  Change platform / quality" \
    "🚪 Exit")

  case "$next" in
    "⬇️  Download another")
      continue
      ;;
    "⚙️  Change platform / quality")
      choose_config
      ;;
    *)
      break
      ;;
  esac

done

clear
gum style \
  --align center \
  --foreground 212 \
  --width $(( $(tput cols) - 8 )) \
  "👋  Bye!"
echo ""