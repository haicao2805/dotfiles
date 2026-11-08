# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/home/haicao/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# ============================================================================
# OH-MY-ZSH CONFIGURATION
# ============================================================================

# Oh-My-Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="devglow"

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

# Secrets (API keys, OAuth tokens). Lives outside the repo: chmod 600, never commit.
[ -f "$HOME/.config/claude/tokens.env" ] && source "$HOME/.config/claude/tokens.env"

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

# Kubectk
alias k="kubectl"

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias kbana='KUBECONFIG=~/Documents/haicao-kubeconfig.yaml kubectl'

# Claude accounts. Tokens come from ~/.config/claude/tokens.env; a missing one stops with a hint.
export CLAUDE_BIN="$HOME/.local/bin/claude"
alias claude-haicao='CLAUDE_CODE_OAUTH_TOKEN="${CLAUDE_OAUTH_TOKEN_HAICAO:?Set CLAUDE_OAUTH_TOKEN_HAICAO in ~/.config/claude/tokens.env}" "$CLAUDE_BIN"'
alias claude-phatnt='CLAUDE_CODE_OAUTH_TOKEN="${CLAUDE_OAUTH_TOKEN_PHATNT:?Set CLAUDE_OAUTH_TOKEN_PHATNT in ~/.config/claude/tokens.env}" "$CLAUDE_BIN"'
alias claude-openrouter='CLAUDE_CONFIG_DIR="$HOME/.claude-openrouter" ANTHROPIC_BASE_URL=https://openrouter.ai/api ANTHROPIC_AUTH_TOKEN="${OPENROUTER_API_KEY:?Set OPENROUTER_API_KEY in ~/.config/claude/tokens.env}" ANTHROPIC_API_KEY="" CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1 "$CLAUDE_BIN"'
