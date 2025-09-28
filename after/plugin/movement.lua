vim.pack.add {{src = "https://github.com/smoka7/hop.nvim"}}

local ok, hop = pcall(require, 'hop')

if not ok then
    return
end

hop.setup { keys = "etovxqpdygfblzhckisuran" }

vim.keymap.set({'n', 'x', 'v', 'o'}, '<leader>w', hop.hint_words, {desc = "Jump to word"})
vim.keymap.set({'n', 'x', 'v', 'o'}, '<leader>k', hop.hint_lines, {desc = "Jump to line above"})
vim.keymap.set({'n', 'x', 'v', 'o'}, '<leader>j', hop.hint_lines, {desc = "Jump to line below"})
