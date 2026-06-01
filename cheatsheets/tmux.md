# tmux Cheatsheet

## The mental model

tmux has three levels:

```
Session  →  one "workspace" (e.g. a project)
  Window   →  like a browser tab inside that session
    Pane     →  a split inside a window (this is the tiling)
```

You can have multiple sessions running at the same time. Detaching from a session leaves everything running in the background — you can reattach later.

**Prefix key: `Ctrl-a`** — press this first before any tmux shortcut below.

## Sessions

| Command | What it does |
|---------|-------------|
| `tn <name>` | New session named `<name>` (shell alias) |
| `ta <name>` | Attach to session (shell alias) |
| `tl` | List sessions (shell alias) |
| `tk <name>` | Kill session (shell alias) |
| `prefix + d` | Detach (leave session running in background) |
| `prefix + $` | Rename current session |
| `prefix + s` | List sessions + windows interactively (switch between sessions) |

## Windows (tabs)

| Key | What it does |
|-----|-------------|
| `prefix + c` | New window (opens in current directory) |
| `prefix + w` | List all windows interactively (navigate + switch) |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + <number>` | Jump to window by number |
| `prefix + ,` | Rename current window |
| `prefix + &` | Kill current window |

## Panes (tiling / splits)

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

## Copy mode (scroll + select text)

| Key | What it does |
|-----|-------------|
| `prefix + Enter` | Enter copy mode (lets you scroll up) |
| `v` | Start selection (in copy mode) |
| `y` | Yank (copy) selection to clipboard |
| `Escape` | Exit copy mode |
| Arrow keys / `h/j/k/l` | Scroll and move in copy mode |

## Plugins (session persistence)

Sessions are auto-saved every 15 minutes and restored on tmux start.

| Key | What it does |
|-----|-------------|
| `prefix + Ctrl-s` | Save session manually |
| `prefix + Ctrl-r` | Restore session manually |
| `prefix + I` | Install plugins (first time setup) |
| `prefix + U` | Update plugins |
| `prefix + r` | Reload tmux config |
