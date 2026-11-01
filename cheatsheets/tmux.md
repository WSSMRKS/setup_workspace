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
| Mouse drag | Select + copy to clipboard; highlight vanishes on release (see Copy mode). **`Shift` + drag** = normal terminal selection |

## Copy mode (scroll + select text)

> [!IMPORTANT]
> **Mouse selection: hold `Shift` while dragging.**
> With `mouse on`, tmux owns the mouse. A plain drag selects inside tmux, and on release it copies to the clipboard (via `wl-copy`) and **clears the highlight immediately**. That's expected, not a bug. But if `wl-copy` is broken or missing, the text goes nowhere and it looks like you can't copy at all.
>
> **`Shift` + drag** bypasses tmux and uses the terminal's own selection: the highlight stays, and `Ctrl+Shift+C` copies it, no `wl-copy` involved. This is the fallback that always works. (Downside: it doesn't know about panes, so it can select across a split.)

| Key | What it does |
|-----|-------------|
| `prefix + Enter` | Enter copy mode (lets you scroll up) |
| `v` | Start selection (in copy mode) |
| `V` | Select whole line |
| `y` | Yank (copy) selection to system clipboard — **does nothing without a selection** |
| `Y` | Yank the current line, no selection needed (like vim's `yy`) |
| `P` | Copy selection and paste it straight onto the command line (tmux-yank) |
| `Escape` | Exit copy mode |
| Arrow keys / `h/j/k/l` | Scroll and move in copy mode |

### Pasting

| Key | Pastes from |
|-----|-------------|
| `prefix + ]` | tmux's internal buffer (always works, even if the clipboard doesn't) |
| `Ctrl+Shift+V` | System clipboard (GNOME Terminal) — also works in other apps with `Ctrl+V` |

Yanked text goes to the **system clipboard** (not just tmux's internal buffer), so you can paste it into the browser or any GUI app with the normal paste shortcut. It tries `wl-copy` (Wayland), then `xclip` (X11), then `pbcopy` (macOS) — whichever is available. On Wayland install `wl-clipboard` (`install.sh` does this); `xclip` only works through XWayland.

Quick clipboard test outside tmux: `echo hello | wl-copy && wl-paste` should print `hello`.

If you edit the clipboard binding in `tmux.conf`, reload with `prefix + r` inside the running session — editing the file alone doesn't affect a session that's already open.

## Plugins (session persistence)

Sessions are auto-saved every 15 minutes and restored on tmux start.

| Key | What it does |
|-----|-------------|
| `prefix + Ctrl-s` | Save session manually |
| `prefix + Ctrl-r` | Restore session manually |
| `prefix + I` | Install plugins — capital `I` (`Shift+i`); the install scripts already do this |
| `prefix + U` | Update plugins |
| `prefix + Alt+u` | Remove plugins no longer listed in `tmux.conf` |
| `prefix + r` | Reload tmux config |

**`prefix + I` does nothing?** The binding only exists once the running tmux server has loaded TPM (the `run '~/.tmux/plugins/tpm/tpm'` line at the bottom of `tmux.conf`). If tmux was started before TPM was installed, reload with `tmux source ~/.tmux.conf` (or `tmux kill-server`). Or skip the key entirely and install from the shell — no running tmux needed:

```bash
~/.tmux/plugins/tpm/bin/install_plugins
```
