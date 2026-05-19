" =========================
" GENERAL
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

set backspace=indent,eol,start

set nowrap
set ruler
set showcmd

set ignorecase
set smartcase

set incsearch
set hlsearch

set mouse=

" =========================
" WHITESPACE
" =========================

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" =========================
" TABS
" =========================

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" =========================
" PERFORMANCE
" =========================

set lazyredraw
set ttyfast
