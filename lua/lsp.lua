vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

local ensure_installed = {
    "pyright",
    "lua_ls",
    "isort",
    "black",
    "prettier",
    "djlint",
}

require("mason").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed})

require('mason-lspconfig').setup({})

vim.diagnostic.config({ virtual_text = true })
