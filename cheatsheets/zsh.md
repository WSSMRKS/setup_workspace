# zsh Cheatsheet

## Shell shortcuts (built-in)

| Key | What it does |
|-----|-------------|
| `Ctrl-r` | Search command history (fzf-powered) |
| `Ctrl-t` | Fuzzy search files and insert path |
| `Alt-c` | Fuzzy search directories and cd into one |
| `Tab` | Autocomplete (press twice for menu) |
| `Ctrl-Space` | Accept autosuggestion |
| `→` (right arrow) | Accept autosuggestion (alternate) |
| `Ctrl-l` | Clear screen |

## Job control (background / foreground)

| Key / Command | What it does |
|---------------|-------------|
| `Ctrl+Z` | Suspend current foreground process |
| `bg` | Resume suspended job in background |
| `fg` | Bring most recent background job to foreground |
| `fg %2` | Bring job #2 to foreground |
| `jobs` | List all background/suspended jobs |
| `cmd &` | Start command directly in background |
| `kill %1` | Kill job #1 by job number |
| `disown %1` | Detach job — survives terminal close |
| `nohup cmd &` | Run immune to hangup signals (survives logout) |

## Navigation

| Command | What it does |
|---------|-------------|
| `cd <partial>` | Smart cd via zoxide — learns frequent paths |
| `..` | Go up one directory |
| `...` | Go up two directories |
| `mkcd <name>` | Create directory and cd into it |

## Aliases — general

| Alias | Expands to |
|-------|-----------|
| `ll` | `ls -lah` (detailed list with hidden files) |
| `la` | `ls -A` (hidden files, no detail) |
| `cls` | `clear` |
| `reload` | `source ~/.zshrc` |

## Aliases — quick config editing

| Alias | What it opens |
|-------|--------------|
| `ezsh` | Edit `.zshrc` in vim |
| `etmux` | Edit `.tmux.conf` in vim |
| `evim` | Edit `.vimrc` in vim |

## Aliases — git

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

## Aliases — tmux

| Alias | Expands to |
|-------|-----------|
| `tn <name>` | `tmux new -s <name>` |
| `ta <name>` | `tmux attach -t <name>` |
| `tl` | `tmux list-sessions` |
| `tk <name>` | `tmux kill-session -t <name>` |

## Aliases — docker

| Alias | Expands to |
|-------|-----------|
| `dc` | `docker compose` |
| `dcu` | `docker compose up -d` |
| `dcd` | `docker compose down` |
| `dcl` | `docker compose logs -f` |
| `dps` | `docker ps` (formatted) |

## Functions

| Command | What it does |
|---------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `psg <name>` | Find a running process by name |
| `serve [port]` | Start a local HTTP server (default port 8000) |
