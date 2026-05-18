" =========================
" NGINX
" =========================

set nocompatible
syntax on
filetype plugin indent on

set number
set relativenumber

set autoindent
set smartindent

set nowrap

set ignorecase
set smartcase

set incsearch
set hlsearch

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set colorcolumn=80

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Logs más cómodos
autocmd BufRead *.log setlocal nowrap

" Config nginx
autocmd FileType nginx setlocal ts=4 sts=4 sw=4 expandtab

" Navegación
set ruler
set showcmd

" Mostrar tabs y trailing
set list
set listchars=tab:>-,trail:.