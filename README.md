# 🚀 Dotfiles & Setup Híbrido | Anderson

![Status](https://img.shields.io/badge/Status-Stable-green)
![System](https://img.shields.io/badge/OS-Fedora%20%7C%20Ubuntu%20%7C%20Debian-blue)
![Shell](https://img.shields.io/badge/Shell-Zsh%20%2B%20OhMyZsh-orange)

**Última atualização**: 2025-01-01  
**Compatibilidade**: Fedora (Workstation) | Debian/Ubuntu/Proxmox (Servidores)

---

## 📋 Visão Geral

> **Automação completa para ambientes de Engenharia de Dados e HomeLab.**

Este repositório contém scripts de automação (`dotfiles`) para transformar uma instalação limpa de Linux em uma estação de trabalho poderosa em minutos. Ele configura o shell **Zsh**, instala o tema **Powerlevel10k** e uma "Caixa de Ferramentas Generosa" para administração de sistemas.

---

## ⚡ Instalação Rápida (One-Liner)

Em qualquer máquina nova (VM na Cloud, Servidor Físico ou Laptop), rode apenas este comando:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/anderrodrigo1/dotfiles/main/install.sh)"
```

### O que o script faz automaticamente:

| Etapa | Descrição |
|-------|-----------|
| 🕵️ Detecta o Sistema | Verifica se é base Debian (`apt`) ou Fedora (`dnf`) |
| 📦 Instala o Kit | Baixa todas as ferramentas essenciais listadas abaixo |
| 🎨 Configura Zsh | Instala Oh My Zsh, Plugins (Sugestões, Syntax Highlighting) e o tema Powerlevel10k |
| 🔗 Aplica Configs | Cria links simbólicos para manter o `.zshrc` atualizado |

---

## 🧰 A "Caixa de Ferramentas" (Kit Generoso)

O script garante que as seguintes categorias de software estejam instaladas:

### 📊 Monitoramento & Sistema

| Ferramenta | Descrição | Comando/Alias |
|------------|-----------|---------------|
| Btop | Monitor de recursos moderno e visual (CPU, Mem, Rede, GPU) | `top` |
| Htop | Gerenciador de processos clássico e leve | `htop` |
| Ncdu | Analisador de uso de disco visual (ótimo para limpar logs) | `disk` |

### 🌐 Rede & Conectividade

| Ferramenta | Descrição | Comando |
|------------|-----------|---------|
| Net-Tools | Ferramentas clássicas de rede (`netstat`, `ifconfig`, `arp`) | `ports` |
| Bind-Utils | Utilitários de DNS (`dig`, `nslookup`, `host`) | `dig` |
| Curl / Wget | Transferência de dados via terminal e teste de APIs | `curl` |

### 🛠️ Data Engineering & Dev

| Ferramenta | Descrição | Comando |
|------------|-----------|---------|
| Jq | Processador de JSON via linha de comando (Essencial para APIs) | `jq` |
| Ripgrep | Buscador de texto ultra-rápido (substituto moderno do `grep`) | `rg` |
| Fzf | "Fuzzy Finder" - Busca inteligente no histórico e arquivos | `Ctrl+R` |
| Git | Controle de versão distribuído | `git` |

### 🖥️ Terminal & Produtividade

| Ferramenta | Descrição | Comando |
|------------|-----------|---------|
| Zsh | Shell robusto, configurado com Oh My Zsh | `zsh` |
| Tmux | Multiplexador de terminal (sessões persistentes e split-screen) | `tmux` |
| Unzip/Zip | Manipulação de arquivos compactados | `unzip` |
| Nano/Vim | Editores de texto (Nano configurado como padrão fácil) | `nano` |

---

## 🧠 Aliases Inteligentes (Híbridos)

O arquivo `.zshrc` possui lógica para adaptar os comandos dependendo do sistema operacional, facilitando a manutenção de ambientes mistos.

### Aliases por Sistema

| Alias | Fedora (Comando Real) | Debian/Ubuntu (Comando Real) |
|-------|----------------------|------------------------------|
| `update` | `sudo dnf upgrade --refresh && flatpak update` | `sudo apt update && sudo apt full-upgrade -y` |
| `install` | `sudo dnf install` | `sudo apt install` |
| `remove` | `sudo dnf remove` | `sudo apt remove` |
| `search` | `sudo dnf search` | `sudo apt search` |

### Outros Atalhos Úteis

| Alias | Descrição |
|-------|-----------|
| `ports` | Lista todas as portas ouvindo conexões (`netstat -tulanp`) |
| `myip` | Mostra seu IP Externo público |
| `reload` | Recarrega as configurações do terminal (`source ~/.zshrc`) |
| `gs`, `gc`, `gp` | Atalhos para Git (Status, Commit, Push) |

---

## 📜 Histórico de Versões (Changelog)

| Versão | Título | Alterações |
|--------|--------|------------|
| **v1.2.0** | Kit Generoso & Híbrido | Suporte total a Fedora (`dnf`) e Debian/Ubuntu (`apt`) no mesmo script |
| | | Adicionado `btop`, `ncdu`, `jq`, `ripgrep` ao instalador padrão |
| | | Remoção de emojis do `install.sh` para evitar erros de caractere em servidores antigos |
| | | Aliases dinâmicos criados no `.zshrc` |
| **v1.1.0** | Powerlevel10k & Fixes | Migração para o tema Powerlevel10k |
| | | Correção de links simbólicos quebrados |
| | | Adicionado `zsh-autosuggestions` e `syntax-highlighting` |
| **v1.0.0** | Inicial | Criação inicial dos dotfiles |
| | | Setup básico do Zsh |
