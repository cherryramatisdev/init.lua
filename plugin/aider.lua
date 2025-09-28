--- Description: This aims to be a simple wrapper around aider.
--- Philosophy: The user should be aider directly through the terminal buffer as much as possible, we just want to provide light functionality around it, not replace its UI.

vim.g.aider_cmd = "aichat"

local function is_buffer_visible(bufnr)
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return true
    end
  end
  return false
end

local function get_aider_buffer()
  local buffers = vim.api.nvim_list_bufs()
  ---@type {buf: number, name: string}|nil
  local aider_buffer = nil

  for _, buf in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buf)
    if string.find(name, vim.g.aider_cmd) ~= nil then
      aider_buffer = { buf = buf, name = name }
    end
  end

  return aider_buffer
end

---@param job_id number Can be retrieved through vim.api.nvim_buf_get_var(buf, 'terminal_job_id')
---@param cmd string
local function send_command_to_aider(job_id, cmd)
  local meta_enter_sequence = "\x1b\r"
  vim.api.nvim_chan_send(job_id, cmd .. meta_enter_sequence)
end

---@param cmds string[]
local function run_aider_command(cmds)
  local aider_buffer = get_aider_buffer()

  if not aider_buffer then
    vim.notify("You must first open an aider session by pressing <leader>aa", vim.log.levels.ERROR)
    return
  end

  local job_id = vim.api.nvim_buf_get_var(aider_buffer.buf, "terminal_job_id")

  send_command_to_aider(job_id, vim.fn.join(cmds, " "))
end

vim.keymap.set("n", "<leader>aa", function()
  local aider_buffer = get_aider_buffer()
  local original_win = vim.api.nvim_get_current_win()

  local small_vertical_window_cmd = "vert botright 70vsplit"

  if not aider_buffer then
    vim.cmd(small_vertical_window_cmd .. " | term " .. vim.g.aider_cmd)
    vim.api.nvim_set_current_win(original_win)
    return
  end

  if is_buffer_visible(aider_buffer.buf) then
    local winid = vim.fn.bufwinnr(aider_buffer.buf)

    vim.api.nvim_win_close(vim.fn.win_getid(winid), false)
    return
  end

  vim.cmd(small_vertical_window_cmd)
  vim.cmd.b(aider_buffer.name)
  vim.api.nvim_set_current_win(original_win)
end, { desc = "[AI] Toggle aider buffer" })

vim.keymap.set("n", "<leader>af", function()
  run_aider_command { "/add", vim.fn.expand "%:p" }
end, { desc = "[AI] Add current file to aider session" })

vim.keymap.set("n", "<leader>ad", function()
  run_aider_command { "/drop", vim.fn.expand "%:p" }
end, { desc = "[AI] Drop current file from aider session" })

vim.keymap.set({"n", "v"}, "<leader>ak", function()
  local ts_utils = require "ts_utils"

  local node_result = ts_utils:find_ts_parent_node_at_cursor()

  if not node_result.ok then
    vim.notify(node_result.error)
    return
  end

  local start_row, start_col, end_row, end_col = node_result.node:range()
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)

  -- NOTE: Adjust first and last lines based on columns
  if #lines > 0 then
    lines[1] = string.sub(lines[1], start_col + 1)
    if #lines > 1 then
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
    else
      lines[1] = string.sub(lines[1], 1, end_col - start_col)
    end
  end

  local block_text = table.concat(lines, "\n")
  local filename = vim.fn.expand "%:p"

  vim.ui.input({
    prompt = "Question about this code block: ",
  }, function(input)
    if not input or input == "" then
      return
    end

    run_aider_command { "/ask", input, string.format("\n\nContext from: %s:\n\n```\n%w\n```", filename, block_text) }
  end)
end, { desc = "[AI] Ask a question about the current block" })

vim.keymap.set("n", "<leader>aD", function()
  run_aider_command({"/drop"})
end, { desc = "[AI] Drop all files from aider session" })

vim.keymap.set("n", "<leader>aq", function()
  vim.ui.select({ "yes", "no" }, {
    prompt = "Are you sure you want to quit the session?",
  }, function(choice)
    if choice == "yes" then
      local aider_buffer = get_aider_buffer()

      if not aider_buffer then
        vim.notify("You must first open an aider session by pressing <leader>aa", vim.log.levels.ERROR)
        return
      end

      run_aider_command({"/quit"})
      vim.api.nvim_buf_delete(aider_buffer.buf, { force = true })
    end
  end)
end, { desc = "[AI] Drop all files from aider session" })
