vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

-- Helper to detect local Python venv
local workspace = vim.lsp.buf.list_workspace_folders()[1]
local function get_python_path(workspace)
	local path = vim.fs.joinpath(workspace, ".venv", "bin", "python")
	if vim.fn.executable(path) == 1 then
		return path
	end
	return "python3" -- Fallback
end

local servers = {
	-- clangd = {},
	-- gopls = {},
	pyright = {
		on_init = function(client)
			client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
		end,
		settings = {
			python = {
				pythonPath = get_python_path(workspace),
			},
		},
	},
	-- rust_analyzer = {},
	-- ts_ls = {},
	stylua = {}, -- Used to format Lua code

	-- Special Lua Config, as recommended by neovim help docs
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					library = vim.tbl_filter(function(d)
						return not d:match(vim.fn.stdpath("config") .. "/?a?f?t?e?r?")
					end, vim.api.nvim_get_runtime_file("", true)),
				},
			})
		end,
		---@type lspconfig.settings.lua_ls
		settings = {
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
}
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"pyright",
	"lua_ls",
	"isort",
	"black",
	"prettier",
	"djlint",
})

require("mason").setup({})
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
