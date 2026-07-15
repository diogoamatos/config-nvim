-- ~/.config/nvim/lua/keymaps.lua
-- ============================================================
-- SECTION 2: KEYMAPS
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local s = { silent = true }

keymap({ "n", "v" }, "<space>", "<Nop>")
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})
keymap("n", "<F4>", vim.diagnostic.setloclist, { desc = "Diagnostics [Q]uickfix list" })

-- Navigation and window behavior:
keymap("n", "<leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
-- keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- -- Word wrap, movement, and buffer behavior
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down.", noremap = true, silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up.", noremap = true, silent = true })
keymap("n", "J", "mzJ`z", { desc = "Joins current line with line below " })
keymap("n", "<C-s>", "<cmd>w!<CR>", { desc = "Save current file." })
-- keymap("v", "<C-p>", '"_dP')    -- Paste w/o overwriting register
keymap("x", "y", [["+y]], s) -- Yank to the system clipboard in visual mode
keymap("n", "<C-d>", "<C-d>zz") -- Scroll and center the cursor
keymap("n", "<C-u>", "<C-u>zz")

-- LSP keymaps
-- keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP Definitions", noremap = true, silent = true })

-- Scrach
keymap("n", "<leader>st", "<cmd>silent! ChknToggle<CR>", { desc = "Toggle scrach buffers." })

-- Notify
keymap({ "n", "i", "x", "v", "s", "t" }, "<C-l>", function()
	require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all Notifications" })
