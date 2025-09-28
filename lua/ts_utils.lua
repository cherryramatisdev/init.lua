local treesit_utils = require "nvim-treesitter.ts_utils"

local M = {}

---@param node TSNode|nil
---@param target_node_types string[]
---@return {ok: true, node: TSNode} | {ok: false, error: string}
---This function goes up the tree until it found any of the `target_node_types` and fails if there's no more parent to go.
local function find_target_parent_node(node, target_node_types)
  if not node then
    return { ok = false, error = "No treesitter node found at cursor" }
  end

  local node_type = node:type()
  if vim.tbl_contains(target_node_types, node_type) then
    return { ok = true, node = node }
  end

  return find_target_parent_node(node:parent(), target_node_types)
end

---@return {ok: true, node: TSNode} | {ok: false, error: string}
function M:find_ts_parent_node_at_cursor()
  local node = treesit_utils.get_node_at_cursor()

  if not node then
    return { ok = false, error = "No treesitter found at cursor" }
  end

  return find_target_parent_node(node, {
    "function_declaration",
    "function_definition",
    "method_definition",
    "class_declaration",
    "class_definition",
    "function",
    "method",
    "arrow_function",
    "function_expression",
    "lexical_declaration",
    "variable_declaration",
    "if_statement",
    "for_statement",
    "while_statement",
    "do_statement",
    "switch_statement",
    "try_statement",
  })
end

return M
