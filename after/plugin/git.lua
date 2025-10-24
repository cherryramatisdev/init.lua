vim.pack.add({
  { src = "https://github.com/rhysd/committia.vim" },
  { src = "https://github.com/cherryramatisdev/CTRLGGitBlame.vim" },
}, { load = true })

vim.pack.add {
  "https://github.com/akinsho/git-conflict.nvim",
}

if not pcall(require, "git-conflict") then
  return
end

require("git-conflict").setup {}
