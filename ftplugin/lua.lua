vim.keymap.set("n", "c<cr>", function()
  vim.cmd("silent ! " .. vim.fn.stdpath "data" .. "/mason/bin/stylua " .. vim.fn.expand "%")
end, { buffer = true })
