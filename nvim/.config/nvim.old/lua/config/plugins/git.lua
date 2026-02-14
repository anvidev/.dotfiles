return {
    {
        "tpope/vim-fugitive",
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function()
                local gitsigns = require("gitsigns")

                vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
                vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
                vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
                vim.keymap.set("n", "<leader>hb", gitsigns.blame_line)

                vim.keymap.set("n", "hn", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end)

                vim.keymap.set("n", "hp", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end)
            end
        },
    }
}
