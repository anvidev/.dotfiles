vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/nvim-mini/mini.completion" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/mcauley-penney/techbase.nvim" },
	{ src = "https://github.com/vieitesss/miniharp.nvim" },
	{ src = "https://github.com/nvim-mini/mini.snippets" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/rose-pine/neovim" },

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/neovim/nvim-lspconfig",
})

require("lazydev").setup()
require("mason").setup()
require("mini.completion").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("gitsigns").setup()

require("miniharp").setup({ show_on_autoload = true })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		gen_loader.from_lang(),
	},
})

require("fzf-lua").setup({
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
		builtin = {
			["<C-f>"] = "preview-page-down",
			["<C-b>"] = "preview-page-up",
			["<C-p>"] = "toggle-preview",
		},
	},
})

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"go",
		"typescript",
		"tsx",
		"templ",
		"sql",
		"svelte",
	},
})

require("nvim-tree").setup({
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.map.on_attach.default(bufnr)

		vim.keymap.set("n", "s", api.node.open.edit, opts("Open/close folder"))
		vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	end,
	git = {
		enable = true,
	},
	diagnostics = {
		enable = true,
	},
	modified = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = false,
	},
	renderer = {
		hidden_display = "simple",
		icons = {
			diagnostics_placement = "after",
		},
	},
	view = {
		side = "right",
		width = 40,
		adaptive_size = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
