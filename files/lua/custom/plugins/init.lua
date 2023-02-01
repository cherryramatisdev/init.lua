return {
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "tjdevries/colorbuddy.vim",
  "tjdevries/gruvbuddy.nvim",
  "Mofiqul/vscode.nvim",
  "kdheepak/lazygit.nvim",
  "stevearc/oil.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-rsi",
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup()
    end,
  },
}
