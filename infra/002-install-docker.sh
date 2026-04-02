#!/bin/bash
set -e

echo "=== Install Docker ==="
if command -v docker &> /dev/null; then
  echo "Docker is already installed"
  docker --version
else
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sudo sh /tmp/get-docker.sh
  sudo rm -f /tmp/get-docker.sh
  docker --version
fi

echo "=== Install Docker Compose plugin ==="
if docker compose version &> /dev/null; then
  echo "Docker Compose is already installed"
  docker compose version
else
  sudo apt install -y docker-compose-plugin
  docker compose version
fi

echo "=== Add current user to docker group ==="
sudo usermod -aG docker $USER
echo "WARNING: Log out and back in for group changes to take effect."

echo "Done."
