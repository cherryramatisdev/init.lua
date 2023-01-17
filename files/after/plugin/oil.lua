require("oil").setup({
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	buf_options = {},
	win_options = {
		wrap = false,
		signcolumn = "no",
		cursorcolumn = false,
		foldcolumn = "0",
		spell = false,
		list = false,
		conceallevel = 3,
		concealcursor = "n",
	},
	restore_win_options = true,
	skip_confirm_for_simple_edits = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-v>"] = "actions.select_vsplit",
		["<C-s>"] = "actions.select_split",
		["<C-p>"] = "actions.preview",
		["<Esc>"] = "actions.close",
		["q"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["g."] = "actions.toggle_hidden",
	},
	-- Set to false to disable all of the above keymaps
	use_default_keymaps = false,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
})

vim.keymap.set('n', '-', ':Oil<cr>')
vim.keymap.set('n', '<leader>e', ':Oil .<cr>')
