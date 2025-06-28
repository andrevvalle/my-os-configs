#!/bin/bash

# Mac Setup - Automated Development Environment Setup
# Author: Auto-generated based on environment analysis
# Description: Complete setup script for macOS development environment

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

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

banner() {
    echo -e "${PURPLE}"
    echo "██╗   ██╗ █████╗  ██████╗    ███████╗███████╗████████╗██╗   ██╗██████╗ "
    echo "██║   ██║██╔══██╗██╔════╝    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
    echo "██║   ██║███████║██║         ███████╗█████╗     ██║   ██║   ██║██████╔╝"
    echo "██║   ██║██╔══██║██║         ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
    echo "╚██████╔╝██║  ██║╚██████╗    ███████║███████╗   ██║   ╚██████╔╝██║     "
    echo " ╚═════╝ ╚═╝  ╚═╝ ╚═════╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     "
    echo -e "${NC}"
    echo -e "${CYAN}🚀 Automated macOS Development Environment Setup${NC}"
    echo -e "${CYAN}📝 Based on your current environment configuration${NC}"
    echo ""
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        error "Este script foi projetado para macOS apenas!"
        exit 1
    fi
}

# Check system requirements
check_requirements() {
    log "Verificando pré-requisitos..."
    
    # Check for Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null; then
        warning "Xcode Command Line Tools não encontradas"
        log "Instalando Xcode Command Line Tools..."
        xcode-select --install
        
        echo "⏳ Aguarde a instalação das Xcode Command Line Tools e execute o script novamente"
        exit 1
    fi
    
    success "Xcode Command Line Tools encontradas"
    
    # Check for internet connection
    if ! ping -c 1 google.com &> /dev/null; then
        error "Conexão com internet é necessária!"
        exit 1
    fi
    
    success "Conexão com internet verificada"
}

# Make scripts executable
make_scripts_executable() {
    log "Tornando scripts executáveis..."
    
    find "$SCRIPTS_DIR" -name "*.sh" -exec chmod +x {} \;
    
    success "Scripts configurados como executáveis"
}

# Show setup options
show_menu() {
    echo -e "${CYAN}Escolha o tipo de instalação:${NC}"
    echo ""
    echo "1. 🚀 Instalação Completa (Recomendado)"
    echo "   - Homebrew + Pacotes"
    echo "   - Zsh + Oh My Zsh + Tema Dracula"
    echo "   - Node.js + NVM"
    echo "   - Configuração do Git"
    echo "   - Personalização do Terminal"
    echo ""
    echo "2. 🔧 Instalação Customizada"
    echo "   - Escolher componentes individuais"
    echo ""
    echo "3. 📊 Verificar Ambiente Atual"
    echo "   - Mostrar o que já está instalado"
    echo ""
    echo "4. ❌ Sair"
    echo ""
    echo -n "Escolha uma opção (1-4): "
}

# Show current environment
show_current_environment() {
    log "🔍 Analisando ambiente atual..."
    echo ""
    
    # Check Homebrew
    if command -v brew &> /dev/null; then
        success "Homebrew: $(brew --version | head -n1)"
    else
        warning "Homebrew: Não instalado"
    fi
    
    # Check Shell
    if [[ "$SHELL" == */zsh ]]; then
        success "Shell: Zsh ($(zsh --version))"
    else
        warning "Shell: $SHELL (Zsh recomendado)"
    fi
    
    # Check Oh My Zsh
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        success "Oh My Zsh: Instalado"
    else
        warning "Oh My Zsh: Não instalado"
    fi
    
    # Check Node.js
    if command -v node &> /dev/null; then
        success "Node.js: $(node --version)"
    else
        warning "Node.js: Não instalado"
    fi
    
    # Check NVM
    if [[ -d "$HOME/.nvm" ]]; then
        success "NVM: Instalado"
    else
        warning "NVM: Não instalado"
    fi
    
    # Check Git
    if command -v git &> /dev/null; then
        success "Git: $(git --version)"
        if git config --global user.name &> /dev/null; then
            success "Git configurado para: $(git config --global user.name)"
        else
            warning "Git: Não configurado"
        fi
    else
        warning "Git: Não instalado"
    fi
    
    echo ""
}

