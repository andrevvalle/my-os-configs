#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
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

log "Verificando instalação do Homebrew..."

# Check if already installed
if command -v brew &> /dev/null; then
    success "Homebrew já está instalado!"
    
    log "Atualizando Homebrew..."
    brew update
    
    log "Fazendo upgrade dos pacotes instalados..."
    brew upgrade
    
    success "Homebrew atualizado com sucesso!"
else
    log "Homebrew não encontrado. Instalando..."
    
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    if [[ $(uname -m) == "arm64" ]]; then
        # Apple Silicon Mac
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # Intel Mac
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    success "Homebrew instalado com sucesso!"
fi

# Verify installation
if command -v brew &> /dev/null; then
    BREW_VERSION=$(brew --version | head -n1)
    success "Homebrew está funcionando: $BREW_VERSION"
else
    error "Falha na instalação do Homebrew"
    exit 1
fi

log "✨ Instalação do Homebrew concluída!"