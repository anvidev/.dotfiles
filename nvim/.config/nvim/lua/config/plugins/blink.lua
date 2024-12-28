return {
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = {
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip'
        },
        version = 'v0.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = {
                use_nvim_cmp_as_default = true,
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },
            keymap = {
                preset = 'enter',
            },
            completion = {
                menu = {
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                signature = {
                    enabled = true
                },
            },
            opts_extend = { "sources.default" }
        },
    }
}
