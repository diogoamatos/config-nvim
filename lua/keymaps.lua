-- ~/.config/nvim/lua/keymaps.lua
local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap({ "n", "v" }, "<space>", "<Nop>")

-- Remap for dealing with word wrap and movement
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("n", "J", "mzJ`z")

-- Scroll and center the cursor
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "<C-s>", "<cmd>w!<CR>", s) -- Save the current file
keymap("n", "<Leader>q", "<cmd>q<CR>", s) -- Quit Neovim
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<Leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
keymap("v", "<Leader>p", '"_dP') -- Paste without overwriting the default register
keymap("x", "y", [["+y]], s) -- Yank to the system clipboard in visual mode
keymap("t", "<Esc>", "<C-\\><C-N>") -- Exit terminal mode
-- Change directory to the current file's directory
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

-- LSP keymaps
local opts = { noremap = true, silent = true }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>")

-- Fuzzy finders
keymap("n", "<leader><leader>", "<cmd>FzfLua files<CR>")
keymap("n", "<leader>/", "<cmd>FzfLua live_grep<CR>")

-- Miniharp
keymap("n", "<leader>m", '<cmd>lua require("miniharp").toggle_file()<CR>')
keymap("n", "<leader>l", '<cmd>lua require("miniharp").show_list()<CR>')
keymap("n", "<C-n>", require("miniharp").next)
keymap("n", "<C-p>", require("miniharp").prev)

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- Tabs navigation
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
keymap("n", "<C-l>", "<cmd>tabnext<CR>")
keymap("n", "<C-h>", "<cmd>tabprev<CR>")
