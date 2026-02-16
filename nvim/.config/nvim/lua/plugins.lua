vim.pack.add({
	-- { src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/vieitesss/miniharp.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = vim.version.range("^1"),
	},

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

-- require("mini.pairs").setup()
require("lazydev").setup()
require("mason").setup()
require("mini.ai").setup()
require("vague").setup()

require("miniharp").setup({ show_on_autoload = true })

require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		accept = { auto_brackets = { enabled = false } },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
				components = {
					kind = {
						text = function(ctx)
							return ctx.source_name == "cmdline" and "" or ctx.kind
						end,
					},
				},
			},
		},
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "1.*",
		},
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
		transform_items = function(_, items)
			return vim.tbl_filter(function(item)
				return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
			end, items)
		end,
	},
})

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
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	default_format_opts = {
		lsp_format = "fallback",
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
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
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
		vim.keymap.set("n", "H", function()
			api.filter.dotfiles.toggle()
			api.filter.git.ignored.toggle()
		end, opts("Toggle hidden and git ignored files"))
	end,
	git = {
		enable = true,
	},
	diagnostics = {
		enable = true,
	},
	filters = {
		dotfiles = true,
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
