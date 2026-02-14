-- neovim keymaps to remembers
--
-- open diagnostic window (<C-w>d)
-- redo (<C-r>)
-- goto end of line ($)
-- goto start of line (_)

local keymap = vim.keymap.set

keymap("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

keymap("n", "U", "<C-r>")
keymap("n", "yf", ":%y<CR>")
keymap("n", "<leader>lw", "<cmd>set wrap!<CR>")
keymap("n", "<leader>dw", "<cmd>noautocmd w <CR>")
keymap("n", "L", "$")
keymap("n", "H", "^")
keymap("n", "<Esc>", ":nohlsearch<CR>")
keymap("n", "<c-k>", ":wincmd k<CR>")
keymap("n", "<c-j>", ":wincmd j<CR>")
keymap("n", "<c-h>", ":wincmd h<CR>")
keymap("n", "<c-l>", ":wincmd l<CR>")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("n", "#", "#zz")
keymap("n", "*", "*zz")
keymap("x", "<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)
keymap("x", ">", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)

keymap({ "n", "v" }, "<leader>fa", vim.lsp.buf.format)

keymap("n", "do", vim.diagnostic.open_float)
keymap("n", "dn", function()
	vim.diagnostic.jump({ count = 1, wrap = true })
end)

keymap("n", "dp", function()
	vim.diagnostic.jump({ count = -1, wrap = true })
end)

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

keymap("n", "<leader>sf", ":FzfLua files<CR>")
keymap("n", "<leader>sc", ":FzfLua files cwd=~/.dotfiles<CR>")
keymap("n", "<leader>sr", ":FzfLua oldfiles<CR>")
keymap("n", "<leader>sb", ":FzfLua buffers<CR>")
keymap("n", "<leader>sg", ":FzfLua live_grep<CR>")
keymap("n", "<leader>sd", ":FzfLua diagnostics_workspace<CR>")
keymap("n", "<leader>ss", ":FzfLua lsp_document_symbols<CR>")
keymap("n", "<leader>s/", ":FzfLua grep_curbuf<CR>")

keymap("n", "<leader>m", '<cmd>lua require("miniharp").toggle_file()<CR>')
keymap("n", "<leader>l", '<cmd>lua require("miniharp").show_list()<CR>')
keymap("n", "<C-n>", require("miniharp").next)
keymap("n", "<C-p>", require("miniharp").prev)
