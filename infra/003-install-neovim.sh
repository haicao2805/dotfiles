#!/bin/bash
set -e

ARCH=$(uname -m)
echo "=== Install Neovim (arch: $ARCH) ==="

if [ "$ARCH" = "x86_64" ]; then
  APPIMAGE="nvim-linux-x86_64.appimage"
elif [ "$ARCH" = "aarch64" ]; then
  APPIMAGE="nvim-linux-arm64.appimage"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

sudo mkdir -p /opt/config/neovim
cd /opt/config/neovim

echo "Downloading $APPIMAGE..."
sudo curl -LO "https://github.com/neovim/neovim/releases/latest/download/$APPIMAGE"
sudo mv "$APPIMAGE" nvim.appimage
sudo chmod u+x nvim.appimage
sudo ./nvim.appimage --appimage-extract

# Remove old symlink if exists
sudo rm -f /usr/local/bin/nvim
sudo ln -s /opt/config/neovim/squashfs-root/AppRun /usr/local/bin/nvim

echo "Neovim version:"
nvim --version | head -1

echo "Done."
