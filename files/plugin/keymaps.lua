vim.keymap.set("n", "<Tab>", ":tabp<cr>")
vim.keymap.set("n", "<S-Tab>", ":tabn<cr>")

vim.keymap.set("n", "<leader>g", function ()
  vim.cmd [[TermExec cmd=lazygit]]
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-c>", function()
	require("colorizer").color_picker_on_cursor()
end)

vim.keymap.set('n', '<leader>s', [[:s/\w\+/\=v:lua.string.format('%s', submatch(0))/g]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<right>", [[<C-w><]])
vim.keymap.set("n", "<left>", [[<C-w>>]])
vim.keymap.set("n", "<up>", [[<C-w>+]])
vim.keymap.set("n", "<down>", [[<C-w>-]])
