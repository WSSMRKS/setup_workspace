# Powerlevel10k instant prompt (keep at very top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
  z
  docker
  tmux
)

source $ZSH/oh-my-zsh.sh

# --- Environment ---
export EDITOR="vim"
export VISUAL="vim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# --- Path ---
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# --- fzf ---
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --info=inline
'

# --- zoxide (replaces cd with frecency matching) ---
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# --- History ---
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# --- General aliases ---
alias ll="ls -lah --color=auto"
alias la="ls -A --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias cls="clear"

# --- Git aliases ---
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph -20"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gst="git stash"

# --- tmux aliases ---
alias ta="tmux attach -t"
alias tn="tmux new -s"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"

# --- 42 / C ---
alias norm="norminette"
alias cc42="cc -Wall -Wextra -Werror"
alias val="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes"

# --- Docker ---
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# --- Quick edit ---
alias ezsh="$EDITOR ~/.zshrc"
alias etmux="$EDITOR ~/.tmux.conf"
alias evim="$EDITOR ~/.vimrc"
alias reload="source ~/.zshrc"

# --- Functions ---

# mkdir + cd in one
mkcd() { mkdir -p "$1" && cd "$1"; }

# find process by name
psg() { ps aux | grep -v grep | grep -i "$1"; }

# quick HTTP server
serve() { python3 -m http.server "${1:-8000}"; }

# --- Powerlevel10k config ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Local overrides (machine-specific, not committed) ---
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
