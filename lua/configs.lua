-- ~/.config/nvim/lua/configs.lua
--
-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Disable NetRW
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
--  See `:help vim.o`

vim.o.colorcolumn = "80"   -- Highlight column 80
vim.o.termguicolors = true -- Enable true colors
vim.o.swapfile = false     -- Disable swap files
-- vim.o.autoindent = true -- Enable auto indentation
vim.o.expandtab = true     -- Use spaces instead of tabs
vim.o.tabstop = 4          -- Number of spaces for a tab
vim.o.softtabstop = 4      -- Number of spaces for a tab when editing
vim.o.shiftwidth = 4       -- Number of spaces for autoindent
vim.o.shiftround = true    -- Round indent to multiple of shiftwidth
vim.o.list = true          -- Show whitespace characters
vim.o.number = true        -- Show line numbers
vim.o.numberwidth = 1      -- Width of the line number column

-- text wrap
-- opt.wrap = true
-- opt.linebreak = true
-- opt.textwidth = 0
-- opt.wrapmargin = 0

vim.o.smoothscroll = true
vim.opt.completeopt = { "fuzzy", "noinsert", "popup", "noselect" }
vim.o.winborder = "rounded"
vim.o.hlsearch = false

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation

-- Make line numbers default and relative
vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true
-- vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'

-- Case-insensitive searching UNLESS \C or one or more capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 20

-- raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
