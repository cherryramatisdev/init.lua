vim.keymap.set("n", "c<cr>", function()
    vim.lsp.buf.format();
end, { buffer = true })
