# vim Cheatsheet

## Modes — the core concept

vim is modal: keys do different things depending on which mode you're in.

| Mode | How to enter | What it's for |
|------|-------------|---------------|
| **Normal** | `Escape` | Navigate, run commands — this is home base |
| **Insert** | `i` | Type text |
| **Visual** | `v` | Select text |
| **Visual line** | `V` | Select whole lines |
| **Command** | `:` | Run commands like save, quit, search/replace |

**Leader key: `Space`**

## Getting in and out

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

## Navigation (normal mode)

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

## Editing

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

## Spell checking

| Key | What it does |
|-----|-------------|
| `z=` | Show spell suggestions for word under cursor |
| `]s` | Jump to next misspelled word |
| `[s` | Jump to previous misspelled word |
| `zg` | Add word to dictionary (mark as correct) |
| `zw` | Mark word as incorrect |

## Splits and windows

| Key | What it does |
|-----|-------------|
| `:sp` | Split horizontally |
| `:vsp` | Split vertically |
| `Ctrl-h/j/k/l` | Navigate splits (matches tmux) |

## Buffers (open files)

| Key | What it does |
|-----|-------------|
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Close buffer |
| `<leader>bl` | List open buffers |

## File explorer

| Key | What it does |
|-----|-------------|
| `<leader>e` | Toggle file explorer sidebar |
| `Enter` | Open file / expand folder |
| `-` | Go up a directory |

## Language Server (LSP) — coc.nvim

Requires coc.nvim plugin and language servers installed. For C/C++, install with `:CocInstall coc-clangd`.

| Key | What it does |
|-----|-------------|
| `gd` | Go to definition |
| `gf` | Find references |
| `K` | Show function signature / hover documentation |
| `<leader>o` | Show outline (functions, variables) |
| `<leader>cn` | Next diagnostic |
| `<leader>cp` | Previous diagnostic |
| `<leader>co` | Open diagnostics list |
| `<leader>cc` | Close diagnostics list |

## Example: C function lookup

```c
print_error("hello");  // Cursor on 'print_error'
K                      // Shows: print_error(char *str) — print error message
gd                     // Jump to definition in another file
Ctrl-t                 // Jump back to original location
```
