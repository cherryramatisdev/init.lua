if vim.fn.executable "rg" == 1 then
  function _G.RgFindFiles(cmdarg, _cmdcomplete)
    local fnames = vim.fn.systemlist 'rg --files --hidden --color=never --glob="!.git"'
    if #cmdarg == 0 then
      return fnames
    else
      return vim.fn.matchfuzzy(fnames, cmdarg)
    end
  end

  vim.o.findfunc = "v:lua.RgFindFiles"
  vim.o.grepprg = [[rg --vimgrep]]
end

local function get_cmdline_type()
  return vim.fn.split(vim.fn.getcmdline(), " ")[1]
end

local function is_cmdline_type_find()
  local cmdline_cmd = get_cmdline_type()

  return cmdline_cmd == "find" or cmdline_cmd == "fin"
end

vim.api.nvim_create_autocmd({ "CmdlineChanged", "CmdlineLeave" }, {
  pattern = { "*" },
  group = vim.api.nvim_create_augroup("CmdlineAutocompletion", { clear = true }),
  callback = function(ev)
    local function should_enable_autocomplete()
      local cmdline_cmd = vim.fn.split(vim.fn.getcmdline(), " ")[1]
      local cmdline_type = vim.fn.getcmdtype()

      return cmdline_type == "/"
        or cmdline_type == "?"
        or (
          cmdline_type == ":"
          and (
            is_cmdline_type_find()
            or cmdline_cmd == "help"
            or cmdline_cmd == "h"
            or cmdline_cmd == "buffer"
            or cmdline_cmd == "b"
          )
        )
    end

    if ev.event == "CmdlineChanged" and should_enable_autocomplete() then
      vim.opt.wildmode = "noselect:lastused,full"
      vim.fn.wildtrigger()
    end

    if ev.event == "CmdlineLeave" then
      vim.opt.wildmode = "full"
    end
  end,
})

vim.keymap.set("n", "<leader>f", ":find<space>", { desc = "[Fuzzy] find files" })
vim.keymap.set("n", "<leader>b", ":b<space>", { desc = "[Fuzzy] find buffers" })
vim.keymap.set("n", "<leader>/", ":silent grep<space>", { desc = "[Grep] for something" })
vim.keymap.set("n", "<leader>?", ":silent grep <c-r><c-w><cr>", { desc = "[Grep] for current word" })
vim.keymap.set("v", "<leader>?", [["ay:silent grep '<C-r>a'<cr>]], { desc = "[Grep] for visual selection" })

vim.keymap.set("c", "<m-e>", "<home><s-right><c-w>edit<end>", { desc = "Change command to :edit" })
vim.keymap.set("c", "<m-f>", "<home><s-right><c-w>find<end>", { desc = "Change command to :find" })
vim.keymap.set("c", "<m-d>", function()
  local cmdline_type = get_cmdline_type()
  if not (is_cmdline_type_find() or cmdline_type == "edit" or cmdline_type == "e") then
    vim.notify("This binding should be used with :find or with :edit", vim.log.levels.ERROR)
    return
  end

  local cmdline_arg = vim.fn.split(vim.fn.getcmdline(), " ")[2]

  if vim.uv.fs_realpath(vim.fn.expand(cmdline_arg)) == nil then
    vim.notify("The second argument should be a valid path", vim.log.levels.ERROR)
    return
  end

  local keys = vim.api.nvim_replace_termcodes("<C-U>edit " .. vim.fs.dirname(cmdline_arg), true, true, true)
  vim.fn.feedkeys(keys, "c")
end, { desc = "Edit the dir for the path" })

vim.keymap.set("c", "<c-v>", "<home><s-right><c-w>vs<end>", { desc = "Change command to :vs" })
vim.keymap.set("c", "<c-s>", "<home><s-right><c-w>sp<end>", { desc = "Change command to :sp" })
vim.keymap.set("c", "<c-t>", "<home><s-right><c-w>tabe<end>", { desc = "Change command to :tabe" })
vim.keymap.set(
  "c",
  "<c-space>",
  "<home><s-right><c-w>EditWindowFloat<end>",
  { desc = "Change command to :EditWindowFloat" }
)
