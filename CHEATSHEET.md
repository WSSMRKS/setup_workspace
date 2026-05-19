# Terminal Cheatsheet

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

Oh My Zsh should now load automatically. If it asks you to configure Powerlevel10k, follow the prompts — or run it manually any time:

```bash
p10k configure
```

### 4. Install tmux plugins

Open tmux, then press `Ctrl-a + I` (capital i). This downloads and installs the plugins defined in `.tmux.conf` (session persistence, yank, etc). Only needed once.

### 5. Verify everything works

| Check | Command |
|-------|---------|
| Correct shell | `echo $SHELL` → should show `/usr/bin/zsh` |
| Oh My Zsh loaded | Prompt should show Powerlevel10k theme |
| zoxide working | `cd` into a few dirs, then try `cd <partial>` |
| glow installed | `glow CHEATSHEET.md` |

---

## tmux

### The mental model

tmux has three levels:

```
Session  →  one "workspace" (e.g. a project)
  Window   →  like a browser tab inside that session
    Pane     →  a split inside a window (this is the tiling)
```

You can have multiple sessions running at the same time. Detaching from a session leaves everything running in the background — you can reattach later.

**Prefix key: `Ctrl-a`** — press this first before any tmux shortcut below.

### Sessions

| Command | What it does |
|---------|-------------|
| `tn <name>` | New session named `<name>` (shell alias) |
| `ta <name>` | Attach to session (shell alias) |
| `tl` | List sessions (shell alias) |
| `tk <name>` | Kill session (shell alias) |
| `prefix + d` | Detach (leave session running in background) |
| `prefix + $` | Rename current session |
| `prefix + s` | List sessions + windows interactively (switch between sessions) |

### Windows (tabs)

| Key | What it does |
|-----|-------------|
| `prefix + c` | New window (opens in current directory) |
| `prefix + w` | List all windows interactively (navigate + switch) |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + <number>` | Jump to window by number |
| `prefix + ,` | Rename current window |
| `prefix + &` | Kill current window |

### Panes (tiling / splits)

This is where the screen splitting happens.

| Key | What it does |
|-----|-------------|
| `prefix + \|` | Split vertically (side by side) |
| `prefix + -` | Split horizontally (top and bottom) |
| `prefix + h/j/k/l` | Move between panes (vim-style: left/down/up/right) |
| `prefix + Ctrl-h/j/k/l` | Resize pane (hold and repeat) |
| `prefix + >` | Swap pane with next |
| `prefix + <` | Swap pane with previous |
| `prefix + x` | Kill current pane |
| `prefix + z` | Zoom pane to full screen (toggle) |
| Mouse click | Focus a pane (mouse is enabled) |

### Copy mode (scroll + select text)

| Key | What it does |
|-----|-------------|
| `prefix + Enter` | Enter copy mode (lets you scroll up) |
| `v` | Start selection (in copy mode) |
| `y` | Yank (copy) selection to clipboard |
| `Escape` | Exit copy mode |
| Arrow keys / `h/j/k/l` | Scroll and move in copy mode |

### Plugins (session persistence)

Sessions are auto-saved every 15 minutes and restored on tmux start.

| Key | What it does |
|-----|-------------|
| `prefix + Ctrl-s` | Save session manually |
| `prefix + Ctrl-r` | Restore session manually |
| `prefix + I` | Install plugins (first time setup) |
| `prefix + U` | Update plugins |
| `prefix + r` | Reload tmux config |

---

## vim

### Modes — the core concept

vim is modal: keys do different things depending on which mode you're in.

| Mode | How to enter | What it's for |
|------|-------------|---------------|
| **Normal** | `Escape` | Navigate, run commands — this is home base |
| **Insert** | `i` | Type text |
| **Visual** | `v` | Select text |
| **Visual line** | `V` | Select whole lines |
| **Command** | `:` | Run commands like save, quit, search/replace |

**Leader key: `Space`**

### Getting in and out

| Key | What it does |
|-----|-------------|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below, insert |
| `O` | New line above, insert |
| `Escape` | Back to normal mode |
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>Q` | Quit all without saving |
| `:wq` | Save and quit |

