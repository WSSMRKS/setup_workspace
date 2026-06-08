# setup_workspace

Repeatable dev environment: **Zsh + Oh My Zsh + Starship + Neovim (with LSP) + tmux + Node.js**. Unified Catppuccin Mocha theme across all tools. Neovim includes coc.nvim for language server support (go-to-definition, hover docs, diagnostics).

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

If system packages (`tmux`, `neovim`, `zsh`, `git`) are already installed:

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
3. Open a new terminal — Starship prompt loads automatically and nvm initializes
4. Open nvim — plugins auto-install on first launch (or run `:PlugInstall` manually)
5. In nvim, run `:CocInstall coc-clangd` for C/C++ language server support
6. Open tmux and press `Ctrl-a + I` to install plugins

## What's included

### Install scripts

| Script | What it does | Requires sudo |
|--------|-------------|---------------|
| `install.sh` | System packages (tmux, neovim, zsh, git), Oh My Zsh plugins, Starship, TPM, theme files | Yes |
| `install_nosudo.sh` | User-level tools (neovim, ripgrep, fd, fzf, glow, zoxide, nvm + Node.js v24), symlinks dotfiles, spell files, vim-plug | No |

**Note:** If you don't have sudo, make sure `tmux`, `vim`, `zsh`, and `git` are already installed on your system before running `install_nosudo.sh`. Ask your admin if they're not available.

### Config files

| File | What it does |
|------|-------------|
| `zshrc` | Starship prompt, autosuggestions, syntax highlighting, fzf, zoxide, nvm, aliases |
| `starship.toml` | Starship config with Catppuccin Mocha palette |
| `tmux.conf` | Ctrl-a prefix, vim navigation, resurrect + continuum (session persistence) |
| `init.vim` | vim-plug (Catppuccin Mocha + coc.nvim), LSP navigation (`gd`, `K`, `gf`), sane defaults, spell check |
| `CHEATSHEET.md` | Key bindings and aliases reference — view with `glow -p CHEATSHEET.md` |
| `cheatsheets/` | Individual cheatsheets for tmux, vim, zsh, and tools (vim.md includes LSP shortcuts) |

## Neovim Language Server (LSP) Setup

Neovim includes **coc.nvim** with LSP support for code navigation and diagnostics.

### Installation

```vim
:PlugInstall           " Install coc.nvim plugin
:CocInstall coc-clangd " Install C/C++ language server (or swap for coc-python, coc-tsserver, etc.)
```

### Usage

- `K` over a function → Show signature + docs
- `gd` → Jump to definition
- `gf` → Find references
- `<leader>o` → Show functions/symbols outline
- `<leader>cn` / `<leader>cp` → Next/previous error

See `cheatsheets/vim.md` for full LSP shortcuts.

## Theme

All tools use **Catppuccin Mocha** for a unified color scheme.

| App | How it's applied |
|-----|-----------------|
| GNOME Terminal | Install script: `python3 install.py` from [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal), then select Mocha profile in Preferences |
| tmux | `catppuccin/tmux` plugin via TPM — install with `prefix + I` |
| neovim | `catppuccin/vim` plugin via vim-plug — auto-installs on first launch |
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
| **LSP (requires coc.nvim + language server)** | |
| `gd` | Go to definition |
| `gf` | Find references |
| `K` | Show function signature / hover docs |
| `<leader>o` | Show outline |
| `<leader>cn/cp` | Next/prev diagnostic |

## Machine-specific overrides

Create `~/.zshrc.local` for anything that shouldn't be committed (API keys, machine-specific paths, etc). It's sourced automatically.

## Updating

```bash
cd ~/setup_workspace
git pull
# Re-run install.sh if new dependencies were added
```

`install.sh` symlinks config files into their standard locations (`~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/init.vim`), pointing them back into this repo. Edits here are live immediately — no copy step needed. Reload with `source ~/.zshrc` or tmux `prefix + r`.
