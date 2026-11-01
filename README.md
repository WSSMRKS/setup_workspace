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

### Option 3: Headless server (e.g. Raspberry Pi)

Lean, apt-only setup: zsh, tmux, Neovim, ripgrep, fzf, fd plus symlinks. No Oh My Zsh, Starship, Node/nvm, coc.nvim, third-party apt repos or `curl | sh` installers. Neovim uses `init.server.vim` (same keymaps and defaults, no plugins).

```bash
git clone https://github.com/WSSMRKS/setup_workspace.git ~/setup_workspace
~/setup_workspace/install_server.sh
```

Log out and back in. tmux plugins are installed by the script.

Then follow the first time setup in `CHEATSHEET.md`:

```bash
glow -p CHEATSHEET.md
```

Short version:
1. `chsh -s $(which zsh)` — set zsh as default shell
2. In GNOME Terminal: **Preferences → select Catppuccin Mocha profile → set as default**
3. Open a new terminal — Starship prompt loads automatically and nvm initializes
4. In nvim, run `:CocInstall coc-clangd` for C/C++ language server support
5. If tmux was running during the install, reload it: `tmux source ~/.tmux.conf`

The install scripts install the nvim plugins (`:PlugInstall`) and tmux plugins (TPM) automatically — no manual step needed.

## What's included

### Install scripts

| Script | What it does | Requires sudo |
|--------|-------------|---------------|
| `install.sh` | System packages (tmux, neovim, zsh, git, btop, clipboard tools `wl-clipboard` + `xclip`), Oh My Zsh plugins, Starship, TPM, theme files, nvim + tmux plugins | Yes |
| `install_server.sh` | Lean headless-server setup: apt packages, TPM + tmux plugins, symlinks (uses `init.server.vim`) | Yes |
| `install_nosudo.sh` | User-level tools (neovim, ripgrep, fd, fzf, glow, zoxide, nvm + Node.js v24), symlinks dotfiles, spell files, vim-plug, nvim + tmux plugins | No |

**Note:** If you don't have sudo, make sure `tmux`, `vim`, `zsh`, and `git` are already installed on your system before running `install_nosudo.sh`. Ask your admin if they're not available. For the system clipboard you'll also need `wl-clipboard` (Wayland) or `xclip` (X11) — the script warns if both are missing.

**Not installed by any script:** `norminette`, `valgrind`, `docker`. Install them yourself if you use the matching aliases (`norm`, `val`, `dc*`, `dps`).

### Config files

| File | What it does |
|------|-------------|
| `zshrc` | Starship prompt, autosuggestions, syntax highlighting, fzf, zoxide, nvm, aliases |
| `starship.toml` | Starship config with Catppuccin Mocha palette |
| `tmux.conf` | Ctrl-a prefix, vim navigation, resurrect + continuum (session persistence) |
| `init.server.vim` | Plugin-free variant of `init.vim` for servers |
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
| tmux | `catppuccin/tmux` plugin via TPM — installed by the install scripts (manually: `prefix + I`) |
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
| `Enter` | Copy mode (vi keys) — `v` select, `y` yank selection, `Y` yank current line (to system clipboard) |
| `]` | Paste tmux buffer (system clipboard: `Ctrl+Shift+V`) |
| *(mouse)* | Drag = copy to clipboard, highlight clears on release. **`Shift` + drag = terminal's own selection** (`Ctrl+Shift+C`), works even if `wl-copy` is broken |
| `I` | Install plugins (capital i) |

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

## Troubleshooting

| Problem | Fix |
|---------|-----|
| nvim has no colors / coc not loaded | Plugins missing: `nvim +PlugInstall +qa` |
| tmux plugins missing, `prefix + I` does nothing | It's capital `I`. If still nothing, the running server predates TPM: `tmux source ~/.tmux.conf`. Or install from the shell: `~/.tmux/plugins/tpm/bin/install_plugins` |
| Mouse highlight in tmux disappears on release / can't copy with the mouse | Expected: tmux mouse mode copies on release (via `wl-copy`) and exits copy mode. **Hold `Shift` while dragging** to use the terminal's own selection, then `Ctrl+Shift+C`. Works even when `wl-copy` doesn't |
| `y` in tmux copy mode copies nothing | `y` needs a selection (`v` or `V` first). Use `Y` to yank the current line |
| Yank doesn't reach the system clipboard | Install `wl-clipboard` (Wayland) or `xclip` (X11). Test: `echo hello \| wl-copy && wl-paste`. In nvim: `:checkhealth provider`. Reload tmux after config changes (`prefix + r`) |

## Machine-specific overrides

Create `~/.zshrc.local` for anything that shouldn't be committed (API keys, machine-specific paths, etc). It's sourced automatically.

## Updating

```bash
cd ~/setup_workspace
git pull
# Re-run install.sh if new dependencies were added
```

`install.sh` symlinks config files into their standard locations (`~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/init.vim`), pointing them back into this repo. Edits here are live immediately — no copy step needed. Reload with `source ~/.zshrc` or tmux `prefix + r`.
