local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local function rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

local function clamp(value, min, max)
  return math.max(min, math.min(max, value))
end

local function darken(hex, amount)
  amount = amount or 0.1
  local r, g, b = hex_to_rgb(hex)
  r = clamp(math.floor(r * (1 - amount)), 0, 255)
  g = clamp(math.floor(g * (1 - amount)), 0, 255)
  b = clamp(math.floor(b * (1 - amount)), 0, 255)
  return rgb_to_hex(r, g, b)
end

local function lighten(hex, amount)
  amount = amount or 0.1
  local r, g, b = hex_to_rgb(hex)
  r = clamp(math.floor(r + (255 - r) * amount), 0, 255)
  g = clamp(math.floor(g + (255 - g) * amount), 0, 255)
  b = clamp(math.floor(b + (255 - b) * amount), 0, 255)
  return rgb_to_hex(r, g, b)
end

local function uniform_text_fg()
  local bg, fg

  if vim.o.background == 'light' then
    bg = '#fdf6e3'
    fg = '#b35c00'
  else
    bg = '#282828'
    fg = '#ffaf00'
  end

  -- Your base UI
  vim.api.nvim_set_hl(0, 'Normal',      { bg = bg, fg = fg })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = bg, fg = fg })
  vim.api.nvim_set_hl(0, 'Pmenu',       { bg = bg, fg = fg })

  -- Canonical Vim syntax groups to treat as "text"
  local base = {
    Comment = true, Constant = true, String = true, Character = true, Number = true, Boolean = true, Float = true,
    Identifier = true, Function = true, Statement = true, Conditional = true, Repeat = true, Label = true,
    Operator = true, Keyword = true, Exception = true, PreProc = true, Include = true, Define = true,
    Macro = true, PreCondit = true, Type = true, StorageClass = true, Structure = true, Typedef = true,
    Special = true, SpecialChar = true, Tag = true, Delimiter = true, SpecialComment = true, Debug = true,
    Underlined = true, Error = true, Todo = true,
  }

  local groups = vim.fn.getcompletion('', 'highlight')
  for _, name in ipairs(groups) do
    -- Text-ish buckets: Tree-sitter (@...), classic syntax, LSP/Diagnostics
    if name:match('^@') or base[name] or name:match('^Diagnostic') or name:match('^Lsp') then
      local ok, def = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
      local new = { fg = fg }

      if name == '@comment' then
          new = { fg = darken(fg, 0.3) }
      end

      if ok then
        if def.bg then new.bg = def.bg end
        if def.bold then new.bold = def.bold end
        if def.italic then new.italic = def.italic end
        if def.underline then new.underline = def.underline end
        if def.undercurl then new.undercurl = def.undercurl end
        if def.strikethrough then new.strikethrough = def.strikethrough end
        if def.reverse then new.reverse = def.reverse end
      end
      pcall(vim.api.nvim_set_hl, 0, name, new)
    end
  end
end

-- Re-apply when the halloweny colorscheme is set
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('UniformTextFg', { clear = true }),
  pattern = 'halloweny',
  callback = uniform_text_fg,
})

-- Apply now on startup
uniform_text_fg()
