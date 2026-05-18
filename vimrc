" ============================================
" Basics
" ============================================
set nocompatible
filetype plugin indent on
syntax on

set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set smartindent autoindent
set incsearch hlsearch ignorecase smartcase
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set cursorline
set mouse=a
set clipboard=unnamedplus
set splitbelow splitright
set hidden
set noswapfile nobackup nowritebackup
set updatetime=300
set timeoutlen=500
set encoding=utf-8
set termguicolors
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noselect
set shortmess+=c
set noshowmode              " status line handles this
set wrap linebreak          " soft wrap, don't break words

" Persistent undo (survives vim restarts)
set undofile
set undodir=~/.vim/undodir
silent! call mkdir(expand('~/.vim/undodir'), 'p')

" ============================================
" Leader
" ============================================
let mapleader=" "

" ============================================
" Navigation
" ============================================

" Window navigation (matches tmux)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :ls<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>tc :tabnew<CR>

" ============================================
" Editing
" ============================================

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered on search / join
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Don't lose register on paste in visual
xnoremap <leader>p "_dP

" Quick replace word under cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" ============================================
" Netrw (built-in file explorer)
" ============================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_altv = 1
nnoremap <leader>e :Lexplore<CR>

" ============================================
" Status line (no plugins needed)
" ============================================
set laststatus=2

function! GitBranch()
  let l:branch = system("git -C " . expand('%:p:h') . " rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branch) ? '  ' . l:branch . ' ' : ''
endfunction

set statusline=
set statusline+=\ %f                " file path
set statusline+=\ %m%r%h%w          " modified/readonly flags
set statusline+=%{GitBranch()}      " git branch
set statusline+=%=                  " right align
set statusline+=\ %y                " file type
set statusline+=\ %l:%c             " line:column
set statusline+=\ [%L]              " total lines
set statusline+=\ %p%%\             " percentage

" ============================================
" File type settings
" ============================================

" C / C++ (42 style: tabs, 4-wide)
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 noexpandtab

" Web (2-space indent)
autocmd FileType javascript,typescript,typescriptreact,json,html,css,yaml
  \ setlocal tabstop=2 shiftwidth=2 expandtab

" Makefiles need tabs
autocmd FileType make setlocal noexpandtab

" Markdown
autocmd FileType markdown setlocal spell spelllang=en_us,de wrap linebreak

" ============================================
" Quality of life
" ============================================

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Highlight yanked text briefly
if exists('##TextYankPost')
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})
endif

" Auto-create parent directories on save
autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')

" ============================================
" Quickfix navigation
" ============================================
nnoremap <leader>cn :cnext<CR>zz
nnoremap <leader>cp :cprev<CR>zz
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
