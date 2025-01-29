return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason-lspconfig.nvim",
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        opts = {
            servers = {
                lua_ls = {},
                gopls = {},
                -- htmx = {}, -- htmx-lsp breaks blink.cmp for now (https://github.com/Saghen/blink.cmp/issues/825)
                templ = {},
                sqlls = {},
                ts_ls = {},
                html = { filetypes = { "html", "templ" } },
                tailwindcss = {},
                emmet_language_server = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end

            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "gD", ":vs | lua vim.lsp.buf.definition()<CR>")
            vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
            vim.keymap.set("n", "<C-y>", vim.diagnostic.open_float)
        end
    }
}
