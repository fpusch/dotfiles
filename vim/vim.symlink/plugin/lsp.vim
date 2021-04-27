" neovim lsp

" don't autocomplete without confirm
set completeopt=menuone,noinsert,noselect

" add fuzzy search
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" languages
" typescript (run `npm i -g typescript typescript-language-server`)
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
