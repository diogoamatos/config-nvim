vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

local ensure_installed = {
	"pyright",
	"lua_ls",
	"isort",
	"black",
	"prettier",
	"djlint",
}

require("mason").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
require("mason-lspconfig").setup({})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettier", stop_after_first = true },
		html = { "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_format = "fallback",
		timeout_ms = 500,
	},
})

vim.diagnostic.config({ virtual_text = true })
