return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            local ivy = require("telescope.themes").get_ivy()
            require("telescope").setup({
                defaults = {
                    border = ivy.border,
                    borderchars = ivy.borderchars,
                    layout_config = ivy.layout_config,
                    layout_strategy = ivy.layout_strategy,
                    sorting_strateg = ivy.sorting_strategy,
                    theme = ivy.theme,
                    mappings = {
                        n = {
                            ["X"] = require("telescope.actions").delete_buffer,
                        },
                        i = {
                            ["X"] = require("telescope.actions").delete_buffer,
                        }
                    }
                },
                extensions = {
                    fzf = {}
                },
            })

            require('telescope').load_extension('fzf')

            local builtin = require "telescope.builtin"

            vim.keymap.set("n", "<leader>sg", builtin.live_grep)
            vim.keymap.set("n", "<leader>sb", builtin.buffers)
            vim.keymap.set("n", "<leader>sh", builtin.help_tags)
            vim.keymap.set("n", "<leader>sf", builtin.find_files)
            vim.keymap.set("n", "<leader>sr", builtin.oldfiles)
            vim.keymap.set("n", "<leader>se", builtin.diagnostics)
            vim.keymap.set("n", "<leader>sc", function()
                builtin.find_files { cwd = vim.fn.stdpath("config") }
            end)
            vim.keymap.set("n", "gr", builtin.lsp_references)
            vim.keymap.set("n", "gI", builtin.lsp_implementations)
            vim.keymap.set("n", "<leader>sd", builtin.lsp_document_symbols)
            vim.keymap.set("n", "<leader>sw", builtin.lsp_workspace_symbols)
        end
    }
}
