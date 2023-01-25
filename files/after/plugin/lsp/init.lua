vim.opt.signcolumn = "yes"

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "sumneko_lua", "rust_analyzer", "tsserver" } })
require("neodev").setup({})

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Enable go to definition triggered by <c-]>
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")

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
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("phplsp", {}),
  pattern = "*.php",
  callback = function()
    on_attach(nil, vim.api.nvim_get_current_buf())
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
  on_attach = on_attach,
})

lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.sorbet.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {},
  },
})
