return {
	{
		"projekt0n/github-nvim-theme",
		-- "olimorris/onedark.nvim",
        name = 'github-theme',
		lazy = false,
		priority = 1000,
		config = function()
			require('github-theme').setup()

			vim.cmd("colorscheme github_dark")
			-- vim.cmd("colorscheme github_dark_default")
			-- vim.cmd("colorscheme onedark")
            -- require("onedark").load()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { icons_enabled = true, theme = "material" },
	},
}
