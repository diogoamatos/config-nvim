vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap-python" },
})

require("dap-python").setup("python3")
