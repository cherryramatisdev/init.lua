return {
	{
		"norcalli/nvim-colorizer.lua",
    branch = 'color-editor',
		config = function()
			require("colorizer").setup({
				"*",
			})
		end,
	},
	{
		"norcalli/nvim-terminal.lua",
		config = function()
			require("terminal").setup()
		end,
	},
	{ "norcalli/nvim-base16.lua", branch = "theme-editor" },
}
