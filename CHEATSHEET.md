# Cheatsheets

Quick reference for your terminal toolkit. Pick what you need:

- **[tmux](cheatsheets/tmux.md)** — session, window, and pane management
- **[vim](cheatsheets/vim.md)** — navigation, editing, spell check
- **[zsh](cheatsheets/zsh.md)** — shell shortcuts, aliases, functions
- **[tools](cheatsheets/tools.md)** — glow and other utilities

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

### 4. Install vim plugins

Open vim and run:

```
:PlugInstall
```

This installs the Catppuccin Mocha theme. Close and reopen vim after it finishes.

### 5. Install tmux plugins

Open tmux, then press `Ctrl-a + I` (capital i). This downloads and installs the plugins defined in `tmux.conf` (Catppuccin theme, session persistence, yank, etc). Only needed once.

### 6. Verify everything works

| Check | Command |
|-------|---------|
| Correct shell | `echo $SHELL` → should show `/usr/bin/zsh` |
| Starship loaded | Prompt should show git branch, language versions |
| zoxide working | `cd` into a few dirs, then try `cd <partial>` |
| glow installed | `glow CHEATSHEET.md` |
