" plugins (managed with vim-plug)
call plug#begin('~/.vim/plugged')

" colors
Plug 'gruvbox-community/gruvbox'

" icons
Plug 'kyazdani42/nvim-web-devicons'

" statusline
Plug 'hoob3rt/lualine.nvim'

" requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" search, fzf, picker, sorter
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" more git actions
Plug 'tpope/vim-fugitive'

" treesitter syntax parsing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" undotree

call plug#end()
