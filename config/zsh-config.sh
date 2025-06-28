#!/bin/bash

# Zsh Configuration Variables
ZSH_THEME="dracula/dracula"
ZSH_PLUGINS=(
    "git"
    "zsh-autosuggestions"
)

# Additional aliases to add to .zshrc
ZSH_ALIASES='
# Git aliases
alias gpo="git push origin"
alias gst="git status"
alias gco="git checkout"
alias gpl="git pull"
alias glog="git log --oneline --graph --decorate"

# Development aliases
alias ll="ls -la"
alias la="ls -la"
alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."

# Node.js aliases
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"

# System aliases
alias reload="source ~/.zshrc"
alias zshconfig="code ~/.zshrc"
'

# Environment variables to add
ZSH_ENV_VARS='
# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Homebrew path
export PATH="/opt/homebrew/bin:$PATH"

# Python configuration
export PYTHON=/opt/homebrew/bin/python3

# Go configuration (if using Go)
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Auto-initialize pyenv if available
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Auto-initialize rbenv if available  
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi
'