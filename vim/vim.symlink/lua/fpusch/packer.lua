-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "ellisonleao/gruvbox.nvim" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('tpope/vim-fugitive')
end)
