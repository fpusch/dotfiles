-- languages
-- typescript (run `npm i -g typescript typescript-language-server`)
require'lspconfig'.tsserver.setup{}

-- haskell (requires haskell-language-server from anywhere)
require'lspconfig'.hls.setup{}
