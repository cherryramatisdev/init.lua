vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = '*',
    callback = function()
        vim.pack.add { { src = "https://github.com/chomosuke/term-edit.nvim" } }
        if not pcall(require, 'term-edit') then
            return
        end

        require'term-edit'.setup { prompt_end = "%λ " }
    end
})
