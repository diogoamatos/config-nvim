return {
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "mason-org/mason.nvim", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { icons_enabled = true, theme = "material" },
	},
	{ "m4xshen/autoclose.nvim", opts = {} },
}
