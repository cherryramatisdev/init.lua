vim.api.nvim_create_user_command('FocusWriting', function()
    vim.pack.add({
        { src = 'https://github.com/folke/zen-mode.nvim' },
    })

    vim.pack.add({
        { src = 'https://github.com/reedes/vim-pencil' }
    }, { load = true })

    require 'zen-mode'.setup {}
    require 'zen-mode'.toggle()
    vim.cmd [[ SoftPencil ]]
end, {})
