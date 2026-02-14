-- lsp server configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"cssls",
	"emmet_ls",
	"html",
	"jsonls",
	"templ",
	"tailwindcss",
	"vtsls",
})

vim.diagnostic.config({ virtual_text = true })
