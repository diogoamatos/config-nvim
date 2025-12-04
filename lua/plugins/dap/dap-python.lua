return {
	"mfussenegger/nvim-dap-python",
	opts = {},
	dependencies = "mfussenegger/nvim-dap",
	config = function()
		if vim.fn.isdirectory(".venv") == 1 then
			local function get_poetry_pathon_path()
				local handle = io.popen("poetry env info --executable")
				if handle then
					local path = handle:read("*a")
					handle:close()
					-- remove espaços em branco e caracteres no final da linha
					path = string.gsub(path, "%s+$", "")

					if path and path ~= "" then
						return path
					end
				end
				return "python"
			end

			local poetry_or_pathon_path = get_poetry_pathon_path()
			require("dap-python").setup(poetry_or_pathon_path)
		end
        return "python"
	end,
}
