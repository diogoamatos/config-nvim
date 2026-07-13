-- ============================================================
-- SECTION 1: OPTIONS and KEYMAPS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
vim.g.mapleader = " "
do
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

            if name == 'fzf-lua' and vim.fn.executable 'make' == 1 then
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
    require('plugins.neo-tree')
    require('plugins.gitsigns')

    vim.pack.add { gh "rcarriga/nvim-notify" }
    vim.notify = require("notify").setup({
        timeout = 3000,
        stages = "slide",
    })

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
end


-- ============================================================
-- SECTION 4: SEARCH & NAVIGATION
-- Fzf-lua setup, keymaps, LSP picker mappings
-- ============================================================
do
    -- Fzf-lua configs
    vim.pack.add { gh "ibhagwan/fzf-lua" }
    require("fzf-lua").setup({ "default" })

    -- -- Fuzzy finders
    vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<CR>", { desc = "Find files." })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Grep files." })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "Show files history." })
    vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<CR>", { desc = "Show open buffers." })
    vim.keymap.set("n", "<leader>.", "<cmd>FzfLua keymaps<CR>", { desc = "Show keymaps." })

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
            end
            local fzf = require('fzf-lua')

            -- Exemplos de atalhos utilizando fzf-lua
            map('grr', fzf.lsp_references, 'Ir para referências')
            map('grd', fzf.lsp_definitions, 'Ir para definições')
            map('<leader>ds', fzf.lsp_document_symbols, 'Listar símbolos do documento')
            map('<leader>ca', fzf.lsp_code_actions, 'Code Actions')
        end,
    })
end


require('plugins')

require('lsp')
-- require('dap_config')
