" plugins (managed with vim-plug)
call plug#begin('~/.vim/plugged')
" colors
Plug 'gruvbox-community/gruvbox'

" requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" search, fzf, picker, sorter
Plug 'nvim-telescope/telescope.nvim'

" more git actions
Plug 'tpope/vim-fugitive'

" treesitter syntax parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" undotree

call plug#end()
