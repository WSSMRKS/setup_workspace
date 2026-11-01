# Cheatsheets

Quick reference for your terminal toolkit. Pick what you need:

- **[claude](cheatsheets/claude.md)** — Claude Code CLI keybindings and commands
- **[tmux](cheatsheets/tmux.md)** — session, window, and pane management
- **[nvim](cheatsheets/vim.md)** — navigation, editing, spell check
- **[zsh](cheatsheets/zsh.md)** — shell shortcuts, aliases, functions
- **[tools](cheatsheets/tools.md)** — glow and other utilities

---

> [!IMPORTANT]
> **Can't select text with the mouse in tmux? Hold `Shift` while dragging.**
> tmux has mouse mode on, so a plain drag copies to the clipboard via `wl-copy` and the highlight disappears on release. If `wl-copy` isn't working, nothing gets copied. `Shift` + drag uses the terminal's own selection instead (copy with `Ctrl+Shift+C`), which works regardless. Details in [tmux](cheatsheets/tmux.md#copy-mode-scroll--select-text).

---

## First time setup

After cloning the repo and running `./install.sh`, do these steps once:

### 1. Set zsh as your default shell

```bash
chsh -s $(which zsh)
```

### 2. Tell GNOME Terminal to use it

GNOME Terminal ignores the system shell by default.

Open **Edit → Preferences → (your profile) → Command** and either:
- Enable **"Run command as a login shell"**, or
- Set **"Run a custom command"** to `/usr/bin/zsh`

### 3. Open a new terminal window

Oh My Zsh loads automatically. The Starship prompt starts immediately — no configuration wizard needed.

### 4. nvim plugins

The install scripts install them automatically (Catppuccin Mocha theme + coc.nvim). If the theme is missing when you open nvim, run `:PlugInstall` and reopen nvim.

### 4b. Install language servers for coc.nvim (optional but recommended)

For C/C++ development:

```vim
:CocInstall coc-clangd
```

For other languages, use `:CocInstall coc-<language>` (e.g., `coc-python`, `coc-tsserver` for TypeScript).

### 5. tmux plugins

The install scripts install them automatically (Catppuccin theme, session persistence, yank, etc). If tmux was already running during the install, reload it with `tmux source ~/.tmux.conf`.

To install manually: `Ctrl-a + I` (**capital** i) inside tmux, or `~/.tmux/plugins/tpm/bin/install_plugins` from the shell. If the key does nothing, see the plugins section in [tmux](cheatsheets/tmux.md).

### 6. Verify everything works

| Check | Command |
|-------|---------|
| Correct shell | `echo $SHELL` → should show `/usr/bin/zsh` |
| Starship loaded | Prompt should show git branch, language versions |
| zoxide working | `cd` into a few dirs, then try `cd <partial>` |
| glow installed | `glow CHEATSHEET.md` |
| Node.js installed | `node --version` → should show v24.x or higher |
| nvim plugins | Catppuccin colors in nvim; `ls ~/.local/share/nvim/plugged` → `catppuccin coc.nvim` |
| tmux plugins | `ls ~/.tmux/plugins` → tpm, tmux-sensible, tmux-resurrect, tmux-continuum, tmux-yank, tmux |
| Clipboard | `echo hello \| wl-copy && wl-paste` → `hello` (Wayland); in nvim `:checkhealth provider` |
| nvim LSP ready | Open a C file, hover over a function with `K` (requires language server installed with `:CocInstall`) |
