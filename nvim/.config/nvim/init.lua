-- LEARN THESE KEYMAPS
-- grn = vim.lsp.buf.rename
-- grr = vim.lsp.buf.references
-- gri = vim.lsp.buf.implementation
-- gO = vim.lsp.buf.document_symbol
-- CTRL-S (ctrl and shift + s) in insert mode = vim.buf.lsp.signature_help
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.clipboard = "unnamedplus"
vim.o.splitbelow = false
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 12
vim.o.colorcolumn = "80"
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.swapfile = false
vim.o.signcolumn = "yes:2"
vim.o.winborder = "rounded"
vim.diagnostic.config({ virtual_text = true })
if vim.g.have_nerd_font then
	local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
	local diagnostic_signs = {}
	for type, icon in pairs(signs) do
		diagnostic_signs[vim.diagnostic.severity[type]] = icon
	end
	vim.diagnostic.config({ signs = { text = diagnostic_signs } })
end
-- install plugins
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	-- dependencies of other plugins
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

-- require plugins
---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"go",
		"typescript",
		"tsx"
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
require("mini.ai").setup()
require("mini.pairs").setup()
require("lazydev").setup()
require("fzf-lua").setup()
require("neo-tree").setup({})
require("gitsigns").setup({
	sign_priority = 1000,
	on_attach = function()
		local gitsigns = require("gitsigns")
		vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk)
		vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk)
		vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk)
		vim.keymap.set("n", "<leader>gb", gitsigns.blame_line)
		vim.keymap.set("n", "gn", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				---@diagnostic disable-next-line: param-type-mismatch
				gitsigns.nav_hunk("next")
			end
		end)
		vim.keymap.set("n", "gp", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				---@diagnostic disable-next-line: param-type-mismatch
				gitsigns.nav_hunk("prev")
			end
		end)
	end
})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		go = { "goimports", "gopls" },
		sql = { "sql_formatter" },
		templ = { "templ" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- enable lsps
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"svelte-language-server",
	"gopls"
})

-- colors and theme
vim.cmd("colorscheme rose-pine")

-- keymaps
-- misc
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>")
vim.keymap.set("n", "gD", ":vs | lua vim.lsp.buf.definition()<CR>")
vim.keymap.set({ "n", "v" }, "<leader>fa", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>")
vim.keymap.set("n", "<leader>dw", "<cmd>noautocmd w <CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("x", "<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)
vim.keymap.set("x", ">", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)

vim.keymap.set("n", "do", vim.diagnostic.open_float)
vim.keymap.set("n", "dn", function()
	vim.diagnostic.jump({ count = 1, wrap = true })
end)

vim.keymap.set("n", "dp", function()
	vim.diagnostic.jump({ count = -1, wrap = true })
end)

-- neotree
vim.keymap.set("n", "<leader>e", ":Neotree toggle right<CR>")
vim.keymap.set("n", "<leader>b", ":Neotree buffers toggle right<CR>")

-- fzf-lua
vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>sc", ":FzfLua files cwd=~/.dotfiles<CR>")
vim.keymap.set("n", "<leader>sr", ":FzfLua oldfiles<CR>")
vim.keymap.set("n", "<leader>sb", ":FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>")

-- autocmds
-- showing intellisense
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		---@diagnostic disable-next-line: need-check-nil
		if client:supports_method('textDocument/completion') then
			---@diagnostic disable-next-line: need-check-nil
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=menuone,noselect")

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
