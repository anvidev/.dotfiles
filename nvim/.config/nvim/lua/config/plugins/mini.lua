return {
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()
        require("mini.pairs").setup()

        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = vim.g.have_nerd_font })

        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        local starter = require("mini.starter")
        local hooks = {
            clear_statusline = function(buff)
                vim.b.ministatusline_disable = true
                vim.cmd("highlight StatusLine ctermbg=None guibg=None")
                return buff
            end,
            local_keymap = function(buff)
                vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = 0 })
                vim.keymap.set("n", "j", "<cmd>normal <Down><cr>", { buffer = 0 })
                vim.keymap.set("n", "k", "<cmd>normal <Up><cr>", { buffer = 0 })
                return buff
            end,
        }

        starter.setup({
            autoopen = true,
            silent = true,
            evaluate_single = true,
            -- header = "",
            items = {
                {
                    { name = "Find Files", action = "Telescope find_files", section = "" },
                    { name = "Recent Files", action = "Telescope oldfiles", section = "" },
                    { name = "TODO", action = "Telescope todo-comments", section = "" },
                    { name = "Quit", action = ":q!", section = "" },
                },
            },
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.aligning("center", "center"),
                hooks.clear_statusline,
                hooks.local_keymap,
            },
            query_updaters = "abcdefghilmnopqrstuvwxyz0123456789_-.",
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local padding = "░ "
                starter.config.footer = padding .. stats.loaded .. "/" .. stats.count .. "  "
                pcall(starter.refresh)
            end,
        })
    end,
}
