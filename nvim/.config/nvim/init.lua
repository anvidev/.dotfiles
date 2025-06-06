vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "120"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.showmode = false
vim.opt.signcolumn = "yes:1"

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "<space><space>x", "<cmd>:source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "gx", ":sil !open <cWORD><cr>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>")
vim.keymap.set("n", "cn", "<cmd>cnext<CR>")
vim.keymap.set("n", "cp", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist)
vim.keymap.set("n", "YY", "va{Vy")

vim.keymap.set("n", "<leader>dw", "<cmd>noautocmd w <CR>")

vim.keymap.set("n", "S", function()
    local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
    local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("x", "<", function()
    vim.cmd("normal! <<")
    vim.cmd("normal! gv")
end)

vim.keymap.set("x", ">", function()
    vim.cmd("normal! >>")
    vim.cmd("normal! gv")
end)

vim.keymap.set("n", "dn", function()
    vim.diagnostic.jump({ count = 1, wrap = true })
end)

vim.keymap.set("n", "dp", function()
    vim.diagnostic.jump({ count = -1, wrap = true })
end)

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text when yanked",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

if vim.g.have_nerd_font then
    local signs = { ERROR = "", WARN = "", INFO = "", HINT = "⚑" }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    vim.diagnostic.config({ signs = { text = diagnostic_signs } })
end

vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"
vim.o.guicursor = table.concat({
    "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
}, ",")

require("config.lazy")
