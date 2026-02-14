-- lsp server configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"cssls",
	"emmet_ls",
	"html",
	"htmx",
	"jsonls",
	"templ",
	"ts_ls",
	"tailwindcss",
})
vim.diagnostic.config({ virtual_text = true })
