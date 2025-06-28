#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

log "Configurando Git..."

# Check if Git is installed
if ! command -v git &> /dev/null; then
    error "Git não encontrado! Execute install-packages.sh primeiro."
    exit 1
fi

# Check if Git is already configured
if git config --global user.name &> /dev/null && git config --global user.email &> /dev/null; then
    CURRENT_NAME=$(git config --global user.name)
    CURRENT_EMAIL=$(git config --global user.email)
    
    log "Git já está configurado:"
    log "Nome: $CURRENT_NAME"
    log "Email: $CURRENT_EMAIL"
    
    echo -n "Deseja reconfigurar? (y/N): "
    read -r response
    
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        success "Mantendo configuração atual do Git"
        exit 0
    fi
fi

# Get user information
echo -n "Digite seu nome completo: "
read -r GIT_NAME

echo -n "Digite seu email: "
read -r GIT_EMAIL

# Validate inputs
if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
    error "Nome e email são obrigatórios!"
    exit 1
fi

# Configure Git
log "Configurando Git com as informações fornecidas..."

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Additional Git configurations
log "Aplicando configurações adicionais do Git..."

# Set default branch name
git config --global init.defaultBranch main

# Enable color output
git config --global color.ui auto

# Set up pull strategy
git config --global pull.rebase false

# Set up push strategy
git config --global push.default simple

# Enable credential helper for macOS
git config --global credential.helper osxkeychain

# Set up diff and merge tools (if available)
if command -v code &> /dev/null; then
    git config --global core.editor "code --wait"
    git config --global diff.tool vscode
    git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
    git config --global merge.tool vscode
    git config --global mergetool.vscode.cmd 'code --wait $MERGED'
fi

# Set up useful aliases
log "Configurando aliases úteis do Git..."

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.tree "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Configure Git to handle line endings properly
git config --global core.autocrlf input

# Verify configuration
log "Verificando configuração do Git..."

success "Git configurado com sucesso!"
success "Nome: $(git config --global user.name)"
success "Email: $(git config --global user.email)"

# Display all configurations
log "📋 Configurações do Git:"
git config --global --list | grep -E '^(user|core|color|pull|push|credential|alias)' | head -20

log "✨ Configuração do Git concluída!"