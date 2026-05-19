#!/usr/bin/env bash
# install_nosudo.sh — dotfiles setup without sudo (tmux already installed)
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

echo "==> Installing dotfiles (no-sudo) from $DOTFILES_DIR"
echo "    Binaries go to $BIN_DIR"

# --- Detect architecture ---
ARCH="$(uname -m)"
case "$ARCH" in
  x86_64)   ARCH_RG="x86_64-unknown-linux-musl"
            ARCH_FD="x86_64-unknown-linux-musl"
            ARCH_GLOW="Linux_x86_64"
            ;;
  aarch64)  ARCH_RG="aarch64-unknown-linux-gnu"
            ARCH_FD="aarch64-unknown-linux-gnu"
            ARCH_GLOW="Linux_arm64"
            ;;
  *)        echo "  Unknown arch $ARCH — some binary installs may be skipped." ;;
esac

# Helper: download + extract a single binary from a .tar.gz
install_bin_from_tar() {
  local url="$1" binary="$2"
  local tmp; tmp="$(mktemp -d)"
  curl -fsSL "$url" | tar -xz -C "$tmp" 2>/dev/null
  local found; found="$(find "$tmp" -type f -name "$binary" | head -1)"
  if [ -n "$found" ]; then
    cp "$found" "$BIN_DIR/$binary"
    chmod +x "$BIN_DIR/$binary"
    echo "  Installed $binary -> $BIN_DIR/$binary"
  else
    echo "  Could not find $binary in archive from $url"
  fi
  rm -rf "$tmp"
}

# Helper: latest GitHub release tag
gh_latest() {
  curl -fsSL "https://api.github.com/repos/$1/releases/latest" \
    | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/'
}

# --- ripgrep ---
if ! command -v rg &>/dev/null; then
  echo "==> Installing ripgrep..."
  VER="$(gh_latest BurntSushi/ripgrep)"
  VER_NUM="${VER#v}"
  URL="https://github.com/BurntSushi/ripgrep/releases/download/${VER}/ripgrep-${VER_NUM}-${ARCH_RG}.tar.gz"
  install_bin_from_tar "$URL" "rg"
else
  echo "==> ripgrep already installed, skipping."
fi

# --- fd ---
if ! command -v fd &>/dev/null && ! command -v fdfind &>/dev/null; then
  echo "==> Installing fd..."
  VER="$(gh_latest sharkdp/fd)"
  VER_NUM="${VER#v}"
  URL="https://github.com/sharkdp/fd/releases/download/${VER}/fd-${VER}-${ARCH_FD}.tar.gz"
  install_bin_from_tar "$URL" "fd"
else
  echo "==> fd already installed, skipping."
fi

# --- fzf ---
if ! command -v fzf &>/dev/null; then
  echo "==> Installing fzf..."
  if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  fi
  "$HOME/.fzf/install" --bin --no-update-rc --no-completion --no-key-bindings
  ln -sf "$HOME/.fzf/bin/fzf" "$BIN_DIR/fzf"
  echo "  Installed fzf -> $BIN_DIR/fzf"
else
  echo "==> fzf already installed, skipping."
fi

# --- glow ---
if ! command -v glow &>/dev/null; then
  echo "==> Installing glow..."
  VER="$(gh_latest charmbracelet/glow)"
  VER_NUM="${VER#v}"
  URL="https://github.com/charmbracelet/glow/releases/download/${VER}/glow_${VER_NUM}_${ARCH_GLOW}.tar.gz"
  install_bin_from_tar "$URL" "glow"
else
  echo "==> glow already installed, skipping."
fi

# --- zoxide ---
if ! command -v zoxide &>/dev/null; then
  echo "==> Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "==> zoxide already installed, skipping."
fi

# --- Oh My Zsh ---
echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "  Already installed, skipping."
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

# --- Tmux Plugin Manager ---
echo "==> Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "  Already installed, skipping."
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

# --- Ensure ~/.local/bin is in PATH (append to zshrc if missing) ---
if ! grep -q '\.local/bin' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
  echo "  Added ~/.local/bin to PATH in .zshrc"
fi

echo ""
echo "==> Done! Next steps:"
echo "  1. Start zsh:  exec zsh   (or open a new terminal)"
echo "     (chsh skipped — no sudo. To make zsh default permanently, ask your admin.)"
echo "  2. Run 'p10k configure' to set up your prompt"
echo "  3. In tmux, press Ctrl-a + I to install tmux plugins"
