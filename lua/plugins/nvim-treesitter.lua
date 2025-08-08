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
        auto_install = true,
        additional_vim_regex_highlighting = true,
    },
    keys = {
        { '<c-space>', desc = 'Increment Selection' },
        { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    }
}
