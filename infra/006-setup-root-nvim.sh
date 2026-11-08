#!/bin/bash
set -e

# Give root the same Neovim config as the user. Root links to the user's dotfiles clone, so
# one config serves both. Needs 005-setup-dotfiles.sh to have cloned the repo first.
DOTFILES_DIR="$HOME/tools/dotfiles"
ROOT_NVIM="/root/.config/nvim"

echo "=== Symlink Neovim config for root ==="
if [ ! -d "$DOTFILES_DIR/confs/nvim" ]; then
  echo "Missing $DOTFILES_DIR/confs/nvim. Run 005-setup-dotfiles.sh first."
  exit 1
fi

sudo mkdir -p /root/.config
if [ -e "$ROOT_NVIM" ] || [ -L "$ROOT_NVIM" ]; then
  sudo mv "$ROOT_NVIM" "$ROOT_NVIM-bak-$(date +%s)"
fi
sudo ln -s "$DOTFILES_DIR/confs/nvim" "$ROOT_NVIM"

echo "=== Install plugins for root (versions from lazy-lock.json) ==="
sudo -H nvim --headless "+Lazy! restore" "+qa"

echo "Done. Root can run 'sudo -H nvim'."
