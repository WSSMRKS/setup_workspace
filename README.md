# setup_workspace

Repeatable dev environment: Zsh + Oh My Zsh + Starship + Vim + tmux. Unified Catppuccin Mocha theme across all tools.

## Quick start

### Option 1: Full setup (with sudo)

```bash
git clone git@github.com:WSSMRKS/setup_workspace.git ~/setup_workspace
cd ~/setup_workspace
chmod +x install.sh install_nosudo.sh
./install.sh      # Installs system packages (requires sudo)
./install_nosudo.sh  # Installs user-level tools
```

### Option 2: No sudo (e.g., work PC)

If system packages (`tmux`, `vim`, `zsh`, `git`) are already installed:

```bash
git clone git@github.com:WSSMRKS/setup_workspace.git ~/setup_workspace
cd ~/setup_workspace
chmod +x install_nosudo.sh
./install_nosudo.sh
```

Then follow the first time setup in `CHEATSHEET.md`:

```bash
glow -p CHEATSHEET.md
```

Short version:
1. `chsh -s $(which zsh)` — set zsh as default shell
2. In GNOME Terminal: **Preferences → select Catppuccin Mocha profile → set as default**
3. Open a new terminal — Starship prompt loads automatically
4. Open vim and run `:PlugInstall` to install the Catppuccin theme
5. Open tmux and press `Ctrl-a + I` to install plugins

## What's included

### Install scripts

| Script | What it does | Requires sudo |
|--------|-------------|---------------|
| `install.sh` | System packages (tmux, vim, zsh, git), Oh My Zsh plugins, Starship, TPM, theme files | Yes |
| `install_nosudo.sh` | User-level tools (ripgrep, fd, fzf, glow, zoxide), symlinks dotfiles, spell files | No |

**Note:** If you don't have sudo, make sure `tmux`, `vim`, `zsh`, and `git` are already installed on your system before running `install_nosudo.sh`. Ask your admin if they're not available.

### Config files

| File | What it does |
|------|-------------|
| `zshrc` | Starship prompt, autosuggestions, syntax highlighting, fzf, zoxide, aliases |
| `starship.toml` | Starship config with Catppuccin Mocha palette |
| `tmux.conf` | Ctrl-a prefix, vim navigation, resurrect + continuum (session persistence) |
| `vimrc` | vim-plug + Catppuccin Mocha, sane defaults, spell check |
| `CHEATSHEET.md` | Key bindings and aliases reference — view with `glow -p CHEATSHEET.md` |
| `cheatsheets/` | Individual cheatsheets for tmux, vim, zsh, and tools |

## Theme

All tools use **Catppuccin Mocha** for a unified color scheme.

| App | How it's applied |
|-----|-----------------|
| GNOME Terminal | Install script: `python3 install.py` from [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal), then select Mocha profile in Preferences |
| tmux | `catppuccin/tmux` plugin via TPM — install with `prefix + I` |
| vim | `catppuccin/vim` plugin via vim-plug — install with `:PlugInstall` |
| fzf | Color flags set in `FZF_DEFAULT_OPTS` in `.zshrc` |
| glow | Glamour JSON theme at `~/.config/glow/catppuccin-mocha.json` from [catppuccin/glamour](https://github.com/catppuccin/glamour) |
| btop | Theme file at `~/.config/btop/themes/catppuccin_mocha.theme` from [catppuccin/btop](https://github.com/catppuccin/btop) |
| Starship | `starship.toml` in repo with Catppuccin Mocha palette, symlinked to `~/.config/starship.toml` |

## Key bindings cheat sheet

### tmux (prefix: `Ctrl-a`)

| Key | Action |
|-----|--------|
| `\|` | Split vertical |
| `-` | Split horizontal |
| `h/j/k/l` | Navigate panes |
| `C-h/j/k/l` | Resize panes |
| `r` | Reload config |
| `x` | Kill pane |
| `Enter` | Copy mode (vi keys) |

### vim (leader: `Space`)

| Key | Action |
|-----|--------|
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>e` | Toggle file explorer |
| `<leader><space>` | Clear search |
| `<leader>r` | Replace word under cursor |
| `<leader>bn/bp/bd` | Next/prev/delete buffer |
| `C-h/j/k/l` | Navigate splits |

## Machine-specific overrides

Create `~/.zshrc.local` for anything that shouldn't be committed (API keys, machine-specific paths, etc). It's sourced automatically.

## Updating

```bash
cd ~/setup_workspace
git pull
# Re-run install.sh if new dependencies were added
```

`install.sh` symlinks config files into their standard locations (`~/.zshrc`, `~/.tmux.conf`, `~/.vimrc`), pointing them back into this repo. Edits here are live immediately — no copy step needed. Reload with `source ~/.zshrc` or tmux `prefix + r`.
