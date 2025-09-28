vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("vim-test-setup", { clear = true }),
  callback = function()
    vim.pack.add({
      { src = "https://github.com/vim-test/vim-test" },
    }, { load = true })

    vim.cmd [[ 
        let test#strategy = "neovim_sticky"
        let test#neovim_sticky#reopen_window = 1
        ]]

    vim.keymap.set("n", "<leader>tt", ":TestNearest<cr>", { desc = "Test the current it case" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<cr>", { desc = "Test the whole file" })
  end,
})
