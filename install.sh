#!/bin/bash

echo ">>> Iniciando Setup Completo (Versao Generosa)..."

# --- DEFINICAO DA CAIXA DE FERRAMENTAS ---
# Kit essencial para SysAdmin e Data Engineer:
# - Monitoramento: htop, btop, iotop (disco), iftop (rede)
# - Rede: curl, wget, net-tools, dnsutils/bind-utils (dig, nslookup)
# - Arquivos: zip, unzip, tree, ncdu (analise de disco visual)
# - Dados/Dev: git, jq (processar JSON), ripgrep (grep ultra rapido), fzf (busca inteligente)
# - Terminal: tmux (sessao persistente), neofetch/fastfetch

PACKAGES_APT="zsh git curl wget htop btop net-tools unzip zip nano vim tree jq ncdu ripgrep fzf tmux dnsutils build-essential"
PACKAGES_DNF="zsh git curl wget htop btop net-tools unzip zip nano vim tree jq ncdu ripgrep fzf tmux bind-utils make automake gcc"

# 1. Detectar Sistema e Instalar
echo "[+] Detectando sistema operacional e instalando ferramentas..."

if command -v apt >/dev/null; then
    echo "    -> Sistema Debian/Ubuntu/Proxmox detectado."
    # Tenta evitar interrupcoes de servicos
    export DEBIAN_FRONTEND=noninteractive
    sudo apt update
    sudo apt install -y $PACKAGES_APT

elif command -v dnf >/dev/null; then
    echo "    -> Sistema Fedora/RHEL detectado."
    sudo dnf check-update
    sudo dnf install -y $PACKAGES_DNF
fi

# 2. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[+] Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[!] Oh My Zsh ja instalado."
fi

# 3. Plugins e Temas Visuais (Powerlevel10k)
echo "[+] Configurando Visual e Plugins ZSH..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Tema P10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Plugins Essenciais
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
[ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ] && git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search

# 4. Clonar/Atualizar Dotfiles
if [ ! -d "$HOME/dotfiles" ]; then
  echo "[+] Clonando repositorio Dotfiles..."
  git clone https://github.com/anderrodrigo1/dotfiles.git $HOME/dotfiles
else
  echo "[*] Atualizando Dotfiles..."
  cd $HOME/dotfiles && git pull
fi

# 5. Links Simbolicos (Ajusta configs)
echo "[+] Criando links para .zshrc e .p10k.zsh..."
rm -rf $HOME/.zshrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

if [ -f "$HOME/dotfiles/.p10k.zsh" ]; then
    rm -rf $HOME/.p10k.zsh
    ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh
fi

# 6. Definir Zsh como padrao
echo "[+] Definindo Shell padrao..."
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s $(which zsh) $USER
fi

echo ">>> Setup COMPLETO finalizado! Reinicie o terminal."
