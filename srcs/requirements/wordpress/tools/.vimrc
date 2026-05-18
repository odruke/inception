" =========================
" WORDPRESS / PHP-FPM
" =========================

set nocompatible
syntax on
filetype plugin indent on

set number
set relativenumber

set autoindent
set smartindent

set wildmenu
set wildmode=longest:full,full

set completeopt=menuone,noinsert,noselect

set ignorecase
set smartcase

set incsearch
set hlsearch

set backspace=indent,eol,start

set ruler
set showcmd

set colorcolumn=120

" =========================
" PHP
" =========================

autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType php setlocal commentstring=//\ %s

" =========================
" HTML / CSS / JS
" =========================

autocmd FileType html,css,javascript setlocal ts=2 sts=2 sw=2 expandtab

" =========================
" JSON / YAML / ENV
" =========================

autocmd FileType json,yaml setlocal ts=2 sts=2 sw=2 expandtab

" =========================
" WORDPRESS
" =========================

" Resaltar trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Mostrar tabs
set list
set listchars=tab:>-,trail:.

" Mejor lectura
set scrolloff=5

colo pablo