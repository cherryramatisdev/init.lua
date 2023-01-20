return {
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "tjdevries/colorbuddy.vim",
  "tjdevries/gruvbuddy.nvim",
  "kyazdani42/nvim-web-devicons",
  "kdheepak/lazygit.nvim",
  "stevearc/oil.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup()
    end,
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  },
}
