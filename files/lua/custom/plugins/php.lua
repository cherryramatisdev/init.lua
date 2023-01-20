return {
  {
    "gbprod/phpactor.nvim",
    config = function()
      require("phpactor").setup({
        install = {
          bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
        },
      })
    end,
  },
}
