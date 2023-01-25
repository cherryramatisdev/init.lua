-- vim.cmd.colorscheme('norcalli')
-- require("colorbuddy").colorscheme("gruvbuddy")

-- vim.cmd([[
-- hi Conceal guibg=NONE guifg=gray
-- ]])

vim.o.background = "dark"

require("vscode").setup({
  -- Enable transparent background
  transparent = true,

  -- Enable italic comment
  italic_comments = true,
})
