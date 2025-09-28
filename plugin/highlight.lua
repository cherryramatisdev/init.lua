vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { timeout = 60 }
  end,
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})
