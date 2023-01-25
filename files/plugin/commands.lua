vim.api.nvim_create_user_command("Base16Editor", function()
  require("base16.editor").open()
end, {})
