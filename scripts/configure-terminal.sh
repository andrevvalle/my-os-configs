#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")/templates"

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

log "Configurando personalização do terminal..."

# Create templates directory if it doesn't exist
mkdir -p "$TEMPLATES_DIR"

# Create iTerm2 color scheme (Dracula)
log "Criando esquema de cores Dracula para iTerm2..."

cat > "$TEMPLATES_DIR/Dracula.itermcolors" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Ansi 0 Color</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>0.0</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>0.0</real>
		<key>Red Component</key>
		<real>0.0</real>
	</dict>
	<key>Ansi 1 Color</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>0.3333333432674408</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>0.3333333432674408</real>
		<key>Red Component</key>
		<real>1</real>
	</dict>
	<key>Background Color</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>0.15977837145328522</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>0.12215272337198257</real>
		<key>Red Component</key>
		<real>0.11765811592340469</real>
	</dict>
	<key>Foreground Color</key>
	<dict>
		<key>Alpha Component</key>
		<real>1</real>
		<key>Blue Component</key>
		<real>0.97647058823529409</real>
		<key>Color Space</key>
		<string>sRGB</string>
		<key>Green Component</key>
		<real>0.97647058823529409</real>
		<key>Red Component</key>
		<real>0.97647058823529409</real>
	</dict>
</dict>
</plist>
EOF

success "Esquema de cores Dracula criado!"

# Create custom .zshrc.local for additional customizations
log "Criando arquivo de customizações locais..."

cat > "$HOME/.zshrc.local" << 'EOF'
# Local customizations - Edit this file for personal preferences

# Custom functions
weather() {
    curl -s "wttr.in/$1?format=3"
}

# Quick directory navigation
projects() {
    cd ~/Projects
}

# Development helpers
serve() {
    if [ -f "package.json" ]; then
        npm start
    elif [ -f "yarn.lock" ]; then
        yarn start
    else
        python -m http.server 8000
    fi
}

# Git helpers
gac() {
    git add . && git commit -m "$1"
}

gacp() {
    git add . && git commit -m "$1" && git push
}

# Docker helpers
dps() {
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# Network helpers
myip() {
    curl -s ifconfig.me
}

localip() {
    ipconfig getifaddr en0
}

# System info
sysinfo() {
    echo "🖥️  System Information"
    echo "===================="
    echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
    echo "Architecture: $(uname -m)"
    echo "Shell: $SHELL"
    echo "Node.js: $(node --version 2>/dev/null || echo 'Not installed')"
    echo "Python: $(python3 --version 2>/dev/null || echo 'Not installed')"
    echo "Git: $(git --version 2>/dev/null || echo 'Not installed')"
    echo "Docker: $(docker --version 2>/dev/null || echo 'Not installed')"
}

# Welcome message (uncomment to enable)
# echo "🚀 Welcome back! Type 'sysinfo' for system information."
EOF

success "Arquivo de customizações locais criado!"

# Create development environment checker
log "Criando verificador de ambiente..."

cat > "$HOME/.local/bin/check-env" << 'EOF'
#!/bin/bash

echo "🔍 Checking Development Environment"
echo "=================================="

# Check essential tools
tools=(
    "git:Git"
    "node:Node.js" 
    "npm:NPM"
    "yarn:Yarn"
    "docker:Docker"
    "brew:Homebrew"
    "code:VS Code"
)

for tool_pair in "${tools[@]}"; do
    tool=${tool_pair%%:*}
    name=${tool_pair##*:}
    
    if command -v "$tool" &> /dev/null; then
        version=$($tool --version 2>/dev/null | head -n1)
        echo "✅ $name: $version"
    else
        echo "❌ $name: Not installed"
    fi
done

echo ""
echo "🗂️  Key Directories:"
[[ -d "$HOME/.oh-my-zsh" ]] && echo "✅ Oh My Zsh" || echo "❌ Oh My Zsh"
[[ -d "$HOME/.nvm" ]] && echo "✅ NVM" || echo "❌ NVM"
[[ -d "$HOME/Projects" ]] && echo "✅ Projects folder" || echo "❌ Projects folder"

echo ""
echo "🔧 Shell Configuration:"
echo "Current shell: $SHELL"
echo "Oh My Zsh theme: $(grep '^ZSH_THEME=' ~/.zshrc 2>/dev/null | cut -d'"' -f2)"
echo "Active plugins: $(grep '^plugins=' ~/.zshrc 2>/dev/null)"
EOF

# Make the checker executable
mkdir -p "$HOME/.local/bin"
chmod +x "$HOME/.local/bin/check-env"

# Add .local/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc.local"
fi

success "Verificador de ambiente criado!"

# Create a useful development aliases file
log "Criando aliases de desenvolvimento..."

cat >> "$HOME/.zshrc.local" << 'EOF'

# Development project templates
create-react() {
    npx create-react-app "$1" --template typescript
    cd "$1"
}

create-next() {
    npx create-next-app@latest "$1" --typescript --tailwind --eslint --app
    cd "$1"
}

create-node() {
    mkdir "$1"
    cd "$1"
    npm init -y
    npm install --save-dev typescript @types/node ts-node nodemon
    echo '{"scripts":{"dev":"nodemon --exec ts-node src/index.ts","build":"tsc","start":"node dist/index.js"}}' > package.json.tmp
    jq -s '.[0] * .[1]' package.json package.json.tmp > package.json.new
    mv package.json.new package.json
    rm package.json.tmp
    mkdir src
    echo 'console.log("Hello World!");' > src/index.ts
}
EOF

success "Aliases de desenvolvimento adicionados!"

# Instructions for manual setup
log "📋 Instruções para configuração manual do iTerm2:"
echo ""
echo "1. Abra o iTerm2"
echo "2. Va em iTerm2 > Preferences > Profiles > Colors"
echo "3. Clique em 'Color Presets' > Import"
echo "4. Selecione o arquivo: $TEMPLATES_DIR/Dracula.itermcolors"
echo "5. Aplique o preset 'Dracula'"
echo ""

log "✨ Configuração do terminal concluída!"
log "🔄 Execute 'source ~/.zshrc' para aplicar as mudanças"
log "🔍 Execute 'check-env' para verificar seu ambiente"