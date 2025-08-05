return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {"c", "lua", "python", "html", "tsx", "javascript", "tsx", "css"}, 
        highlight = {
            enable = true,
        },
    },
    keys = {
        { '<c-space>', desc = 'Increment Selection' },
        { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    }
}
