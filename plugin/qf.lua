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
