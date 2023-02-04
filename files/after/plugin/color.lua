local utils = require("cherry.utils")
local themes_to_cycle = {
  "mocha",
	"frappe",
	"latte",
	"macchiato",
}
vim.g.current_theme = 'mocha'
vim.cmd.colorscheme("catppuccin-mocha")

local function cycle_themes()
	local current_theme = vim.g.current_theme

	local index_of_current_theme = utils.index_of(themes_to_cycle, current_theme)
	P(themes_to_cycle[index_of_current_theme])
	local index_of_next_theme = index_of_current_theme + 1

  if index_of_next_theme > #themes_to_cycle then
    index_of_next_theme = 1
  end

  vim.g.current_theme = themes_to_cycle[index_of_next_theme]

	vim.cmd('Catppuccin ' .. themes_to_cycle[index_of_next_theme])
end

vim.api.nvim_create_user_command('CycleTheme', cycle_themes, {})

-- require("vscode").setup({
--   -- Enable transparent background
--   transparent = true,
--
--   -- Enable italic comment
--   italic_comments = true,
-- })
