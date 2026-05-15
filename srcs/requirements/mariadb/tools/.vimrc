" =========================
" MARIADB / SQL
" =========================

set nocompatible
syntax on
filetype plugin indent on

set number
set relativenumber

set nowrap
set colorcolumn=100

set autoindent
set smartindent

set ignorecase
set smartcase

set incsearch
set hlsearch

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

autocmd FileType sql setlocal commentstring=--\ %s

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Mejor navegación en dumps gigantes
set nowrap
set lazyredraw

" Mostrar tabs
set list
set listchars=tab:>-,trail:.
