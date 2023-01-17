require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
