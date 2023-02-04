return {
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "tjdevries/colorbuddy.vim",
  "tjdevries/gruvbuddy.nvim",
  "stevearc/oil.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-ragtag",
  "tpope/vim-rsi",
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup()
    end,
  },
}
