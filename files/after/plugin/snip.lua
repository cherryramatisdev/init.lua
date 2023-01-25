local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
  -- This tells luasnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,
  updateevents = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = { active = {
      virt_text = { { "<- Current Choice", "Comment" } },
    } },
  },
})

function _G.leave_snippet()
  if ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({ "i", "s" }, "<c-u>", require("luasnip.extras.select_choice"), { silent = true })

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/snip.lua<cr>")

local s = ls.s
local sn = ls.snippet_node
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local fn = ls.function_node
local dyn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("typescriptreact", { "typescript" })
ls.filetype_extend("javascript", { "typescript" })

local setterUseState = function(index)
  return fn(function(arg)
    local word = arg[1][1]
    local first_letter = string.sub(word, 1, 1)
    local rest = string.sub(word, 2)

    return first_letter:upper() .. rest
  end, { index })
end

local completeVariableLog = function(order, index)
  return dyn(order, function(arg)
    local choices = {}
    table.insert(choices, t(""))

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for _, line in ipairs(lines) do
      print(vim.inspect(arg[1][1]))
      if line:match(arg[1][1] .. " = ") then
        table.insert(choices, t(", " .. arg[1][1]))
      end
    end

    return sn(nil, c(1, choices))
  end, { index })
end

ls.add_snippets("ruby", {
  s(
    "desc",
    dyn(1, function()
      return sn(
        "",
        fmt("describe '{}' do" .. "\n" .. "{}\n" .. "end", {
          i(1),
          i(0),
        })
      )
    end)
  ),
  s(
    "it",
    dyn(1, function()
      return sn(
        "",
        fmt("it '{}' do" .. "\n" .. "{}\n" .. "end", {
          i(1),
          i(0),
        })
      )
    end)
  ),
})

ls.add_snippets("rust", {
  s(
    "log",
    fmt([[println!("{}"{})]], {
      i(1),
      completeVariableLog(2, 1),
    })
  ),
})

ls.add_snippets("typescript", {
  s("ust", fmt("const [{}, set{}] = useState({})", { i(1), setterUseState(1), i(0) })),
  s(
    "log",
    fmt([[console.log("{}"{})]], {
      i(1),
      completeVariableLog(2, 1),
    })
  ),
  s(
    "usf",
    dyn(1, function()
      return sn(
        "",
        fmt("const {} " .. "= useEffect(() => {{\n" .. "{}" .. "\n}}, [{}]);", {
          i(1),
          i(0),
          i(2),
        })
      )
    end)
  ),
})

ls.add_snippets("lua", {
  s(
    "req",
    fmt([[local {} = require"{}"]], {
      fn(function(import_name)
        local parts = vim.split(import_name[1][1], ".", nil)
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
})

ls.add_snippets("ruby", {
  s("fsl", t("# frozen_string_literal: true")),
  s("type", t("# typed: true")),
})

ls.add_snippets("php", {
  s(
    "fun",
    fmt(
      "{} function {}({}) {{\n" .. "{}\n" .. "}}",
      { c(1, { t("public"), t("private"), t("protected") }), i(2), i(3), i(0) }
    )
  ),
})

ls.add_snippets("all", {
  s("todo", {
    c(1, {
      t("TODO"),
      t("FIXME"),
      t("TODONT"),
      t("CHERRY"),
    }),
  }),
})
