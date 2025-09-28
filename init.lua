vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.signcolumn = 'no'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildoptions:append "fuzzy,pum"
vim.opt.guicursor = ''
vim.o.pumheight = 7
vim.opt.laststatus = 0
vim.opt.statusline = "%{repeat('─',winwidth('.'))}"
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.splitbelow = true

if vim.version().minor == 12 then
  vim.o.diffopt = 'internal,filler,closeoff,inline:word,linematch:40'
elseif vim.version().minor == 11 then
  vim.o.diffopt = 'internal,filler,closeoff,linematch:40'
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set("n", "<leader><leader>y", function()
    vim.fn.setreg("+", vim.fn.expand "%:p")
end)

vim.keymap.set({'n', 'x'}, '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+y$')

vim.keymap.set("t", "<c-x>", "<c-\\><c-n>")

vim.pack.add({
    { src = 'https://github.com/bogado/file-line' },
    { src = 'https://github.com/tpope/vim-vinegar' },
})

vim.keymap.set('n', 'd<cr>', ':make<cr>')
vim.keymap.set('i', '<c-o>', '<c-x><c-o>')
vim.keymap.set('i', '<c-f>', '<c-x><c-f>')
vim.keymap.set('i', '<c-l>', '<c-x><c-l>')
vim.keymap.set({'n', 'v'}, '<leader>go', function() require'git'.open_in_browser() end)
