-- treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cpp" , "css", "go", "graphql", "html", "java", "javascript", "json", "latex", "regex", "rust", "typescript", "yaml" } ,
    ignore_install = { },
    highlight = {
        enable = true,
        disable = { },
    },
}
