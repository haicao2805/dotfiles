#!/bin/bash
set -e

echo "=== Set Zsh as default shell ==="
sudo usermod -s /usr/bin/zsh $USER

echo "=== Install Oh My Zsh ==="
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is already installed"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "=== Install devglow zsh theme ==="
curl -fsSL https://raw.githubusercontent.com/phatnt199/devglow/main/lua/zsh/devglow.zsh-theme \
  -o "$HOME/.oh-my-zsh/custom/themes/devglow.zsh-theme"

echo "Done. Log out and back in to use zsh."
