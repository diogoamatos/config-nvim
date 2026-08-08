-- ============================================================
-- SECTION 1: OPTIONS and KEYMAPS
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
vim.g.mapleader = " "
do
	require("configs")
	require("keymaps")
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
			local stderr = result.stderr or ""
			local stdout = result.stdout or ""
			local output = stderr ~= "" and stderr or stdout
			if output == "" then
				output = "No output from build command."
			end
			vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
		end
	end

	-- This autocommand runs after a plugin is installed or updated and
	--  runs the appropriate build command for that plugin if necessary.
	--
	-- See `:help vim.pack-events`
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name = ev.data.spec.name
			local kind = ev.data.kind
			if kind ~= "install" and kind ~= "update" then
				return
			end

			if name == "fzf-lua" and vim.fn.executable("make") == 1 then
				run_build(name, { "make" }, ev.data.path)
				return
			end

			if name == "LuaSnip" then
				if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
					run_build(name, { "make", "install_jsregexp" }, ev.data.path)
				end
				return
			end

			if name == "nvim-treesitter" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
				return
			end
		end,
	})
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo)
	return "https://github.com/" .. repo
end

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- gitsigns, colorscheme, todo-comments
-- minimal config plugins
-- ============================================================
do
	-- Plugins with config
	require("plugins.neo-tree")
	require("plugins.gitsigns")
	require("plugins.noice")

	vim.pack.add({ gh("windwp/nvim-autopairs") })
	require("nvim-autopairs").setup({})

	vim.pack.add({ gh("lukas-reineke/indent-blankline.nvim") })
	require("ibl").setup({})

	vim.pack.add({ gh("rcarriga/nvim-notify") })
	vim.notify = require("notify").setup({
		timeout = 3000,
		stages = "slide",
		merge_duplicates = true,
	})

	vim.pack.add({ gh("nvim-tree/nvim-web-devicons") })
	require("nvim-web-devicons").setup({})

	-- vim.pack.add({ gh("catppuccin/nvim") })
	-- vim.cmd.colorscheme("catppuccin")
	vim.pack.add({ gh("nyoom-engineering/oxocarbon.nvim") })
	vim.cmd.colorscheme("oxocarbon")

	vim.pack.add({ gh("nvim-lualine/lualine.nvim") })
	require("lualine").setup({})

	-- Highlight todo, notes, etc in comments
	vim.pack.add({ gh("folke/todo-comments.nvim") })
	require("todo-comments").setup({ signs = false })

	-- Scratch pad persisntent
	vim.pack.add({ gh("ericrswanny/chkn.nvim") })
	require("chkn").setup({})
end

-- ============================================================
-- SECTION 4: SEARCH & NAVIGATION
-- Fzf-lua setup, keymaps, LSP picker mappings
-- ============================================================
do
	-- Fzf-lua configs
	vim.pack.add({ gh("ibhagwan/fzf-lua") })
	require("fzf-lua").setup({ "default" })

	-- -- Fuzzy finders
	vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<CR>", { desc = "Find files." })
	vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Grep files." })
	vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "Show files history." })
	vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<CR>", { desc = "Show open buffers." })
	vim.keymap.set("n", "<leader>.", "<cmd>FzfLua keymaps<CR>", { desc = "Show keymaps." })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("fzf-lsp-attach", { clear = true }),
		callback = function(args)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
			end
			local fzf = require("fzf-lua")

			-- Exemplos de atalhos utilizando fzf-lua
			map("grr", fzf.lsp_references, "Ir para referências")
			map("grd", fzf.lsp_definitions, "Ir para definições")
			map("<leader>ds", fzf.lsp_document_symbols, "Listar símbolos do documento")
			map("<leader>ca", fzf.lsp_code_actions, "Code Actions")
		end,
	})
end

-- ============================================================
-- SECTION 5: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
		callback = function(args)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
			end

			--  Most Language Servers support renaming across files, etc.
			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction")

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client:supports_method("textDocument/documentHighlight", args.buf) then
				local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "config-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- The following code creates a keymap to toggle inlay hints in your
			-- code, if the language server you are using supports them
			--
			-- This may be unwanted, since they displace some of your code
			if client and client:supports_method("textDocument/inlayHint", args.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})
	require("lsp-config")
end
-- ============================================================
-- SECTION 6: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
require("plugins.conform")

-- ============================================================
-- SECTION 7: AUTOCOMPLETE & SNIPPETS
-- blink.cmp, luasnip and friendly-snippets setup
-- ============================================================
do
	vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })
	require("luasnip").setup({})

	vim.pack.add({ gh("rafamadriz/friendly-snippets") })
	require("luasnip.loaders.from_vscode").lazy_load()

	require("plugins.blink-cmp")
end

-- ============================================================
-- SECTION 8: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
	require("plugins.treesitter")
end

-- ============================================================
-- SECTION 9: Debug, autopairs, lint, indent_lines
-- ============================================================
do
	require("plugins.debug")
end
