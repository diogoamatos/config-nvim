-- ~/.config/nvim/lua/configs.lua
--
-- Disable NetRW
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.colorcolumn = "80" -- Highlight column 80
opt.signcolumn = "yes:2" -- Always show sign column
opt.termguicolors = true -- Enable true colors
opt.ignorecase = true -- Ignore case in search
opt.swapfile = false -- Disable swap files
opt.autoindent = true -- Enable auto indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 4 -- Number of spaces for a tab
opt.softtabstop = 4 -- Number of spaces for a tab when editing
opt.shiftwidth = 4 -- Number of spaces for autoindent
opt.shiftround = true -- Round indent to multiple of shiftwidth
opt.listchars = "tab: ,multispace:|   ," -- Characters to show for tabs, spaces, and end of line
opt.list = true -- Show whitespace characters
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.numberwidth = 2 -- Width of the line number column

-- text wrap
opt.wrap = true
opt.linebreak = false
opt.textwidth = 0
opt.wrapmargin = 0

opt.cursorline = true -- Highlight the current line
opt.scrolloff = 99
opt.inccommand = "nosplit" -- Shows the effects of a command incrementally in the buffer
opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- Directory for undo files
opt.undofile = true -- Enable persistent undo
opt.completeopt = {"fuzzy", "menuone", "popup", "noselect" } -- Options for completion menu
opt.winborder = "rounded" -- Use rounded borders for windows
opt.hlsearch = false -- Disable highlighting of search results

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation


-- opt.complete = ".,o"
-- opt.autocomplete = true
-- opt.pumheight = 7
