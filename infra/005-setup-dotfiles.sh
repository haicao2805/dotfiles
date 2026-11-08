#!/bin/bash
set -e

DOTFILES_REPO="https://github.com/phatnt199/dotfiles.git"
DOTFILES_DIR="$HOME/tools/dotfiles"

echo "=== Clone dotfiles ==="
if [ -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles already cloned at $DOTFILES_DIR"
else
  mkdir -p "$HOME/tools"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

echo "=== Symlink ZSH config ==="
rm -rf "$HOME/.zshrc"
ln -s "$DOTFILES_DIR/confs/zsh/.zshrc" "$HOME/.zshrc"

echo "=== Symlink TMUX config ==="
rm -rf "$HOME/.tmux.conf"
ln -s "$DOTFILES_DIR/confs/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "=== Symlink Neovim config ==="
mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/nvim"
ln -s "$DOTFILES_DIR/confs/neovim" "$HOME/.config/nvim"

echo "=== Symlink Lazygit config ==="
mkdir -p "$HOME/.config/lazygit"
rm -f "$HOME/.config/lazygit/config.yml"
ln -s "$DOTFILES_DIR/confs/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

echo "Done. Run 'source ~/.zshrc' to reload."
