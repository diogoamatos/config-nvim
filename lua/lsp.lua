vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

local ensure_installed = {
    "isort",
    "black",
    "prettier",
    "djlint",
    "pyright",
    "lua_ls",
    "djlint",
}

require("mason-tool-installer").setup({ ensure_installed = ensure_installed})
require('mason-lspconfig').setup({})

vim.lsp.enable({
    "bashls",
    "lua_ls",
    "pyright",
    -- "ts_ls",
})
vim.diagnostic.config({ virtual_text = true })
