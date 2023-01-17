-- splitjoin
vim.g.splitjoin_split_mapping = ""
vim.g.splitjoin_join_mapping = ""
vim.keymap.set("n", "gj", ":SplitjoinSplit<cr>")
vim.keymap.set("n", "gk", ":SplitjoinJoin<cr>")

-- sideways
vim.keymap.set("n", "gj", ":SplitjoinSplit<cr>")
vim.keymap.set("n", "<c-h>", ":SidewaysLeft<cr>")
vim.keymap.set("n", "<c-l>", ":SidewaysRight<cr>")
vim.keymap.set({ "o", "x" }, "aa", "<Plug>SidewaysArgumentTextobjA")
vim.keymap.set({ "o", "x" }, "ia", "<Plug>SidewaysArgumentTextobjI")
