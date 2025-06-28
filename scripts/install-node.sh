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

log "Configurando Node.js via NVM..."

# Check if NVM is installed
if [[ ! -d "$HOME/.nvm" ]]; then
    log "Instalando NVM..."
    
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Load NVM into current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    success "NVM instalado!"
else
    success "NVM já está instalado"
    
    # Load NVM into current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Verify NVM installation
if command -v nvm &> /dev/null; then
    success "NVM está funcionando!"
else
    error "Falha na instalação do NVM"
    exit 1
fi

# Install Node.js versions
log "Instalando versões do Node.js..."

# Install LTS version
log "Instalando Node.js LTS..."
nvm install --lts
nvm alias default lts/*

# Install specific versions based on your current setup
log "Instalando Node.js v18.19.1..."
nvm install 18.19.1

log "Instalando Node.js v20.10.0..."
nvm install 20.10.0

log "Instalando Node.js v22.11.0..."
nvm install 22.11.0

# Set Node.js 18.19.1 as default (matching your current setup)
log "Configurando Node.js v18.19.1 como padrão..."
nvm use 18.19.1
nvm alias default 18.19.1

# Verify installations
log "Verificando instalações..."
success "Versões do Node.js instaladas:"
nvm list

# Install global packages
log "Instalando pacotes globais essenciais..."
npm install -g npm@latest
npm install -g yarn
npm install -g typescript
npm install -g ts-node
npm install -g nodemon
npm install -g pm2
npm install -g http-server
npm install -g create-react-app
npm install -g @vue/cli
npm install -g @angular/cli

success "Pacotes globais instalados!"

# Display final status
log "✨ Configuração do Node.js concluída!"
log "🔧 Node.js atual: $(node --version)"
log "🔧 NPM atual: $(npm --version)"
log "🔧 Para trocar versões: nvm use <version>"
log "🔧 Para ver versões disponíveis: nvm list"