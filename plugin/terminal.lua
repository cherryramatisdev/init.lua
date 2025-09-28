vim.keymap.set("n", "<LocalLeader>t", ":term<cr>")

vim.keymap.set("n", "<LocalLeader>T", function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_option_value("bufhidden", "hide", { scope = "local", buf = buf })
  vim.api.nvim_set_option_value("filetype", "terminal", { scope = "local", buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { scope = "local", buf = buf })

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local ui = vim.api.nvim_list_uis()[1]

  local col = math.floor((ui.width - (width + 2)) / 2)
  local row = math.floor((ui.height - (height + 2)) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width - 4,
    height = height - 2,
    col = col,
    row = row,
    style = "minimal",
    border = "single",
  })

  vim.fn.jobstart({ vim.o.shell }, { term = true })
end)

vim.keymap.set("n", "<leader><leader>ot", function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_option_value("bufhidden", "hide", { scope = "local", buf = buf })
  vim.api.nvim_set_option_value("filetype", "terminal", { scope = "local", buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { scope = "local", buf = buf })

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local ui = vim.api.nvim_list_uis()[1]

  local col = math.floor((ui.width - (width + 2)) / 2)
  local row = math.floor((ui.height - (height + 2)) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width - 4,
    height = height - 2,
    col = col,
    row = row,
    style = "minimal",
    border = "single",
  })

  vim.fn.jobstart({ "vit" }, { term = true })
end)

vim.api.nvim_create_autocmd({ "TermEnter" }, {
  group = vim.api.nvim_create_augroup("terminal-setup", { clear = true }),
  callback = function()
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("terminal-close-without-prompt", { clear = true }),
  callback = function()
    vim.schedule(function()
      if vim.bo.buftype == "terminal" and vim.v.shell_error == 0 then
        vim.cmd("bdelete! " .. vim.fn.expand "<abuf>")
      end
    end)
  end,
})
