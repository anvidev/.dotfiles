local opt = vim.o
local g = vim.g
local cmd = vim.cmd

g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true

opt.numberwidth = 2
opt.signcolumn = "yes:2"
opt.clipboard = "unnamedplus"
opt.colorcolumn = "80"
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.confirm = true
opt.expandtab = false
opt.scrolloff = 16
opt.splitright = true
opt.splitbelow = false
opt.wrap = false
opt.winborder = "single"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"

cmd.filetype("plugin indent on")
cmd("colorscheme rose-pine")
