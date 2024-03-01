#!/bin/sh

# ------------------------------------------------------------------
echo "Backup current config"
mv "$HOME/.zshrc" "$HOME/.zshrc-bak"
mv "$HOME/.tmux.conf" "$HOME/.tmux.conf-bak"
mv "$HOME/.config/alacritty" "$HOME/.config/alacritty-bak"
mv "$HOME/.config/nvim" "$HOME/.config/nvim-bak"

echo "Clean current config"
rm -rf "$HOME/.zshrc"
rm -rf "$HOME/.tmux.conf"
rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/nvim"

echo "Successfully cleaning up!"
