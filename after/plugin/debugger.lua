vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.pack.add {
      { src = "https://github.com/mfussenegger/nvim-dap" },
      { src = "https://github.com/rcarriga/nvim-dap-ui" },
      { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
      { src = "https://github.com/leoluz/nvim-dap-go" },
      { src = "https://github.com/mxsdev/nvim-dap-vscode-js" },
    }

    local ok_dap, dap = pcall(require, "dap")
    if not ok_dap then
      return
    end

    -- Setup DAP UI
    local ok_dapui, dapui = pcall(require, "dapui")
    if ok_dapui then
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end

    -- Setup virtual text
    local ok_vtext, dap_vtext = pcall(require, "nvim-dap-virtual-text")
    if ok_vtext then
      dap_vtext.setup()
    end

    -- Setup Go debugging
    if vim.bo.filetype == "go" then
      local ok_dap_go, dap_go = pcall(require, "dap-go")
      if ok_dap_go then
        dap_go.setup()
      end
    end

    -- Setup JavaScript/React debugging
    if vim.tbl_contains({ "javascript", "javascriptreact", "typescript", "typescriptreact" }, vim.bo.filetype) then
      local ok_dap_vscode_js, dap_vscode_js = pcall(require, "dap-vscode-js")
      if ok_dap_vscode_js then
        dap_vscode_js.setup {
          debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        }

        for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-chrome",
              request = "launch",
              name = "Start Chrome with localhost",
              url = "http://localhost:3000",
              webRoot = "${workspaceFolder}",
              userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
            },
          }
        end
      end
    end

    -- Keymaps
    vim.keymap.set("n", "<Leader>dc", dap.continue, { buffer = true })
    vim.keymap.set("n", "<Leader>do", dap.step_over, { buffer = true })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { buffer = true })
    vim.keymap.set("n", "<Leader>dO", dap.step_out, { buffer = true })
    vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { buffer = true })
    vim.keymap.set("n", "<Leader>B", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { buffer = true })
    vim.keymap.set("n", "<Leader>dr", dap.repl.open, { buffer = true })
    vim.keymap.set("n", "<Leader>dl", dap.run_last, { buffer = true })
  end,
})
