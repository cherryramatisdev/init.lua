return {
	-- LSP Config
	"folke/neodev.nvim",
	"neovim/nvim-lspconfig",

	-- Auto configurable plugins
	{
		"akinsho/flutter-tools.nvim",
		config = function()
			require("flutter-tools").setup({})
		end,
	},

	-- Installer
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jay-babu/mason-null-ls.nvim",

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"dcampos/cmp-emmet-vim",
	"mattn/emmet-vim",
	"onsails/lspkind-nvim",
	{
		"Kasama/nvim-custom-diagnostic-highlight",
		config = true,
	},

	-- Snippets
	"L3MON4D3/LuaSnip",
	-- "rafamadriz/friendly-snippets",

	-- Formatter
	"jose-elias-alvarez/null-ls.nvim",

	-- Tests
	"nvim-neotest/neotest",
	"haydenmeade/neotest-jest",
	"olimorris/neotest-rspec",
}
