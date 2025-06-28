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

log "Instalando pacotes Homebrew..."

# Check if Homebrew is available
if ! command -v brew &> /dev/null; then
    error "Homebrew não encontrado! Execute install-homebrew.sh primeiro."
    exit 1
fi

# Update Homebrew
log "Atualizando Homebrew..."
brew update

# Install packages from file
if [[ -f "$CONFIG_DIR/homebrew-packages.txt" ]]; then
    log "Instalando pacotes do arquivo homebrew-packages.txt..."
    
    while IFS= read -r package || [[ -n "$package" ]]; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^[[:space:]]*# ]] && continue
        
        # Remove leading/trailing whitespace
        package=$(echo "$package" | xargs)
        
        if brew list "$package" &> /dev/null; then
            success "$package já está instalado"
        else
            log "Instalando $package..."
            if brew install "$package"; then
                success "$package instalado com sucesso!"
            else
                error "Falha ao instalar $package"
            fi
        fi
    done < "$CONFIG_DIR/homebrew-packages.txt"
else
    warning "Arquivo homebrew-packages.txt não encontrado"
fi

# Install casks from file
if [[ -f "$CONFIG_DIR/homebrew-casks.txt" ]]; then
    log "Instalando casks do arquivo homebrew-casks.txt..."
    
    while IFS= read -r cask || [[ -n "$cask" ]]; do
        # Skip empty lines and comments
        [[ -z "$cask" || "$cask" =~ ^[[:space:]]*# ]] && continue
        
        # Remove leading/trailing whitespace
        cask=$(echo "$cask" | xargs)
        
        if brew list --cask "$cask" &> /dev/null; then
            success "$cask já está instalado"
        else
            log "Instalando $cask..."
            if brew install --cask "$cask"; then
                success "$cask instalado com sucesso!"
            else
                error "Falha ao instalar $cask"
            fi
        fi
    done < "$CONFIG_DIR/homebrew-casks.txt"
else
    warning "Arquivo homebrew-casks.txt não encontrado"
fi

# Clean up
log "Limpeza do Homebrew..."
brew cleanup

# Show summary
log "📊 Resumo das instalações:"
success "Pacotes instalados: $(brew list --formula | wc -l | xargs)"
success "Casks instalados: $(brew list --cask | wc -l | xargs)"

log "✨ Instalação de pacotes concluída!"