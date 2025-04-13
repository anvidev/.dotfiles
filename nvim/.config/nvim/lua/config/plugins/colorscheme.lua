return {
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme "tokyonight-night"
    --     end
    -- },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                styles = {
                    italic = false,
                }
            })
            vim.cmd("colorscheme rose-pine-main")
        end
    }
}
