return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            'hrsh7th/cmp-nvim-lsp',
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
                html = { filetypes = { "html", "templ", "svelte" } },
                tailwindcss = {},
                emmet_language_server = {},
                svelte = {},
                zls = {},
            }
        },
        config = function(_, opts)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            require('mason-tool-installer').setup({ ensure_installed = opts.servers })

            require('mason-lspconfig').setup({
                ensure_installed = {},
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = opts.servers[server_name] or {}

                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end
                }
            })

            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "gD", ":vs | lua vim.lsp.buf.definition()<CR>")
            vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
            vim.keymap.set("n", "<C-y>", vim.diagnostic.open_float)
        end
    }
}
