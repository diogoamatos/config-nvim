return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {"c", "lua", "python", "html"}
        })
    end,
}
