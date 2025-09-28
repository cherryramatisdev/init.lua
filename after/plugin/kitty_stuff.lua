vim.pack.add({ "https://github.com/mrjones2014/smart-splits.nvim" }, { load = true })

local smart_splits_ok, smart_splits = pcall(require, 'smart-splits')

if not smart_splits_ok then
    return
end

vim.keymap.set({'n', 't'}, '<M-h>', function() smart_splits.resize_left(10) end)
vim.keymap.set({'n', 't'}, '<M-j>', function() smart_splits.resize_down(10) end)
vim.keymap.set({'n', 't'}, '<M-k>', function() smart_splits.resize_up(10) end)
vim.keymap.set({'n', 't'}, '<M-l>', function() smart_splits.resize_right(10) end)

vim.keymap.set({'n', 't'}, '<C-h>', smart_splits.move_cursor_left)
vim.keymap.set({'n', 't'}, '<C-j>', smart_splits.move_cursor_down)
vim.keymap.set({'n', 't'}, '<C-k>', smart_splits.move_cursor_up)
vim.keymap.set({'n', 't'}, '<C-l>', smart_splits.move_cursor_right)
