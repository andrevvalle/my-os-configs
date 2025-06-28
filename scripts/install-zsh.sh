#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")/config"

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

log "Configurando Zsh e Oh My Zsh..."

# Check if Zsh is default shell
if [[ "$SHELL" != */zsh ]]; then
    log "Configurando Zsh como shell padrão..."
    chsh -s /bin/zsh
    success "Zsh configurado como shell padrão"
else
    success "Zsh já é o shell padrão"
fi

# Install Oh My Zsh if not installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Oh My Zsh instalado!"
else
    success "Oh My Zsh já está instalado"
fi

# Install Dracula theme
log "Instalando tema Dracula..."
if [[ ! -d "$HOME/.oh-my-zsh/themes/dracula" ]]; then
    git clone https://github.com/dracula/zsh.git "$HOME/.oh-my-zsh/themes/dracula"
    success "Tema Dracula instalado!"
else
    success "Tema Dracula já está instalado"
fi

# Install zsh-autosuggestions plugin
log "Instalando plugin zsh-autosuggestions..."
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    success "Plugin zsh-autosuggestions instalado!"
else
    success "Plugin zsh-autosuggestions já está instalado"
fi

# Backup existing .zshrc
if [[ -f "$HOME/.zshrc" ]]; then
    log "Fazendo backup do .zshrc existente..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    success "Backup criado!"
fi

# Load configuration
source "$CONFIG_DIR/zsh-config.sh"

# Create new .zshrc
log "Criando nova configuração .zshrc..."
cat > "$HOME/.zshrc" << EOF
# If you come from bash you might have to change your \$PATH.
# export PATH=\$HOME/bin:/usr/local/bin:\$PATH

# Path to your oh-my-zsh installation.
export ZSH="\$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="$ZSH_THEME"

# Plugins
plugins=($(echo "${ZSH_PLUGINS[@]}" | tr ' ' '\n' | sed 's/^/    /' | tr '\n' ' '))

source \$ZSH/oh-my-zsh.sh

# User configuration
$ZSH_ENV_VARS

# Custom aliases
$ZSH_ALIASES

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
EOF

success "Nova configuração .zshrc criada!"

# Set proper permissions
chmod 644 "$HOME/.zshrc"

log "✨ Configuração do Zsh concluída!"
log "🔄 Execute 'source ~/.zshrc' ou reinicie o terminal para aplicar as mudanças"