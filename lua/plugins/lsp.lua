return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim" },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						align = "top",
					},
				},
			},
		},

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
					},
				},
			},
			pyright = {
				settings = {
					python = {},
				},
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				},
			},
		},
	},
	config = function(_, opts)
		local ensure_installed = {
			"stylua",
			"isort",
			"black",
			"prettier",
			"djlint",
		}
        require('mason-lspconfig').setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			-- lspconfig[server].setup(config)
            vim.lsp.config(server, {
                opts[server]
            })
            vim.lsp.enable(server)
		end
	end,
}
