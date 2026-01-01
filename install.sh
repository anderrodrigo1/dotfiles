#!/bin/bash

echo ">>> Iniciando o Setup do Ambiente (Modo Powerlevel10k)..."

# 1. Instalar dependencias basicas
echo "[+] Verificando dependencias de sistema..."
if command -v apt >/dev/null; then
  sudo apt update && sudo apt install -y zsh git curl fontconfig
fi

# 2. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[+] Instalando Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[!] Oh My Zsh ja instalado."
fi

# 3. Baixar Tema e Plugins (Essencial para o seu .zshrc funcionar)
echo "[+] Baixando componentes visuais..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# TEMA: Powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "[+] Baixando tema Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# PLUGIN: Auto-suggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "[+] Baixando plugin Auto-suggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# PLUGIN: Syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "[+] Baixando plugin Syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# 4. Clonar/Atualizar Dotfiles
if [ ! -d "$HOME/dotfiles" ]; then
  echo "[+] Clonando repositorio Dotfiles..."
  git clone https://github.com/anderrodrigo1/dotfiles.git $HOME/dotfiles
else
  echo "[*] Atualizando Dotfiles existentes..."
  cd $HOME/dotfiles && git pull
fi

# 5. Criar Links Simbolicos
echo "[+] Vinculando arquivos de configuracao..."
rm -rf $HOME/.zshrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

# Se existir o arquivo de config do p10k, vincula tambem
if [ -f "$HOME/dotfiles/.p10k.zsh" ]; then
    rm -rf $HOME/.p10k.zsh
    ln -s $HOME/dotfiles/.p10k.zsh $HOME/.p10k.zsh
fi

# 6. Definir Zsh como padrao
echo "[+] Definindo Zsh como shell padrao..."
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s $(which zsh) $USER
fi

echo ">>> Setup concluido! Reinicie o terminal para ver o Powerlevel10k."
