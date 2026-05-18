# setup_workspace

Repeatable dev environment: Zsh + Oh My Zsh + Vim + tmux.

## Quick start

```bash
git clone git@github.com:WSSMRKS/setup_workspace.git ~/setup_workspace
cd ~/setup_workspace
chmod +x install.sh
./install.sh
```

Then follow the first time setup in `CHEATSHEET.md` — or view it directly:

```bash
glow -p CHEATSHEET.md
```

Short version:
1. `chsh -s $(which zsh)` — set zsh as default shell
2. In GNOME Terminal: **Edit → Preferences → Command → Run command as a login shell**
3. Open a new terminal window — Oh My Zsh loads
4. Run `p10k configure` to set up your prompt
5. Open tmux and press `Ctrl-a + I` to install plugins

## What's included

| File | What it does |
|------|-------------|
| `install.sh` | Installs packages, Oh My Zsh, plugins, zoxide, TPM, glow, symlinks dotfiles |
| `.zshrc` | Powerlevel10k, autosuggestions, syntax highlighting, fzf, zoxide, aliases |
| `.tmux.conf` | Ctrl-a prefix, vim navigation, resurrect + continuum (session persistence) |
| `.vimrc` | Zero-dependency vanilla vim config with sane defaults |
| `CHEATSHEET.md` | Key bindings and aliases reference — view with `glow -p CHEATSHEET.md` |

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
