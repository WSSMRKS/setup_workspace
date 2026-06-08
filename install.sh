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
$PKG_INSTALL zsh vim neovim tmux git curl wget unzip ripgrep fzf || true

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

# --- Starship ---
echo "==> Installing Starship..."
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
fi

# --- zoxide ---
echo "==> Installing zoxide..."
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# --- vim-plug (for Neovim) ---
echo "==> Installing vim-plug..."
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "  Already installed, skipping."
fi

# --- Tmux Plugin Manager ---
echo "==> Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Catppuccin theme files ---
echo "==> Installing Catppuccin theme files..."

# glow
mkdir -p "$HOME/.config/glow"
curl -fsSLo "$HOME/.config/glow/catppuccin-mocha.json" \
  https://raw.githubusercontent.com/catppuccin/glamour/main/themes/catppuccin-mocha.json

# btop
mkdir -p "$HOME/.config/btop/themes"
curl -fsSLo "$HOME/.config/btop/themes/catppuccin_mocha.theme" \
  https://raw.githubusercontent.com/catppuccin/btop/main/themes/catppuccin_mocha.theme

# --- Symlink dotfiles ---
echo "==> Symlinking dotfiles..."
declare -a DOTFILES=(.zshrc .tmux.conf)

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

# Neovim config
mkdir -p "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/init.vim" "$HOME/.config/nvim/init.vim"
echo "  Linked ~/.config/nvim/init.vim -> $DOTFILES_DIR/init.vim"

# Starship config
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
echo "  Linked ~/.config/starship.toml -> $DOTFILES_DIR/starship.toml"

# --- GNOME Terminal: bind Ctrl+Alt+T ---
if command -v gsettings &>/dev/null && command -v gnome-terminal &>/dev/null; then
  echo "==> Binding Ctrl+Alt+T to gnome-terminal..."
  gsettings set org.gnome.settings-daemon.plugins.media-keys terminal '[]'
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
    "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
    name 'Terminal'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
    command '/usr/bin/gnome-terminal'
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ \
    binding '<Ctrl><Alt>t'
fi

# --- Set default shell ---
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(which zsh)" || echo "  Run manually: chsh -s $(which zsh)"
fi

echo ""
echo "==> Done! Next steps:"
echo "  1. Open a new terminal or run: exec zsh"
echo "  2. In GNOME Terminal: Preferences → select 'Catppuccin Mocha' profile"
echo "     (run the catppuccin/gnome-terminal install script first if not done)"
echo "  3. In vim, run :PlugInstall to install the Catppuccin theme"
echo "  4. In tmux, press Ctrl-a + I to install tmux plugins"
