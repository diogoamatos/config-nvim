vim.pack.add({
    { src = "https://github.com/navarasu/onedark.nvim" },
})
require("onedark").setup({
    style = 'warm',
})

vim.cmd.colorscheme("onedark")
