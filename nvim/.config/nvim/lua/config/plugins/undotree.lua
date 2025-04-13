return {
    "mbbill/undotree",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>u", function()
            vim.g.undotree_WindowLayout = 4
            vim.g.undotree_SplitWidth = 45

            vim.cmd.UndotreeToggle()
            vim.cmd.UndotreeFocus()
        end, {})
    end
}
