local state = {
    floating = {
        win = -1,
        buf = -1,
    }
}

local create_floating_window = function(opts)
    opts = opts or {}

    local screen_height = vim.o.lines
    local screen_width = vim.o.columns

    local win_height = opts.win_height or math.floor(screen_height * 0.8)
    local win_width = opts.win_width or math.floor(screen_width * 0.8)

    local win_top = math.floor((screen_height - win_height) / 2)
    local win_left = math.floor((screen_width - win_width) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = win_width,
        height = win_height,
        col = win_left,
        row = win_top,
        style = "minimal",
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
    vim.cmd [[normal i]]
end

vim.api.nvim_create_user_command("FloatTerminal", toggle_terminal, {})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader>tt", "<cmd>FloatTerminal<CR>")
