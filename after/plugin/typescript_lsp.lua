vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    callback = function(_ev)
        vim.pack.add({ { src = 'https://github.com/dmmulroy/ts-error-translator.nvim' } })

        local ok, ts = pcall(require, 'ts-error-translator')

        if not ok then
            return
        end

        ts.setup()

        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
            ts.translate_diagnostics(err, result, ctx)
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
        end
    end
})
