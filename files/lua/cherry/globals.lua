local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
  reloader = plenary_reload.reload_module
end

P = function(v)
  vim.pretty_print(v)
  return v
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
