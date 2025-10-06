vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
  pattern = "*",
  callback = function()
    if #vim.fn.getqflist() > 0 then
      vim.cmd [[ copen ]]
    else
      vim.cmd [[ cclose ]]
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local idx = vim.fn.line "."
      local qflist = vim.fn.getqflist()
      table.remove(qflist, idx)
      vim.fn.setqflist(qflist, "r")
    end, { buffer = true })

    vim.keymap.set("v", "d", function()
      local start_line = vim.fn.line "v"
      local end_line = vim.fn.line "."
      local qflist = vim.fn.getqflist()

      for i = math.max(end_line, start_line), math.min(end_line, start_line), -1 do
        table.remove(qflist, i)
      end

      vim.fn.setqflist(qflist, "r")
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "v")
    end, { buffer = true })
  end,
})
