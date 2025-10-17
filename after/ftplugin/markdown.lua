vim.api.nvim_create_user_command("FocusWriting", function()
  vim.pack.add {
    "https://github.com/folke/zen-mode.nvim",
  }

  vim.pack.add({
    { src = "https://github.com/reedes/vim-pencil" },
  }, { load = true })

  require("zen-mode").setup {}
  require("zen-mode").toggle()
  vim.cmd [[ SoftPencil ]]
end, {})

vim.pack.add {
  "https://github.com/hakonharnes/img-clip.nvim",
}

if not pcall(require, "img-clip") then
  return
end

require("img-clip").setup()

vim.keymap.set("n", "cp", function()
  require("img-clip").paste_image()
end, { buffer = true, desc = "Paste image from clipboard" })

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
}, { load = true })

if not pcall(require, "render-markdown") then
  return
end

require("render-markdown").setup {
  enabled = true,
  render_modes = { "n", "c", "t", "i" },
  completions = { blink = { enabled = true } },
}

vim.pack.add {
  "https://github.com/SCJangra/table-nvim",
}

if not pcall(require, "table-nvim") then
  return
end

require("table-nvim").setup {}
