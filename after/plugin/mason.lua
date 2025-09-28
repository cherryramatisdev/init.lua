vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("mason-lsp-setup", { clear = true }),
  callback = function()
    vim.pack.add { "https://github.com/mason-org/mason.nvim" }

    if not pcall(require, "mason") then
      return
    end

    require("mason").setup()
  end,
})
