return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
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
            'saghen/blink.cmp',
        },
        lazy = false,
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                automatic_enable = true
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
