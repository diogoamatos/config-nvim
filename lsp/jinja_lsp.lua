---@type vim.lsp.Config
return {
    name = 'jinja_lsp',
    cmd = { 'jinja-lsp' },
    filetypes = { 'jinja', 'html', 'htmldjango' },
    root_markers = { '.git', 'pyproject.toml' },
}
