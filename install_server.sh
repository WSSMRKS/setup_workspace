#!/usr/bin/env bash
# install_server.sh — lean setup for headless servers (e.g. Raspberry Pi)
#
# Distro packages + dotfile symlinks only. Deliberately skips everything
# install.sh / install_nosudo.sh add on a workstation:
#   no Oh My Zsh, Starship, zoxide, nvm/Node, coc.nvim, glow,
#   no third-party apt repositories, no curl|sh installers.
# The one network fetch besides apt: TPM (tmux plugin manager) via git,
# so tmux-resurrect/continuum work. Plugins install on prefix + I.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v apt-get &>/dev/null; then
  echo "install_server.sh supports apt-based systems only (Debian, Raspberry Pi OS, Ubuntu)."
  exit 1
fi

echo "==> Installing packages..."
sudo apt-get update -qq
sudo apt-get install -y zsh tmux neovim git ripgrep fzf fd-find

# Debian ships fd as 'fdfind'; zshrc expects 'fd'
mkdir -p "$HOME/.local/bin"
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  echo "  Linked ~/.local/bin/fd -> fdfind"
fi

echo "==> Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "  Already installed, skipping."
fi

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  Backing up existing $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -sf "$src" "$dest"
  echo "  Linked $dest -> $src"
}

echo "==> Symlinking dotfiles..."
link "$DOTFILES_DIR/zshrc"           "$HOME/.zshrc"
link "$DOTFILES_DIR/tmux.conf"       "$HOME/.tmux.conf"
link "$DOTFILES_DIR/init.server.vim" "$HOME/.config/nvim/init.vim"

if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(command -v zsh)" || echo "  Run manually: chsh -s $(command -v zsh)"
fi

echo ""
echo "==> Done. Next:"
echo "  1. Log out and back in (zsh becomes the login shell)"
echo "  2. Start tmux, press Ctrl-a + I to install tmux plugins"
