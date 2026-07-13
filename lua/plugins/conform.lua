vim.pack.add { "https://github.com/stevearc/conform.nvim" }

require("conform").setup({
    default_format_opts = {
        lsp_format = 'fallback',
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettier", stop_after_first = true },
        html = { "djlint", "prettier" },
        jinja = { "djlint" },
        htmldjango = { "djlint" },
    },
    format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
    },
})

vim.keymap.set("n", "<Leader>ff", function() require('conform').format({ async = true, lsp_fallback = true }) end)
