#!/bin/bash
set -e

echo "=== System Update & Upgrade ==="
sudo apt update -y
sudo apt upgrade -y

echo "=== Install essential packages ==="
sudo apt install -y build-essential ca-certificates gnupg
sudo apt install -y zip unzip
sudo apt install -y zsh git wget htop curl
sudo apt install -y ripgrep fzf tmux

echo "Done."
