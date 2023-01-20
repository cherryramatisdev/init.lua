vim.keymap.set("n", "<Tab>", ":tabp<cr>")
vim.keymap.set("n", "<S-Tab>", ":tabn<cr>")

vim.keymap.set("n", "<leader>g", ":LazyGit<cr>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])