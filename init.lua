-- ============================================================
-- SECTION 1: OPTIONS and KEYMAPS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
    vim.g.mapleader = " "
    require('configs')
    require('keymaps')
    -- require('autocmds')
end

-- ============================================================
-- SECTION 2: PLUGIN MANAGER
-- ============================================================
do
    --  To update plugins, run
    --    :lua vim.pack.update()
    local function run_build(name, cmd, cwd)
        local result = vim.system(cmd, { cwd = cwd }):wait()
        if result.code ~= 0 then
            local stderr = result.stderr or ''
            local stdout = result.stdout or ''
            local output = stderr ~= '' and stderr or stdout
            if output == '' then output = 'No output from build command.' end
            vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
        end
    end

    -- This autocommand runs after a plugin is installed or updated and
    --  runs the appropriate build command for that plugin if necessary.
    --
    -- See `:help vim.pack-events`
    vim.api.nvim_create_autocmd('PackChanged', {
        callback = function(ev)
            local name = ev.data.spec.name
            local kind = ev.data.kind
            if kind ~= 'install' and kind ~= 'update' then return end

            if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
                run_build(name, { 'make' }, ev.data.path)
                return
            end

            if name == 'LuaSnip' then
                if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
                    run_build(name,
                        { 'make', 'install_jsregexp' }, ev.data.path)
                end
                return
            end

            if name == 'nvim-treesitter' then
                if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
                vim.cmd 'TSUpdate'
                return
            end
        end,
    })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- gitsigns, colorscheme, todo-comments
-- minimal config plugins
-- ============================================================
do
    vim.pack.add { gh "lewis6991/gitsigns.nvim" }
    require('gitsigns').setup {
        signs = {
            add = { text = '+' }, ---@diagnostic disable-line: missing-fields
            change = { text = '~' }, ---@diagnostic disable-line: missing-fields
            delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
            topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
            changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
        },
    }

    vim.pack.add { gh "nvim-tree/nvim-web-devicons" }
    require("nvim-web-devicons").setup({})

    vim.pack.add { gh "catppuccin/nvim" }
    vim.cmd.colorscheme("catppuccin")

    vim.pack.add { gh "nvim-lualine/lualine.nvim" }
    require('lualine').setup({})

    -- Highlight todo, notes, etc in comments
    vim.pack.add { gh 'folke/todo-comments.nvim' }
    require('todo-comments').setup { signs = false }

    -- Scratch pad persisntent
    vim.pack.add { gh "ericrswanny/chkn.nvim" }
    require("chkn").setup({})

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
end


-- ============================================================
-- SECTION 4: SEARCH & NAVIGATION
-- Fzf setup, keymaps, LSP picker mappings
-- ============================================================
require('plugins')

-- require('lsp')
-- require('dap_config')
