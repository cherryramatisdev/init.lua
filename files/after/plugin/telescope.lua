local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-s>", builtin.live_grep, {})
vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
vim.keymap.set("n", "<leader>r", builtin.resume, {})

require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>o", function()
	builtin.find_files({ prompt_title = "~ Dotfiles ~", cwd = "~/.config/nvim" })
end)
