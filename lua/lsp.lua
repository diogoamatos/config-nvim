vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    -- { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

require('mason-lspconfig').setup({})
vim.lsp.enable({
    "bashls",
    "lua_ls",
    "pyright",
    "ts_ls",
})
vim.diagnostic.config({ virtual_text = true })
