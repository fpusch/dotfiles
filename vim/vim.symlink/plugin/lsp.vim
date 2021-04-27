" neovim lsp
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" don't autocomplete without confirm
set completeopt=menuone,noinsert,noselect

" no extra messages
set shortmess+=c

" add fuzzy search
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" languages
" typescript (run `npm i -g typescript typescript-language-server`)
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
