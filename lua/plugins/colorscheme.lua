return {
	-- 	"projekt0n/github-nvim-theme",
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			-- ...
		})

		-- vim.cmd("colorscheme github_dark_default")
		vim.cmd("colorscheme onedark")
	end,
}
