vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = vim.api.nvim_create_augroup("YankHighlight", {}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Substitute", timeout = 150, on_macro = true })
	end,
})
