local M = {}

-- Be shure to explicitly define these LuaSnip node abbreviations!
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

function M.in_mathzone() -- math coontext detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

function M.in_text()
  return not M.get_visual()
end

function M.in_comment() -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end

function M.in_env(name) -- generic environment detection
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- A few concrete environments --- adapt as needed
function M.in_equation() -- equation environment detection
  return M.in_env('equation')
end

function M.in_itemize() -- itemize environment detection
  return M.in_env('itemize')
end

function M.in_equation() -- TikZ environment detection
  return M.in_env('tikzpicture')
end

return M
