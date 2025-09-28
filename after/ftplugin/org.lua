vim.pack.add {
  "https://github.com/nvim-orgmode/org-bullets.nvim",
}

if not pcall(require, "org-bullets") then
  return
end

require("org-bullets").setup()