### Navigation (normal mode)

| Key | What it does |
|-----|-------------|
| `h/j/k/l` | Left / down / up / right |
| `w` | Jump forward one word |
| `b` | Jump back one word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `Ctrl-d` | Scroll down half page |
| `Ctrl-u` | Scroll up half page |
| `/<term>` | Search forward |
| `n` / `N` | Next / previous search result (centered) |
| `<leader><space>` | Clear search highlight |

### Editing

| Key | What it does |
|-----|-------------|
| `dd` | Delete (cut) line |
| `yy` | Yank (copy) line |
| `p` | Paste below |
| `P` | Paste above |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `ciw` | Change word under cursor |
| `J` / `K` (visual) | Move selected lines down / up |
| `<leader>p` (visual) | Paste without losing register |
| `<leader>r` | Replace all occurrences of word under cursor |

### Splits and windows

| Key | What it does |
|-----|-------------|
| `:sp` | Split horizontally |
| `:vsp` | Split vertically |
| `Ctrl-h/j/k/l` | Navigate splits (matches tmux) |

### Buffers (open files)

| Key | What it does |
|-----|-------------|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>bl` | List open buffers |

### File explorer

| Key | What it does |
|-----|-------------|
| `<leader>e` | Toggle file explorer sidebar |
| `Enter` | Open file / expand folder |
| `-` | Go up a directory |

---

## zsh

### Shell shortcuts (built-in)

| Key | What it does |
|-----|-------------|
| `Ctrl-r` | Search command history (fzf-powered) |
| `Ctrl-t` | Fuzzy search files and insert path |
| `Alt-c` | Fuzzy search directories and cd into one |
| `Tab` | Autocomplete (press twice for menu) |
| `→` (right arrow) | Accept autosuggestion |
| `Ctrl-l` | Clear screen |

### Navigation

| Command | What it does |
|---------|-------------|
| `cd <partial>` | Smart cd via zoxide — learns frequent paths |
| `..` | Go up one directory |
| `...` | Go up two directories |
| `mkcd <name>` | Create directory and cd into it |

### Aliases — general

| Alias | Expands to |
|-------|-----------|
| `ll` | `ls -lah` (detailed list with hidden files) |
| `la` | `ls -A` (hidden files, no detail) |
| `cls` | `clear` |
| `reload` | `source ~/.zshrc` |

### Aliases — quick config editing

| Alias | What it opens |
|-------|--------------|
| `ezsh` | Edit `.zshrc` in vim |
| `etmux` | Edit `.tmux.conf` in vim |
| `evim` | Edit `.vimrc` in vim |

### Aliases — git

| Alias | Expands to |
|-------|-----------|
| `gs` | `git status` |
| `gd` | `git diff` |
| `gds` | `git diff --staged` |
| `gl` | `git log --oneline --graph -20` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gco` | `git checkout` |
| `gb` | `git branch` |
| `gst` | `git stash` |

### Aliases — tmux

| Alias | Expands to |
|-------|-----------|
| `tn <name>` | `tmux new -s <name>` |
| `ta <name>` | `tmux attach -t <name>` |
| `tl` | `tmux list-sessions` |
| `tk <name>` | `tmux kill-session -t <name>` |

### Aliases — docker

| Alias | Expands to |
|-------|-----------|
| `dc` | `docker compose` |
| `dcu` | `docker compose up -d` |
| `dcd` | `docker compose down` |
| `dcl` | `docker compose logs -f` |
| `dps` | `docker ps` (formatted) |

### Functions

| Command | What it does |
|---------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `psg <name>` | Find a running process by name |
| `serve [port]` | Start a local HTTP server (default port 8000) |

---

## glow — markdown viewer

| Command | What it does |
|---------|-------------|
| `glow <file.md>` | Render a markdown file |
| `glow -p <file.md>` | Render with pager (scrollable, press `q` to quit) |
| `glow .` | Browse all markdown files in current directory |
