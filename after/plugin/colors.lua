vim.pack.add {
  { src = "https://github.com/f-person/auto-dark-mode.nvim" },
}

vim.cmd [[ hi! StatusLine guibg=NONE guifg=NONE gui=NONE term=NONE ]]
vim.cmd [[ hi! StatusLineNC guibg=NONE guifg=NONE gui=NONE term=NONE ]]

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "lua",
  callback = function()
    vim.treesitter.stop()
  end,
})

require("auto-dark-mode").setup {
  set_dark_mode = function()
    vim.api.nvim_set_option_value("background", "dark", {})
    vim.cmd.colorscheme "halloweny"
  end,
  set_light_mode = function()
    vim.api.nvim_set_option_value("background", "light", {})
    vim.cmd.colorscheme "halloweny"
  end,
  update_interval = 3000,
  fallback = "dark",
}
