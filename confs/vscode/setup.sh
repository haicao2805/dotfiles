#!/bin/bash

# VS Code Vim Configuration Setup Script
# This script creates symlinks to apply your VS Code Vim configuration

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Paths
DOTFILES_DIR="$HOME/Workspaces/save/haicc/dotfiles"
VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
SETTINGS_SRC="$DOTFILES_DIR/confs/vscode/settings.json"
KEYBINDINGS_SRC="$DOTFILES_DIR/confs/vscode/keybindings.json"
SETTINGS_DEST="$VSCODE_CONFIG_DIR/settings.json"
KEYBINDINGS_DEST="$VSCODE_CONFIG_DIR/keybindings.json"

echo -e "${BLUE}=================================${NC}"
echo -e "${BLUE}VS Code Vim Configuration Setup${NC}"
echo -e "${BLUE}=================================${NC}\n"

# Check if VS Code config directory exists
if [ ! -d "$VSCODE_CONFIG_DIR" ]; then
    echo -e "${YELLOW}VS Code config directory not found. Creating it...${NC}"
    mkdir -p "$VSCODE_CONFIG_DIR"
fi

# Backup existing settings if they exist and are not symlinks
backup_file() {
    local file=$1
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up existing file:${NC}"
        echo -e "  $file -> $backup"
        mv "$file" "$backup"
    elif [ -L "$file" ]; then
        echo -e "${YELLOW}Removing existing symlink: $file${NC}"
        rm "$file"
    fi
}

# Create symlink
create_symlink() {
    local src=$1
    local dest=$2
    local name=$3
    
    if [ -f "$src" ]; then
        backup_file "$dest"
        ln -sf "$src" "$dest"
        echo -e "${GREEN}✓ Created symlink for $name${NC}"
        echo -e "  $dest -> $src\n"
    else
        echo -e "${RED}✗ Source file not found: $src${NC}\n"
    fi
}

# Create symlinks
echo -e "${BLUE}Creating symlinks...${NC}\n"
create_symlink "$SETTINGS_SRC" "$SETTINGS_DEST" "settings.json"
create_symlink "$KEYBINDINGS_SRC" "$KEYBINDINGS_DEST" "keybindings.json"

# Check if Vim extension is installed
echo -e "${BLUE}Checking VS Code extensions...${NC}"
if command -v code &> /dev/null; then
    if code --list-extensions | grep -q "vscodevim.vim"; then
        echo -e "${GREEN}✓ Vim extension is already installed${NC}\n"
    else
        echo -e "${YELLOW}⚠ Vim extension is not installed${NC}"
        echo -e "${BLUE}Installing Vim extension...${NC}"
        code --install-extension vscodevim.vim
        echo -e "${GREEN}✓ Vim extension installed${NC}\n"
    fi
else
    echo -e "${YELLOW}⚠ 'code' command not found. Please install VS Code or add it to PATH${NC}\n"
fi

echo -e "${GREEN}=================================${NC}"
echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${GREEN}=================================${NC}\n"

echo -e "${BLUE}Next steps:${NC}"
echo -e "1. Restart VS Code if it's currently running"
echo -e "2. The Vim extension should now use your Neovim-like keybindings"
echo -e "3. Check ${DOTFILES_DIR}/confs/vscode/README.md for detailed key mappings\n"

echo -e "${YELLOW}Note:${NC} If you make changes to the configuration files,"
echo -e "they will automatically be reflected in VS Code (no need to copy files)\n"
