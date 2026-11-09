#!/bin/bash
# Update Neovim to the latest stable AppImage release.
# Installs into /opt/config/neovim/squashfs-root and points /usr/local/bin/nvim at it.
# The previous version is kept in /opt/config/neovim/squashfs-prev (one generation only).
# Run with: bash infra/update-neovim.sh
set -euo pipefail

BASE_DIR=/opt/config/neovim
BIN_LINK=/usr/local/bin/nvim

case "$(uname -m)" in
  x86_64) APPIMAGE="nvim-linux-x86_64.appimage" ;;
  aarch64) APPIMAGE="nvim-linux-arm64.appimage" ;;
  *)
    echo "Unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

URL="https://github.com/neovim/neovim/releases/latest/download/$APPIMAGE"
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

echo "=== Current version ==="
nvim --version 2>/dev/null | head -1 || echo "nvim not installed"

echo "=== Download $APPIMAGE ==="
curl -fL -o "$WORK/nvim.appimage" "$URL"
chmod +x "$WORK/nvim.appimage"

echo "=== Extract ==="
(cd "$WORK" && ./nvim.appimage --appimage-extract > /dev/null)
"$WORK/squashfs-root/AppRun" --version | head -1

echo "=== Install into $BASE_DIR ==="
sudo mkdir -p "$BASE_DIR"
sudo rm -rf "$BASE_DIR/squashfs-prev"
if [ -d "$BASE_DIR/squashfs-root" ]; then
  sudo mv "$BASE_DIR/squashfs-root" "$BASE_DIR/squashfs-prev"
fi
sudo mv "$WORK/squashfs-root" "$BASE_DIR/squashfs-root"
sudo ln -sfn "$BASE_DIR/squashfs-root/AppRun" "$BIN_LINK"

echo "=== New version ==="
nvim --version | head -1

echo "Done. Previous version kept at $BASE_DIR/squashfs-prev."
echo "Next: open nvim and run :Lazy restore so plugins match lazy-lock.json."
