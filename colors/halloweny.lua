vim.g.colors_name = 'halloweny'

vim.cmd.colorscheme 'peachpuff'
vim.cmd [[ syntax off ]]

local bg = ''
local fg = ''

if vim.o.background == 'light' then
    bg = '#fff8f0'
    fg = '#b35c00'
else
    bg = '#282828'
    fg = '#ffaf00'
end

vim.api.nvim_set_hl(0, 'Normal', { background = bg, foreground = fg })
vim.api.nvim_set_hl(0, 'Pmenu', { background = bg, foreground = fg })
