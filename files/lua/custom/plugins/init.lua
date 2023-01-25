return {
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "tjdevries/colorbuddy.vim",
  "tjdevries/gruvbuddy.nvim",
  "Mofiqul/vscode.nvim",
  "kyazdani42/nvim-web-devicons",
  "kdheepak/lazygit.nvim",
  "stevearc/oil.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-rsi",
  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("obsidian").setup({
        dir = "/Users/cherryramatis/Library/Mobile Documents/iCloud~md~obsidian/Documents/Brain",
        completion = {
          nvim_cmp = true,
        },
      })
    end,
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence"):setup()
    end,
  },
}
