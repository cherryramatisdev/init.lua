vim.pack.add({
    { src = 'https://github.com/nyxvamp-theme/neovim',        name = 'nyxvamp' },
    { src = 'https://github.com/thiago-negri/vim-dark' },
    { src = 'https://github.com/owickstrom/vim-colors-paramount' },
    { src = 'https://github.com/raphael-proust/vacme' },
    { src = 'https://github.com/YorickPeterse/vim-paper' },
    { src = 'https://github.com/f-person/auto-dark-mode.nvim' },
})

vim.cmd [[ hi! StatusLine guibg=NONE guifg=NONE gui=NONE term=NONE ]]
vim.cmd [[ hi! StatusLineNC guibg=NONE guifg=NONE gui=NONE term=NONE ]]

require 'auto-dark-mode'.setup {
    set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd.colorscheme 'paramount'
    end,
    set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd.colorscheme 'vacme'
    end,
    update_interval = 3000,
    fallback = "dark"
}
