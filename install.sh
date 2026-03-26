#!/bin/bash

set -e

# -----------------------------
# Configuração — ajuste para o seu usuário/repo
# -----------------------------
GITHUB_USER="Saimonsanbr"
GITHUB_REPO="syv"
BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/$BRANCH"

INSTALL_DIR="$HOME/.syv"
BINARY_NAME="syv"

echo "📦 Installing SYV (Save Your Video)..."
echo ""

mkdir -p "$INSTALL_DIR"

# -----------------------------
# Baixa o script principal
# Funciona tanto via curl|bash quanto clonando o repo
# -----------------------------
if [ -f "syv.sh" ]; then
  cp "syv.sh" "$INSTALL_DIR/$BINARY_NAME"
  echo "📁 Copied syv.sh from local repo"
else
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$RAW_BASE/syv.sh" -o "$INSTALL_DIR/$BINARY_NAME"
    echo "⬇️  Downloaded syv.sh from GitHub"
  elif command -v wget >/dev/null 2>&1; then
    wget -q "$RAW_BASE/syv.sh" -O "$INSTALL_DIR/$BINARY_NAME"
    echo "⬇️  Downloaded syv.sh from GitHub"
  else
    echo "❌ Neither curl nor wget found. Cannot download syv.sh."
    exit 1
  fi
fi

chmod +x "$INSTALL_DIR/$BINARY_NAME"

# -----------------------------
# Detecta shell
# -----------------------------
DETECTED_SHELL="$(basename "$SHELL")"

case "$DETECTED_SHELL" in
  zsh)  SHELL_RC="$HOME/.zshrc" ;;
  bash) SHELL_RC="$HOME/.bashrc" ;;
  fish)
    echo ""
    echo "⚠️  Fish shell detected."
    echo "   Add this manually to ~/.config/fish/config.fish:"
    echo ""
    echo "   set -gx PATH \$HOME/.syv \$PATH"
    echo "   alias yt '$INSTALL_DIR/$BINARY_NAME'"
    echo ""
    echo "🚀 Installation complete!"
    echo "👉 Then type: yt"
    exit 0
    ;;
  *)
    SHELL_RC="$HOME/.profile"
    ;;
esac

# -----------------------------
# Adiciona ~/.syv ao PATH
# -----------------------------
if ! grep -qF '.syv' "$SHELL_RC" 2>/dev/null; then
  {
    echo ""
    echo "# SYV — Save Your Video"
    echo "export PATH=\"\$HOME/.syv:\$PATH\""
  } >> "$SHELL_RC"
  echo "✅ Added ~/.syv to PATH in $SHELL_RC"
else
  echo "⚠️  ~/.syv already in PATH in $SHELL_RC, skipping."
fi

# -----------------------------
# Adiciona alias
# -----------------------------
if ! grep -q "alias yt=" "$SHELL_RC" 2>/dev/null; then
  echo "alias yt=\"$INSTALL_DIR/$BINARY_NAME\"" >> "$SHELL_RC"
  echo "✅ Alias 'yt' added to $SHELL_RC"
else
  echo "⚠️  Alias 'yt' already exists in $SHELL_RC"
fi

echo ""
echo "🚀 Installation complete!"
echo ""
echo "👉 Reload your shell:"
echo "   source $SHELL_RC"
echo ""
echo "👉 Then just type:  yt"