#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "==> Installing dotfiles from $DOTFILES_DIR"

# --- Detect package manager ---
if command -v apt-get &>/dev/null; then
  PKG_INSTALL="sudo apt-get install -y"
  sudo apt-get update -qq || echo "  apt update had warnings (broken repo?), continuing anyway..."
elif command -v pacman &>/dev/null; then
  PKG_INSTALL="sudo pacman -S --noconfirm"
elif command -v dnf &>/dev/null; then
  PKG_INSTALL="sudo dnf install -y"
elif command -v brew &>/dev/null; then
  PKG_INSTALL="brew install"
else
  echo "No supported package manager found. Install packages manually."
  exit 1
fi

# --- Core packages ---
echo "==> Installing core packages..."
$PKG_INSTALL zsh vim tmux git curl wget unzip ripgrep fzf || true

# fd is named differently across distros
$PKG_INSTALL fd-find 2>/dev/null || $PKG_INSTALL fd 2>/dev/null || true

# glow (markdown viewer)
echo "==> Installing glow..."
if ! command -v glow &>/dev/null; then
  if command -v apt-get &>/dev/null; then
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
      | sudo tee /etc/apt/sources.list.d/charm.list > /dev/null
    sudo apt-get update -qq && sudo apt-get install -y glow
  else
    $PKG_INSTALL glow 2>/dev/null || \
      echo "  glow not in package manager — install manually: https://github.com/charmbracelet/glow"
  fi
fi

# --- Oh My Zsh ---
echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- Zsh plugins ---
echo "==> Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

declare -A ZSH_PLUGINS=(
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
)

for plugin in "${!ZSH_PLUGINS[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
    git clone --depth=1 "${ZSH_PLUGINS[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
  fi
done

# --- Powerlevel10k ---
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# --- zoxide ---
echo "==> Installing zoxide..."
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# --- Tmux Plugin Manager ---
echo "==> Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Symlink dotfiles ---
echo "==> Symlinking dotfiles..."
declare -a DOTFILES=(.zshrc .tmux.conf .vimrc)

for file in "${DOTFILES[@]}"; do
  src="$DOTFILES_DIR/${file#.}"
  dest="$HOME/$file"
  if [ -f "$src" ]; then
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "  Backing up existing $dest -> ${dest}.bak"
      mv "$dest" "${dest}.bak"
    fi
    ln -sf "$src" "$dest"
    echo "  Linked $dest -> $src"
  fi
done

# --- Set default shell ---
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(which zsh)" || echo "  Run manually: chsh -s $(which zsh)"
fi

echo ""
echo "==> Done! Next steps:"
echo "  1. Open a new terminal or run: exec zsh"
echo "  2. Run 'p10k configure' to set up your prompt"
echo "  3. In tmux, press Ctrl-a + I to install tmux plugins"
