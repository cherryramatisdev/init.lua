vim.cmd.highlight('StatusLine guibg=NONE')

local function status_diagnostic()
  local diagnostics = vim.diagnostic.get(vim.api.nvim_get_current_buf())
  local error_count = 0
  local warn_count = 0
  local info_count = 0
  local hint_count = 0

  for _, v in ipairs(diagnostics) do
    if v.severity == vim.diagnostic.severity.ERROR then
      error_count = error_count + 1
    end

    if v.severity == vim.diagnostic.severity.WARN then
      warn_count = warn_count + 1
    end

    if v.severity == vim.diagnostic.severity.INFO then
      info_count = info_count + 1
    end

    if v.severity == vim.diagnostic.severity.HINT then
      hint_count = hint_count + 1
    end
  end

  return string.format('🛑%s ⚠️ %s ℹ️ %s 💡%s', error_count, warn_count, info_count, hint_count)
end

require("el").setup({
  generator = function()
    local el_segments = {}

    local extensions = require("el.extensions")

    table.insert(el_segments, extensions.mode)

    table.insert(el_segments, '%=')

    table.insert(el_segments, status_diagnostic)

    table.insert(el_segments, '%=')

    table.insert(el_segments, extensions.git_changes)

    return el_segments
  end,
})
