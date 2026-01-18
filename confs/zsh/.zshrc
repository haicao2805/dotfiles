# ============================================================================
# OH-MY-ZSH CONFIGURATION
# ============================================================================

# Oh-My-Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="robbyrussell"

# Oh-My-Zsh plugins
plugins=(
  git
  zsh-autosuggestions
)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# General environment
export WORKSPACE="$HOME/Workspaces"
# export LANG=en_US.UTF-8
# export MANPATH="/usr/local/man:$MANPATH"

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Append to PATH (skips if inside tmux to avoid duplicates)
append_path() {
  if [ ! -z $TMUX ]; then
    return
  fi
  export PATH="$PATH:$1"
}

# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# Custom functions path
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Development tools
append_path "/usr/bin/flutter/bin"
append_path "/usr/local/go/bin"
append_path "$ANDROID_HOME/emulator"
append_path "$ANDROID_HOME/platform-tools"

# ============================================================================
# LANGUAGE VERSION MANAGERS
# ============================================================================

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python Version Manager (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# ============================================================================
# PACKAGE MANAGERS
# ============================================================================

# pnpm
export PNPM_HOME="/home/haicao/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/home/haicao/.bun/_bun" ] && source "/home/haicao/.bun/_bun"

# ============================================================================
# ALIASES
# ============================================================================

# Editor
alias nv="nvim ."

# Workspace navigation
alias ws="cd ~/Workspaces/save && tmux"

# ============================================================================
# ADDITIONAL CONFIGURATIONS
# ============================================================================

# Load local environment configurations
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# ============================================================================
# OH-MY-ZSH OPTIONS (Uncomment to enable)
# ============================================================================

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

# Auto-update behavior:
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder
# zstyle ':omz:update' frequency 13
GOOGLE_API_KEY="AIzaSyDL9ARvKlJ2Mp8l2ZetyaNJqxN8BG6FkKs"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
