require("neotest").setup({
	quickfix = {
		open = false,
	},
	adapters = {
		require("neotest-jest"),
		require("neotest-rspec"),
	},
})

vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end)

vim.keymap.set("n", "<leader>ta", function()
	require("neotest").run.attach()
end)

vim.keymap.set("n", "<leader>tS", function()
	require("neotest").run.stop()
end)

vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.open()
end)

vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open()
end)
