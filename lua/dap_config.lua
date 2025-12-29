vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap-python" },
})
-- Global keymaps (normal mode)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Dap Continue" })
vim.keymap.set('n', '<F6>', function() require('dap').disconnect({ terminateDebuggee = true }) end, { desc = "Dap Disconnect" })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Dap Step Over" })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Dap Step Into" })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Dap Step Out" })
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Dap Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Dap Set Conditional Breakpoint" })
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "Dap Open REPL" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = "Dap Run Last" })

-- Keymaps for visual mode (evaluating selected text)
vim.keymap.set('v', '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = "Dap Hover (Visual)" })
vim.keymap.set('v', '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { desc = "Dap Preview (Visual)" })

require("dap-python").setup("python3")
