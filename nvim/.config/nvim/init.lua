--[[
    remember new lsp keymaps
    - gra → code actions
    - gri → implementations
    - grn → rename
    - grr → references
    - grt → type definition
    - grx → run codelens
    - gO → document symbols
    - Ctrl-S in Insert mode → signature help
]] --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:2"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.autoindent = true
vim.opt.confirm = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.spell = false
vim.opt.spelllang = { "en", "da" }
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.winborder = "none"
vim.diagnostic.config({ virtual_text = true })

vim.pack.add {
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/Saghen/blink.cmp" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
}

require("vim._core.ui2").enable()
require("vague").setup()
require("mason").setup()
require("gitsigns").setup({
    sign_priority = 1000,
})
require("mason-lspconfig").setup({
    automatic_enable = true,
    ensure_installed = {
        "lua_ls",
        "jsonls",
        "gopls",
        "svelte",
        "tsgo",
        "tailwindcss",
        "templ",
        "html",
    },
})
require("fzf-lua").setup({
    "telescope",
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
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
require("oil").setup({
    keymaps = {
        ["H"] = { "actions.toggle_hidden", mode = "n" },
        ["b"] = { "actions.parent", mode = "n" },
        ["B"] = { "actions.open_cwd", mode = "n" },
        ["<C-v>"] = { "actions.select_vsplit", opts = { vertical = true } }
    },
    view_options = {
        show_hidden = true,
    },
    float = {
        border = "single",
        max_width = 0.5,
        max_height = 0.5,
    },
    confirmation = { border = "single" },
    keymaps_help = { border = "single" },
})
require("blink.cmp").setup({
    signature = { enabled = true },
    completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
            auto_show = true,
            draw = {
                treesitter = { "lsp" },
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "kind",              gap = 1 },
                },
            },
        },
    },
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        local available_langs = require("nvim-treesitter").get_available()
        local is_available = vim.tbl_contains(available_langs, lang)

        if is_available then
            require("nvim-treesitter").install(lang):wait()
            vim.treesitter.start()
            require("nvim-treesitter").indentexpr()
        end
    end
})

vim.cmd("colorscheme vague")
vim.cmd("packadd nvim.undotree")

vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>")
vim.keymap.set("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
vim.keymap.set("n", "<leader>dw", "<cmd>noautocmd w <CR>")
vim.keymap.set("n", "<leader>cs", ":set spell!<CR>")
vim.keymap.set({ "n", "v" }, "<leader>fa", vim.lsp.buf.format)
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "yf", ":%y<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("n", "dn", ":lua vim.diagnostic.jump({ count = 1, wrap = true })<CR>")
vim.keymap.set("n", "dp", ":lua vim.diagnostic.jump({ count = -1, wrap = true })<CR>")
vim.keymap.set("n", "gD", ":vs | lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "to", ":tabnew<CR>")
vim.keymap.set("n", "tc", ":tabclose<CR>")
vim.keymap.set("n", "tp", ":tabp<CR>")
vim.keymap.set("n", "tn", ":tabn<CR>")
vim.keymap.set("n", "<TAB>", ":tabn<CR>")

vim.keymap.set("n", "<C-p>", "<CMD>Oil --float<CR>")

vim.keymap.set("n", "<leader>sf", ":FzfLua files<CR>")
vim.keymap.set("n", "<leader>sc", ":FzfLua files cwd=~/.dotfiles<CR>")
vim.keymap.set("n", "<leader>sr", ":FzfLua oldfiles<CR>")
vim.keymap.set("n", "<leader>sb", ":FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>sg", ":FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>sd", ":FzfLua diagnostics_workspace<CR>")
vim.keymap.set("n", "<leader>ss", ":FzfLua lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>s/", ":FzfLua grep_curbuf<CR>")

vim.keymap.set("n", "gs", ":Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "gr", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "gh", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "gb", ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "gp", ":Gitsigns nav_hunk prev<CR>")
vim.keymap.set("n", "gn", ":Gitsigns nav_hunk next<CR>")
