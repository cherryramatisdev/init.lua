vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufRead", "BufNewFile" }, {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    callback = function(_ev)
        vim.keymap.set('n', 'c<cr>', ':! npx prettier -w %<cr>', { buffer = true })
        vim.cmd [[ compiler nxlint ]]
    end
})