# Custom installation menu
custom_installation() {
    echo -e "${CYAN}Instalação Customizada - Escolha os componentes:${NC}"
    echo ""
    
    components=()
    
    echo "Selecione os componentes para instalar (digite os números separados por espaço):"
    echo "1. Homebrew"
    echo "2. Pacotes Homebrew"
    echo "3. Zsh + Oh My Zsh"
    echo "4. Node.js + NVM"
    echo "5. Configuração do Git"
    echo "6. Personalização do Terminal"
    echo ""
    echo -n "Componentes (ex: 1 3 4): "
    read -r selected_components
    
    for component in $selected_components; do
        case $component in
            1) components+=("homebrew") ;;
            2) components+=("packages") ;;
            3) components+=("zsh") ;;
            4) components+=("node") ;;
            5) components+=("git") ;;
            6) components+=("terminal") ;;
            *) warning "Componente inválido: $component" ;;
        esac
    done
    
    if [[ ${#components[@]} -eq 0 ]]; then
        warning "Nenhum componente selecionado!"
        return 1
    fi
    
    echo -e "${CYAN}Componentes selecionados: ${components[*]}${NC}"
    echo -n "Confirmar instalação? (Y/n): "
    read -r confirm
    
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        log "Instalação cancelada"
        return 1
    fi
    
    run_selected_components "${components[@]}"
}

# Run selected components
run_selected_components() {
    local components=("$@")
    
    for component in "${components[@]}"; do
        case $component in
            "homebrew")
                run_step "Homebrew" "$SCRIPTS_DIR/install-homebrew.sh"
                ;;
            "packages")
                run_step "Pacotes Homebrew" "$SCRIPTS_DIR/install-packages.sh"
                ;;
            "zsh")
                run_step "Zsh + Oh My Zsh" "$SCRIPTS_DIR/install-zsh.sh"
                ;;
            "node")
                run_step "Node.js + NVM" "$SCRIPTS_DIR/install-node.sh"
                ;;
            "git")
                run_step "Configuração do Git" "$SCRIPTS_DIR/configure-git.sh"
                ;;
            "terminal")
                run_step "Personalização do Terminal" "$SCRIPTS_DIR/configure-terminal.sh"
                ;;
        esac
    done
}

# Run a setup step
run_step() {
    local step_name="$1"
    local script_path="$2"
    
    echo ""
    log "🔧 Executando: $step_name"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [[ -f "$script_path" ]]; then
        if bash "$script_path"; then
            success "✨ $step_name concluído com sucesso!"
        else
            error "❌ Falha em: $step_name"
            
            echo -n "Continuar mesmo assim? (y/N): "
            read -r continue_response
            
            if [[ ! "$continue_response" =~ ^[Yy]$ ]]; then
                error "Instalação interrompida"
                exit 1
            fi
        fi
    else
        error "Script não encontrado: $script_path"
        exit 1
    fi
}

# Complete installation
complete_installation() {
    log "🚀 Iniciando instalação completa..."
    
    # Run all components in order
    run_step "Homebrew" "$SCRIPTS_DIR/install-homebrew.sh"
    run_step "Pacotes Homebrew" "$SCRIPTS_DIR/install-packages.sh"
    run_step "Zsh + Oh My Zsh" "$SCRIPTS_DIR/install-zsh.sh"
    run_step "Node.js + NVM" "$SCRIPTS_DIR/install-node.sh"
    run_step "Configuração do Git" "$SCRIPTS_DIR/configure-git.sh"
    run_step "Personalização do Terminal" "$SCRIPTS_DIR/configure-terminal.sh"
}

# Show completion message
show_completion() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 INSTALAÇÃO CONCLUÍDA COM SUCESSO! 🎉${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}📋 Próximos passos:${NC}"
    echo ""
    echo "1. 🔄 Reinicie o terminal ou execute: source ~/.zshrc"
    echo "2. 🎨 Configure o iTerm2 com o tema Dracula (instruções no README)"
    echo "3. 🔍 Execute 'check-env' para verificar o ambiente"
    echo "4. 📁 Seus projetos devem ficar em: ~/Projects"
    echo ""
    echo -e "${CYAN}🛠️  Ferramentas disponíveis:${NC}"
    echo "• Homebrew: brew"
    echo "• Node.js: node, npm, yarn"
    echo "• Git: git (com aliases úteis)"
    echo "• Terminal: Oh My Zsh com tema Dracula"
    echo ""
    echo -e "${CYAN}🔗 Comandos úteis:${NC}"
    echo "• nvm use <version> - Trocar versão do Node.js"
    echo "• sysinfo - Informações do sistema"
    echo "• projects - Ir para pasta de projetos"
    echo "• gst - Git status"
    echo "• gpo - Git push origin"
    echo ""
    echo -e "${YELLOW}⚠️  Lembre-se: Alguns aplicativos como Docker Desktop devem ser instalados manualmente.${NC}"
    echo ""
    echo -e "${GREEN}✨ Ambiente de desenvolvimento configurado e pronto para uso!${NC}"
}

# Cleanup function
cleanup() {
    log "🧹 Limpeza final..."
    
    # Remove any temporary files
    find /tmp -name "mac-setup-*" -type f -delete 2>/dev/null || true
    
    # Clear Homebrew cache
    if command -v brew &> /dev/null; then
        brew cleanup 2>/dev/null || true
    fi
    
    success "Limpeza concluída"
}

# Main execution
main() {
    banner
    check_macos
    check_requirements
    make_scripts_executable
    
    while true; do
        echo ""
        show_menu
        read -r choice
        
        case $choice in
            1)
                complete_installation
                cleanup
                show_completion
                break
                ;;
            2)
                if custom_installation; then
                    cleanup
                    show_completion
                    break
                fi
                ;;
            3)
                show_current_environment
                ;;
            4)
                log "Saindo..."
                exit 0
                ;;
            *)
                error "Opção inválida! Escolha 1-4."
                ;;
        esac
    done
}

# Handle script interruption
trap 'echo ""; error "Instalação interrompida pelo usuário"; exit 1' INT TERM

# Run main function
main "$@"