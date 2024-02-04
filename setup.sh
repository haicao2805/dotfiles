#!/bin/sh

# ------------------------------------------------------------------
BASE_FOLDER=$(pwd)
echo "Base folder: $BASE_FOLDER"

# ------------------------------------------------------------------
echo "Configuring NEOVIM..."
is_neovim_available=$(command -v nvim > /dev/null)
if ! $is_neovim_available; then
  echo "NEOVIM is not installed | Required version >= 0.9"
  exit 1
else
  echo "NEOVIM is installed | Start configuring..."
  ln -s "$BASE_FOLDER/confs/nvim" "$HOME/.config/nvim"
fi
