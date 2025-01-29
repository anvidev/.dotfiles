---@diagnostic disable: missing-fields
return {
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = {
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
            "onsails/lspkind.nvim"
        },
        version = '*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = {
                preset = "luasnip",
                expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction) require("luasnip").jump(direction) end,
            },
            keymap = {
                preset = 'enter',
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                    }
                },
                accept = {
                    auto_brackets = {
                        enabled = true
                    },
                },
                menu = {
                    draw = {
                        columns = { { "kind_icon", "label", gap = 1 }, { "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                    treesitter_highlighting = true,
                },
                trigger = {
                    show_on_insert_on_trigger_character = false,
                },
            },
            appearance = {
                nerd_font_variant = 'mono',
                use_nvim_cmp_as_default = true
            },
            signature = {
                enabled = true
            },
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                cmdline = {},
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    lsp = {
                        min_keyword_length = 0,
                        score_offset = 90,
                        module = "blink.cmp.sources.lsp",
                    },
                    path = {
                        min_keyword_length = 0,
                        module = "blink.cmp.sources.path",
                        score_offset = 25,
                    },
                    snippets = {
                        min_keyword_length = 2,
                        score_offset = 85,
                    },
                    buffer = {
                        min_keyword_length = 4,
                        max_items = 4,
                        module = "blink.cmp.sources.buffer",
                        score_offset = 15,
                    },
                },
            },
        },
    }
}
