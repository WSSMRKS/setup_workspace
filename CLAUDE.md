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

## File Structure

- `zshrc` — Starship prompt, plugins, aliases, functions, keybindings
- `starship.toml` — Prompt configuration with Catppuccin Mocha
- `tmux.conf` — Session management, plugins, vim navigation
- `init.vim` — vim-plug, coc.nvim (LSP), Catppuccin theme (symlinked to `~/.config/nvim/init.vim`)
- `CHEATSHEET.md` — Quick reference (view with `glow -p CHEATSHEET.md`)
- `cheatsheets/` — Individual guides for tmux, vim, zsh, tools

## Installation

See `README.md` for setup instructions. Key point: `install.sh` symlinks these files into `~/.config/` and `~`, so edits here are live immediately.
