vim.pack.add({
  { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim", branch = "main", load = true },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
}, { load = true })

if not pcall(require, "CopilotChat") then
  return
end

local chat = require "CopilotChat"
local user = vim.env.USER
local genplat_url = vim.env.IFOOD_BASE_URL
local genplat_api_key = vim.env.IFOOD_API_KEY

chat.setup {
  answer_header = "  genplat ",
  auto_insert_mode = false,
  model = "qwen3-coder-480b-a35b-i",
  question_header = "  " .. user .. " ",
  sticky = { "#filenames", "#buffer", "$qwen3-coder-480b-a35b-i" },
  window = { width = 0.4 },
  providers = {
    genplat = {
      get_url = function(opts)
        return genplat_url .. "/chat/completions"
      end,
      get_headers = function()
        return { ["Authorization"] = "Bearer " .. genplat_api_key }
      end,
      get_models = function(headers)
        local response, err = require("CopilotChat.utils").curl_get(genplat_url .. "/models", {
          headers = headers,
          json_response = true,
        })
        if err then
          error(err)
        end
        return vim
          .iter(response.body.data)
          :map(function(model)
            return { id = model.id, name = model.id }
          end)
          :totable()
      end,
      prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
      prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
    },
    github_models = { disabled = true },
  },
}

-- Keybindings
vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "+ai" })
vim.keymap.set({ "n", "v" }, "<leader>aa", chat.toggle, { desc = "Toggle (CopilotChat)" })
vim.keymap.set({ "n", "v" }, "<leader>ax", chat.reset, { desc = "Clear (CopilotChat)" })
vim.keymap.set({ "n", "v" }, "<leader>aq", function()
  vim.ui.input({ prompt = "Quick Chat: " }, function(input)
    if input ~= "" then
      chat.ask(input)
    end
  end)
end, { desc = "Quick Chat (CopilotChat)" })
vim.keymap.set({ "n", "v" }, "<leader>ap", function()
  require("CopilotChat").select_prompt()
end, { desc = "Prompt Actions (CopilotChat)" })

vim.keymap.set({ "n", "v" }, "<leader>acf", function()
  Snacks.picker.files {
    prompt = "Add file to context (CopilotChat)",
    actions = {
      confirm = function(self, item)
        if item then
          chat.open()
          chat.chat:add_sticky("#file:" .. item.file)
          self:close()
          return
        end
      end,
    },
  }
end, { desc = "Context: add filename" })

vim.keymap.set({ "n", "v" }, "<leader>acb", function()
  chat.open()
  chat.chat:add_sticky "#buffers"
end, { desc = "Context: add buffers" })

-- Buffer-specific settings
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-chat",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})
