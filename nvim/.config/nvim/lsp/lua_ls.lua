---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            codeLens = { enable = true },
            hint = { enable = true, semicolon = 'Disable' },
        },
    },
}
