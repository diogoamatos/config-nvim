-- ~/.config/nvim/lua/keymaps.lua
local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap({ "n", "v" }, "<space>", "<Nop>")

-- Remap for dealing with word wrap and movement
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down.", noremap = true, silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up.", noremap = true, silent = true })
keymap("n", "J", "mzJ`z", { desc = "Joins current line with line below " })

-- Scroll and center the cursor
-- keymap("n", "<C-d>", "<C-d>zz")
-- keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "<C-s>", "<cmd>w!<CR>", { desc = "Save current file." })
keymap("n", "<leader>q", "<cmd>q<CR>", s)      -- Quit Neovim
keymap("n", "<leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<leader>-", "<cmd>split<CR>", s)  -- Split the window horizontally
keymap("v", "<leader>p", '"_dP')               -- Paste without overwriting the default register
keymap("x", "y", [["+y]], s)                   -- Yank to the system clipboard in visual mode
keymap("t", "<Esc>", "<C-\\><C-N>")            -- Exit terminal mode
-- Change directory to the current file's directory
keymap("n", "<leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>')

-- LSP keymaps
local opts = { noremap = true, silent = true }
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "LSP Definitions", noremap = true, silent = true })
keymap("n", "grf", ":lua vim.lsp.buf.format()<CR>")

-- Fuzzy finders
keymap("n", "<leader><leader>", "<cmd>FzfLua files<CR>", { desc = "Find files." })
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Grep files." })
keymap("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "Show files history." })
keymap("n", "<leader>,", "<cmd>FzfLua buffers<CR>", { desc = "Show open buffers." })
keymap("n", "<leader>.", "<cmd>FzfLua keymaps<CR>", { desc = "Show keymaps." })

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>")

-- Tabs navigation
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
keymap("n", "<C-l>", "<cmd>tabnext<CR>")
keymap("n", "<C-h>", "<cmd>tabprev<CR>")

-- Scrach
keymap("n", "<leader>st", "<cmd>silent! ChknToggle<CR>", { desc = "Toggle scrach buffers." })

-- Notify
keymap({ 'n', 'i', 'x', 'v', 's', 't' }, "<C-l>",
    function()
        require("notify").dismiss({ silent = true, pending = true })
    end,
    { desc = "Dismiss all Notifications" }
)
