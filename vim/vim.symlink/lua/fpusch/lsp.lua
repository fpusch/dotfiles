-- lsp server setup goes here
local function on_attach()
    -- dummy on_attach for now
end

-- languages
-- typescript (run `npm i -g typescript typescript-language-server`)
require'lspconfig'.tsserver.setup{}
