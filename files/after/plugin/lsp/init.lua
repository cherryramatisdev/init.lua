vim.opt.signcolumn = "yes"

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" } })
require("neodev").setup({})

local navic = require("nvim-navic")

local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.name ~= "null-ls" then
			navic.attach(client, bufnr)
		end

		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
-- 	group = vim.api.nvim_create_augroup("phplsp", {}),
-- 	pattern = "*.php",
-- 	callback = function()
-- 	end,
-- })

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
})

lspconfig.svelte.setup({
	capabilities = capabilities,
})

lspconfig.solargraph.setup({
	capabilities = capabilities,
})

-- lspconfig.sorbet.setup({
--   capabilities = capabilities,
-- })

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {},
	},
})
