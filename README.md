# 🚀 Mac Setup Automático

Sistema completo de configuração automatizada do ambiente de desenvolvimento para macOS.

## 📋 Visão Geral

Este repositório contém um conjunto de scripts modulares que automatizam completamente a configuração de um ambiente de desenvolvimento em macOS, baseado na análise do seu ambiente atual.

### ✨ Funcionalidades

- 🍺 **Homebrew**: Instalação e configuração completa
- 🐚 **Zsh + Oh My Zsh**: Shell moderno com tema Dracula  
- 🟢 **Node.js + NVM**: Múltiplas versões do Node.js
- 📦 **Pacotes Essenciais**: Ferramentas de desenvolvimento
- 🔧 **Configuração Git**: Setup completo com aliases
- 🎨 **Terminal**: Personalização e tema Dracula

## 🎯 Configuração Detectada (Baseada no seu ambiente)

### Homebrew Packages Detectados
- **Core**: git, tree, curl, wget, jq, htop
- **Node.js**: nvm, node, npm, yarn
- **Linguagens**: go, python@3.12, ruby
- **Databases**: postgresql@14, redis, sqlite
- **DevOps**: docker, awscli, aws-elasticbeanstalk
- **Utilities**: httpie, ffmpeg, tesseract

### Configurações Atuais
- **Shell**: Zsh com Oh My Zsh
- **Tema**: Dracula 
- **Plugins**: git, zsh-autosuggestions
- **Node.js**: v18.19.1 (padrão), v16.20.2, v20.10.0, v22.11.0
- **Aliases**: gpo="git push origin"

## 🚀 Uso Rápido

```bash
# Clone o repositório
git clone https://github.com/andrevvalle/my-os-configs
cd mac-setup

# Execute o script principal
./setup.sh
```

### Opções de Instalação

1. **🚀 Instalação Completa** (Recomendado)
2. **🔧 Instalação Customizada** (Escolher componentes)
3. **📊 Verificar Ambiente** (Status atual)

## 📁 Estrutura do Projeto

```
mac-setup/
├── setup.sh                    # Script principal interativo
├── scripts/                    # Scripts modulares
│   ├── install-homebrew.sh     # Instalação do Homebrew
│   ├── install-zsh.sh          # Zsh + Oh My Zsh + Dracula
│   ├── install-node.sh         # Node.js + NVM
│   ├── install-packages.sh     # Pacotes Homebrew
│   ├── configure-git.sh        # Configuração do Git
│   └── configure-terminal.sh   # Personalização terminal
├── config/                     # Arquivos de configuração
│   ├── homebrew-packages.txt   # Lista de pacotes
│   ├── homebrew-casks.txt      # Lista de aplicativos
│   └── zsh-config.sh          # Configurações Zsh
├── templates/                  # Templates e temas
│   └── Dracula.itermcolors    # Tema iTerm2
└── README.md                   # Esta documentação
```

## 🔧 Scripts Modulares

Cada script pode ser executado independentemente:

| Script | Descrição | Dependências |
|--------|-----------|--------------|
| `install-homebrew.sh` | Instala/atualiza Homebrew | Nenhuma |
| `install-packages.sh` | Instala pacotes via Homebrew | Homebrew |
| `install-zsh.sh` | Configura Zsh + Oh My Zsh + tema | Nenhuma |
| `install-node.sh` | Instala Node.js via NVM | Nenhuma |
| `configure-git.sh` | Configura Git com aliases | Git |
| `configure-terminal.sh` | Personaliza terminal | Zsh |

## ⚙️ Pré-requisitos

- **macOS** (testado no macOS 14+)
- **Conexão com internet**
- **Xcode Command Line Tools** (instalado automaticamente se necessário)

### Assumidos como já instalados:
- iTerm2
- Docker Desktop

## 🎨 Customização

### Pacotes Homebrew
Edite `config/homebrew-packages.txt` para adicionar/remover pacotes:

```bash
# Core development tools
git
tree
node
# Adicione seus pacotes aqui
```

### Configurações Zsh
Edite `config/zsh-config.sh` para personalizar:
- Tema do Oh My Zsh
- Plugins ativos
- Aliases personalizados
- Variáveis de ambiente

### Configurações Locais
Após a instalação, use `~/.zshrc.local` para customizações pessoais que não serão sobrescritas.

## 🔍 Comandos Úteis

Após a instalação, você terá acesso a:

```bash
# Verificação do ambiente
check-env                    # Status completo do ambiente
sysinfo                      # Informações do sistema

# Navegação rápida
projects                     # Ir para ~/Projects
..                          # cd ..
...                         # cd ../..

# Git aliases
gst                         # git status
gco <branch>                # git checkout
gpl                         # git pull
gpo                         # git push origin
gac "message"               # git add . && git commit -m
gacp "message"              # git add . && git commit -m && git push

# Node.js
nvm use <version>           # Trocar versão Node.js
nvm list                    # Listar versões instaladas

# Docker helpers
dps                         # docker ps formatado

# Network
myip                        # IP público
localip                     # IP local

# Desenvolvimento
serve                       # Iniciar servidor (detecta package.json)
weather <city>              # Previsão do tempo
```

## 🔄 Execução em Novo MacBook

No novo MacBook:

```bash
# 1. Instalar iTerm2 e Docker Desktop manualmente

# 2. Clonar e executar
git clone https://github.com/seu-usuario/mac-setup.git
cd mac-setup
./setup.sh

# 3. Seguir instruções interativas
# 4. Reiniciar terminal
# 5. Executar check-env para verificar
```

## 🎛️ Configuração Manual do iTerm2

Após executar o setup:

1. Abra **iTerm2**
2. Va em **iTerm2 > Preferences > Profiles > Colors**
3. Clique em **Color Presets > Import**
4. Selecione: `templates/Dracula.itermcolors`
5. Aplique o preset **Dracula**

## 🐛 Troubleshooting

### Problemas Comuns

1. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

2. **Permissions no Homebrew**
   ```bash
   sudo chown -R $(whoami) /opt/homebrew
   ```

3. **NVM não carrega**
   ```bash
   source ~/.zshrc
   ```

4. **Git não configurado**
   ```bash
   ./scripts/configure-git.sh
   ```

### Logs

Todos os scripts exibem logs coloridos para facilitar debug:
- 🔵 **Info**: Informações gerais
- ✅ **Success**: Operações bem-sucedidas  
- ⚠️ **Warning**: Avisos (não críticos)
- ❌ **Error**: Erros críticos

## 📝 Changelog

### v1.0.0 - Setup Inicial
- Script principal interativo
- 6 módulos de instalação
- Configuração baseada em ambiente existente
- Suporte completo ao macOS
- Documentação completa

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

## 📞 Suporte

- 🐛 **Issues**: Para bugs e solicitações de funcionalidades
- 📖 **Wiki**: Documentação adicional
- 💬 **Discussions**: Perguntas e discussões

---

**✨ Feito com ❤️ para automatizar a configuração do ambiente macOS de desenvolvimento**
