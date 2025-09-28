-- TODO: how to make this work when i dont have snacks, but also be immediately enabled once nvim loads?
--
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end
vim.print = _G.dd
