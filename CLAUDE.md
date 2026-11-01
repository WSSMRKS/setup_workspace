# setup_workspace — Project Context

Unified developer environment with Zsh, Neovim, and tmux using Catppuccin Mocha theme.

## Key Configuration Decisions

### zsh-autosuggestions keybinding

**Problem:** Right arrow accepts autosuggestions, but no easy alternative existed without conflicting with existing bindings (Tab is autocomplete menu, Ctrl-r/t/l are fzf/clear).

**Solution:** Bound `Ctrl+Space` to accept autosuggestions via `zsh-autosuggestions`.

**File:** `zshrc` line ~119

**Why:** 
- Ergonomic and standard in many contexts (VSCode, readline)
- Doesn't conflict with existing fzf bindings or Tab autocomplete
- Allows accepting suggestions without reaching for the arrow key

Both `Ctrl+Space` and right arrow work now — use whichever feels natural.

### Clipboard (tmux + nvim)

**Setup:** tmux copy-mode `y`/`Y` pipe to `wl-copy || xclip -selection clipboard || pbcopy` (`tmux.conf` copy-mode section, mirrored in `@override_copy_command` for tmux-yank). nvim uses `clipboard=unnamedplus`. The user runs Wayland, so `wl-clipboard` is the real dependency; `xclip` is only the X11/XWayland fallback. `install.sh` installs both; `install_nosudo.sh` can't and only warns.

**tmux-yank gotcha:** tmux-yank binds its own copy-mode keys (`y`, `Y` = copy and paste to command line, `M-y`, `!`), and because TPM runs at the bottom of `tmux.conf`, its bindings override ours. Our `Y` (yank current line, no selection needed) only survives because `@copy_mode_put` is set to `'P'`. Don't remove or empty that option: tmux-yank treats an empty value as "use default" and takes `Y` back. The user is fine with `P` existing.

**Mouse selection:** `mouse on` means a drag is handled by tmux-yank's `MouseDragEnd1Pane` → `copy-pipe-and-cancel`: it copies via `wl-copy` and the highlight vanishes on release. If `wl-copy` is broken, mouse copying silently does nothing. `Shift` + drag bypasses tmux (terminal-native selection, `Ctrl+Shift+C`). The user wants this kept prominent in the docs (README, CHEATSHEET.md, cheatsheets/tmux.md).

**Testing tmux config:** use an isolated server (`tmux -L test -f ./tmux.conf new -d`, then `list-keys`, then `kill-server`) rather than the user's live server. A running server keeps old bindings until `prefix + r` / `tmux source ~/.tmux.conf`.

### Plugin installation

All three install scripts install plugins automatically: `nvim --headless +PlugInstall +qa` (not in `install_server.sh`, since `init.server.vim` has no plugins) and `~/.tmux/plugins/tpm/bin/install_plugins` (works without a running tmux server). `prefix + I` (capital) is only the manual fallback.

## File Structure

- `zshrc` — Starship prompt, plugins, aliases, functions, keybindings
- `starship.toml` — Prompt configuration with Catppuccin Mocha
- `tmux.conf` — Session management, plugins, vim navigation
- `init.vim` — vim-plug, coc.nvim (LSP), Catppuccin theme (symlinked to `~/.config/nvim/init.vim`)
- `CHEATSHEET.md` — Quick reference (view with `glow -p CHEATSHEET.md`)
- `cheatsheets/` — Individual guides for tmux, vim, zsh, tools

## Installation

See `README.md` for setup instructions. Key point: `install.sh` symlinks these files into `~/.config/` and `~`, so edits here are live immediately.
