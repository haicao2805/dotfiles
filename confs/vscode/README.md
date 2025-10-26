# VS Code Vim Configuration

This configuration matches your Neovim setup for a consistent experience across editors.

## Installation

### 1. Install the Vim Extension

Install the official VS Code Vim extension:

- Open VS Code
- Press `Ctrl+Shift+X` to open Extensions
- Search for "Vim" (by vscodevim)
- Install the extension

### 2. Apply Configuration

#### Option A: Symlink (Recommended)

Create symlinks to use these configurations:

```bash
# For settings.json
ln -sf ~/Workspaces/save/haicc/dotfiles/confs/vscode/settings.json ~/.config/Code/User/settings.json

# For keybindings.json
ln -sf ~/Workspaces/save/haicc/dotfiles/confs/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

#### Option B: Manual Copy

Copy the contents of these files to your VS Code settings:

- Open VS Code
- Press `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)"
- Merge the contents of `settings.json`
- Press `Ctrl+Shift+P` → "Preferences: Open Keyboard Shortcuts (JSON)"
- Merge the contents of `keybindings.json`

## Key Mappings

### General

| Key          | Action           | Notes                       |
| ------------ | ---------------- | --------------------------- |
| `<Space>`    | Leader key       | Same as your Neovim         |
| `<C-s>`      | Save all files   |                             |
| `<S-u>`      | Redo             | Matches your Neovim `<S-u>` |
| `ff`         | Format document  | Same as your Neovim         |
| `<leader>io` | Organize imports |                             |

### Moving Lines

| Key     | Action         | Mode                   |
| ------- | -------------- | ---------------------- |
| `<A-j>` | Move line down | Normal, Insert, Visual |
| `<A-k>` | Move line up   | Normal, Insert, Visual |

### File Explorer (NvimTree equivalent)

| Key          | Action                         |
| ------------ | ------------------------------ |
| `<leader>ee` | Toggle explorer                |
| `<leader>ef` | Reveal active file in explorer |

### Fuzzy Finding (Telescope equivalent)

| Key           | Action                |
| ------------- | --------------------- |
| `<C-p>`       | Quick open files      |
| `<leader>fw`  | Search in workspace   |
| `<C-f>`       | Find in current file  |
| `<leader>gf`  | Git files             |
| `<leader>gc`  | Git commits           |
| `<leader>gst` | Git status (SCM view) |
| `<leader>gbr` | Git branches          |

### LSP/IDE Features

| Key          | Action                    |
| ------------ | ------------------------- |
| `gD`         | Go to declaration         |
| `gd`         | Go to definition          |
| `gR`         | Show references           |
| `gi`         | Go to implementation      |
| `gt`         | Go to type definition     |
| `gh`         | Show hover                |
| `<leader>D`  | Show diagnostics/problems |
| `<leader>ca` | Code actions              |
| `<leader>rn` | Rename symbol             |
| `<leader>er` | Show diagnostics for line |

### Visual Mode

| Key          | Action                    |
| ------------ | ------------------------- |
| `<C-c>`      | Copy to system clipboard  |
| `<A-j>`      | Move selection down       |
| `<A-k>`      | Move selection up         |
| `<leader>ca` | Code actions on selection |

### Split Navigation

| Key     | Action         |
| ------- | -------------- |
| `<C-h>` | Navigate left  |
| `<C-l>` | Navigate right |
| `<C-k>` | Navigate up    |
| `<C-j>` | Navigate down  |

## Editor Settings

The configuration matches your Neovim settings:

- **Relative line numbers** - `relativenumber` is enabled
- **Tab size**: 2 spaces (expandtab)
- **Smart indent** enabled
- **Smart case search** - case-insensitive unless capital letters used
- **Cursor surrounding lines**: 8 (scrolloff)
- **Word wrap**: off
- **System clipboard** integration

## Recommended Extensions

For the best experience, consider installing:

- **Vim** (vscodevim.vim) - Required
- **GitLens** - Enhanced git features
- **Prettier** - Code formatting
- **ESLint** - JavaScript/TypeScript linting
- **Error Lens** - Inline error display

## Tips

1. **Escape Key**: Use `jj` or `jk` as escape alternative (add to settings if needed)
2. **Relative Numbers**: Already enabled to match your Neovim setup
3. **Leader Key**: Set to `<Space>` just like your Neovim
4. **Clipboard**: Automatically syncs with system clipboard

## Differences from Neovim

Some features work differently in VS Code:

- File tree uses VS Code's native explorer instead of NvimTree
- Fuzzy finding uses VS Code's Quick Open instead of Telescope
- LSP features use VS Code's native language services
- Git features use VS Code's SCM and GitLens

## Troubleshooting

If keybindings don't work:

1. Check if Vim extension is enabled
2. Reload VS Code: `Ctrl+Shift+P` → "Developer: Reload Window"
3. Check for conflicting keybindings: `Ctrl+K Ctrl+S`
4. Ensure you're in the correct Vim mode

## Customization

Edit these files to customize further:

- `settings.json` - General settings and Vim configuration
- `keybindings.json` - Additional VS Code keybindings
