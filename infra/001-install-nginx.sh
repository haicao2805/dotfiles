#!/bin/bash
set -e

echo "=== Install Nginx & Certbot ==="
sudo apt install -y nginx certbot python3-certbot-nginx

echo "Nginx version:"
nginx -v

echo "Done."
