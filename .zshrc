# --- POWERLEVEL10K INSTANT PROMPT (DEVE FICAR NO TOPO) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- CONFIGURACOES BASICAS ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Lista de Plugins Ativos
# Inclui sudo (apertar Esc duas vezes poe sudo no comando) e fzf (busca rapida)
plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    history-substring-search 
    sudo 
    fzf
    docker
    docker-compose
)

source $ZSH/oh-my-zsh.sh

# --- CONFIGURACOES DE USUARIO ---
export LANG=en_US.UTF-8

# Editor padrao (Tenta abrir com nano, senao vim)
if command -v nano >/dev/null; then
    export EDITOR='nano'
else
    export EDITOR='vim'
fi

# --- ALIASES INTELIGENTES (CAIXA DE FERRAMENTAS) ---

# 1. Gerenciamento de Pacotes (Hibrido Fedora/Debian)
if command -v dnf &> /dev/null; then
    # FEDORA
    alias update='sudo dnf upgrade --refresh -y && flatpak update'
    alias install='sudo dnf install'
    alias remove='sudo dnf remove'
    alias search='dnf search'
elif command -v apt &> /dev/null; then
    # DEBIAN / UBUNTU / PROXMOX
    alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
    alias install='sudo apt install'
    alias remove='sudo apt remove'
    alias search='apt search'
fi

# 2. Navegacao e Listagem
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# 3. Ferramentas Uteis (Se existirem)
# 'disk' abre o ncdu (analisador visual de disco)
if command -v ncdu &> /dev/null; then
    alias disk='ncdu'
fi

# 'top' abre o btop (monitor visual moderno) se existir
if command -v btop &> /dev/null; then
    alias top='btop'
fi

# 'ports' mostra portas abertas (substituto facil do netstat)
alias ports='sudo netstat -tulanp'

# 4. Git Shortcuts
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# 5. Sistema
alias reload='source ~/.zshrc'
alias cls='clear'
alias myip='curl ifconfig.me' # Mostra IP externo

# Carrega config do P10k se existir
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
