return {
	-- LSP Config
	"folke/neodev.nvim",
	"neovim/nvim-lspconfig",

	-- Installer
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"onsails/lspkind-nvim",
	{
		"Kasama/nvim-custom-diagnostic-highlight",
		config = true,
	},
	{
		"zbirenbaum/copilot.lua",
		config = true,
	},
	{
		"zbirenbaum/copilot-cmp",
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
