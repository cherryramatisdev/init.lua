vim.lsp.enable { "lua_ls", "ts_ls", "gopls", "rust_analyzer", "clangd", "expert", "pyright", "ocamllsp", "clojure_lsp" }

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if vim.snippet.active { direction = 1 } then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  else
    return "<c-k>"
  end
end, { desc = "Move to next jump on a snippet", expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if vim.snippet.active { direction = 1 } then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  else
    return "<c-j>"
  end
end, { desc = "Move to previous jump on a snippet", expr = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    client.server_capabilities.semanticTokensProvider = nil

    if client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    if client:supports_method "textDocument/codeLens" then
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
        group = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true }),
        callback = function()
          vim.lsp.codelens.refresh()
        end,
        buffer = args.buf,
      })
    end

    if client:supports_method "textDocument/onTypeFormatting" then
      vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
    end

    if client:supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()

      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    if Snacks then
      vim.keymap.set("n", "grr", function()
        Snacks.picker.lsp_references { layout = "dropdown" }
      end, { desc = "[LSP] Find references" })
      vim.keymap.set("n", "grd", Snacks.picker.lsp_definitions, { desc = "[LSP] Go to definition" })
      vim.keymap.set("n", "<c-w>grd", function()
        vim.cmd.wincmd "v"
        Snacks.picker.lsp_definitions()
      end, { desc = "[LSP] Go to definition" })
      vim.keymap.set("n", "gri", function()
        Snacks.picker.lsp_implementations { layout = "dropdown" }
      end, { desc = "[LSP] Go to implementation" })
      vim.keymap.set("n", "grt", function()
        Snacks.picker.lsp_type_definitions { layout = "dropdown" }
      end, { desc = "[LSP] Go to type definition" })
      vim.keymap.set("n", "gO", function()
        Snacks.picker.lsp_symbols { layout = "dropdown" }
      end, { desc = "[LSP] Search document symbols" })
      vim.keymap.set("n", "g<c-o>", function()
        Snacks.picker.lsp_workspace_symbols { layout = "dropdown" }
      end, { desc = "[LSP] Search workspace symbols" })
    else
      vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "[LSP] Go to definition" })
      vim.keymap.set("n", "<c-w>grd", function()
        vim.cmd.wincmd "v"
        vim.lsp.buf.definition()
      end, { desc = "[LSP] Go to definition" })
    end

    vim.keymap.set("n", "grq", function()
      vim.diagnostic.setqflist {}
    end, { desc = "[Diagnostics] Set quickfix list with diagnostics" })

    vim.keymap.set("n", "grl", vim.lsp.codelens.run, { desc = "[LSP] Run any codelens available on the current line" })
  end,
})
