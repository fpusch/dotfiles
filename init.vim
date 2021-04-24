" search subdirectories by default
set path+=**

" tabs and indents
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" source any local rc
set exrc

" line numbers
set relativenumber
set number
set nowrap

" search
set nohlsearch

" stop ringing
set noerrorbells

" keep buffers open
set hidden

" undo things
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
set termguicolors

set scrolloff=8

set signcolumn=yes

" more space for commands
set cmdheight=2

" plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'
call plug#end()

" colors
colorscheme gruvbox
highlight Normal guibg=none

" remaps
