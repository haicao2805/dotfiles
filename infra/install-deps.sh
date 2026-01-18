#!/bin/bash
set -e  # Exit on any error

echo 'Update server...'
sudo apt update

echo 'Upgrade packages...'
sudo apt -y upgrade

echo 'Install dependencies...'
sudo apt install -y build-essential ca-certificates gnupg
sudo apt install -y zsh git wget htop curl nginx
sudo apt install -y wireguard resolvconf

echo "================================================================================"
echo 'Install Docker...'
if command -v docker &> /dev/null; then
  echo "Docker is already installed"
  docker --version
  echo ""
  read -p "Do you want to uninstall Docker? (y/n): " choice
  if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "Uninstalling Docker..."
    # https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine
    sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
    sudo rm -f /etc/apt/sources.list.d/docker.list
    sudo rm -f /etc/apt/keyrings/docker.asc
    echo "Docker uninstalled successfully."
  else
    echo "Skipping Docker uninstallation."
  fi
fi

if ! command -v docker &> /dev/null; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sudo sh /tmp/get-docker.sh
  sudo rm -f /tmp/get-docker.sh
  docker --version
  echo "Adding current user to docker group..."
  sudo usermod -aG docker $USER
  echo "⚠ You need to log out and log back in for the group changes to take effect."
fi

echo "================================================================================"
echo 'Install Docker Compose...'
if docker compose version &> /dev/null; then
  echo "Docker Compose is already installed"
  docker compose version
else
  echo "Installing Docker Compose plugin..."
  if sudo apt install -y docker-compose-plugin; then
    echo "Docker Compose installed successfully."
    docker compose version
  else
    echo "Failed to install Docker Compose plugin."
    exit 1
  fi
fi

echo "================================================================================"
echo 'Install Neovim...'
sudo mkdir -p /opt/config/neovim
cd /opt/config/neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage
mv nvim-linux-arm64.appimage nvim.appimage
sudo chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo ln -s /opt/config/neovim/squashfs-root/AppRun /usr/local/bin/nvim
nvim -v
