-- vim.o.complete = ".,o"
-- vim.o.autocomplete = true
vim.opt.completeopt:append "noinsert,fuzzy,popup"
vim.o.pumheight = 7

vim.pack.add {
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range ">=1.7" },
}

if not pcall(require, "blink.cmp") then
  return
end

require("blink.cmp").setup {
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
}
