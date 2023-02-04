return {
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		version = "1.*",
	},

	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-q>]],
				direction = "float",
			})
		end,
	},
}
