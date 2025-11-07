return {
    { "mason-org/mason.nvim", opts = {} },
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "m4xshen/autoclose.nvim", opts = {} },
    { 'nvim-mini/mini.nvim', version = '*' },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { icons_enabled = true, theme = "material" },
    },
}
