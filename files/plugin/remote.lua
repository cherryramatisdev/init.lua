if vim.fn.executable("nvr") then
	vim.g.GIT_EDITOR = [[nvr -cc tabnew --remote-wait +'set bufhidden=wipe']]
  vim.fn.setenv('GIT_EDITOR', [[nvr -cc tabnew --remote-wait +'set bufhidden=wipe']])
end
