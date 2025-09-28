vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.foldmethod = 'indent'

vim.g.have_nerd_font = false

if vim.g.have_nerd_font then
  vim.opt.fillchars:append({ fold = " ", foldopen = "", foldclose = "", foldsep = " " })
else
  vim.opt.fillchars:append({ fold = " ", foldopen = "-",  foldclose = "+",  foldsep = " " })
end

function _G.SimpleFoldText()
  local fs, fe = vim.v.foldstart, vim.v.foldend
  local first = vim.fn.getline(fs):gsub("^%s*", ""):gsub("%s*$", "")
  if first == "" then first = "[blank]" end

  local lines = fe - fs + 1
  local total = vim.fn.line("$")
  local percent = math.floor((fe / math.max(1, total)) * 100)

  local icon = (vim.g.have_nerd_font and "") or ">"
  local left  = (" " .. icon .. " " .. first .. " ")
  local right = (" " .. lines .. " lines · " .. percent .. "% ")

  local width = vim.api.nvim_win_get_width(0)
  local fillcount = (width - vim.fn.strdisplaywidth(left) - vim.fn.strdisplaywidth(right)) / 2
  if fillcount < 1 then fillcount = 1 end
  return left .. string.rep("·", fillcount) .. right
end

vim.opt.foldtext = "v:lua.SimpleFoldText()"
