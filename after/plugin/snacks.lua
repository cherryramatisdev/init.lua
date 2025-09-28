vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local ok, snacks = pcall(require, 'snacks')

if not ok then
    return
end

snacks.setup({
    bigfile = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    image = { enabled = true },
    zen = {},
})

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end)
vim.keymap.set('n', '<leader>un', function() Snacks.notifier.hide() end)
