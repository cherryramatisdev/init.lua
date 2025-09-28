local function is_floating_window()
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)
    return config.relative ~= ""
end

vim.keymap.set({ 'n' }, '<c-w>t', function()
    local bufnr = vim.api.nvim_get_current_buf()

    vim.api.nvim_win_close(vim.fn.win_getid(), false)

    vim.cmd.tabnew()
    vim.api.nvim_win_set_buf(0, bufnr)
end, { desc = 'Move the current buffer to a different tab' })

local buffer_pos_state = {}

vim.keymap.set({ 'n' }, '<c-w><space>', function()
    local bufnr = vim.api.nvim_get_current_buf()

    if is_floating_window() then
        vim.api.nvim_win_close(vim.fn.win_getid(), false)

        local state = buffer_pos_state[bufnr]

        if not state then
            vim.cmd.tabnew()
            vim.api.nvim_win_set_buf(0, bufnr)
            return
        end

        if state.split == 'right' or state.split == 'left' then
            vim.cmd.vsplit()
        else
            vim.cmd.split()
        end

        vim.api.nvim_win_set_buf(0, bufnr)
        vim.api.nvim_win_set_width(0, state.width)
        vim.api.nvim_win_set_height(0, state.height)

        buffer_pos_state[bufnr] = nil

        return
    end

    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)

    buffer_pos_state[bufnr] = {
        win = win,
        width = vim.api.nvim_win_get_width(win),
        height = vim.api.nvim_win_get_height(win),
        split = config.split,
        layout = vim.fn.winlayout(),
        parent = vim.fn.win_getid(vim.fn.win_id2tabwin(win)[2] - 1)
    }

    vim.api.nvim_win_close(vim.fn.win_getid(), false)

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)

    local ui = vim.api.nvim_list_uis()[1]

    local col = math.floor((ui.width - (width + 2)) / 2)
    local row = math.floor((ui.height - (height + 2)) / 2)

    vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        width = width - 4,
        height = height - 2,
        col = col,
        row = row,
        style = 'minimal',
        border = 'single'
    })
end, { desc = 'Move the current buffer to a floating window' })

vim.api.nvim_create_user_command('EditWindowFloat', function(opts)
    local bufnr = vim.fn.bufadd(opts.args)
    vim.fn.bufload(bufnr)

    -- Get UI dimensions
    local ui = vim.api.nvim_list_uis()[1]

    -- Calculate window size (90% of UI with border adjustments)
    local win_width = math.floor(ui.width * 0.9) - 4
    local win_height = math.floor(ui.height * 0.9) - 2

    -- Calculate centered position
    local col = math.floor((ui.width - win_width) / 2)
    local row = math.floor((ui.height - win_height) / 2)

    -- Create floating window
    vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        width = win_width,
        height = win_height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'single'
    })
end, { nargs = 1, complete = 'file' })
