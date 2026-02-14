return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    lazy = false,
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Find file in filetree" },
    },
    config = function()
        local function on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 's', api.node.open.edit, opts('Open/close folder'))
            vim.keymap.set('n', 'H', function()
                api.tree.toggle_hidden_filter()
                api.tree.toggle_gitignore_filter()
            end, opts('Toggle all hidden files'))
        end

        require("nvim-tree").setup({
            on_attach = on_attach,
            filters = {
                dotfiles = true,
            },
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
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            view = {
                width = 40,
                side = "right",
                adaptive_size = true,
            },
            renderer = {
                hidden_display = "simple",
                icons = {
                    diagnostics_placement = "after",
                },
            },
        })
    end
}
