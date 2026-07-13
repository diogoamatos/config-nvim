vim.pack.add({
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
    -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
})
require("neo-tree").setup({
    filesystem = {
        follow_current_file = {
            enabled = true,
            Leave_open = false,
        },
    },
    event_handlers = {
        {
            event = "file_open_requested",
            handler = function()
                require("neo-tree.command").execute({ action = "close" })
            end
        }
    }
})
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
