-- From any snippet file, source `get_visual` from global helpper functions file
local helpers = require('user.luasnip-helper-functions')
local tex_utils = require('user.luasnip-utils')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  -- Combining text and insert nodes to create basic LaTeX commands
  s ({trig="tt", dscr="Expands 'tt' into '\texttt{}'"},
    fmta(
      "\\texttt{<>}",
      { i(1) }
    )
  ),
  s({trig = "eq", dscr = "A LaTeX equation environment"},
    fmta(
      [[
        \begin{equation}
          <>
        \end{equation}
      ]],
      { i(1) }
    )
  ),
  s({trig="env", snippetType="autosnippet"},
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        extras.rep(1),  -- this node repeats insert node i(1)
      }
    )
  ),
  s({trig = "hr", dscr="The hyperref package's href{}{} command (for url links)"},
  fmta(
      [[\href{<>}{<>}]],
      {
        i(1, "url"),
        i(2, "display name"),
      }
    )
  ),
  -- Example: italic font implementing visual selection 
 s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
    fmta("\\textit{<>}",
      {
        d(1, get_visual),
      }
    )
  ),
  s({trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>$<>$",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    )
  ),
  s({trig = '([^%a])ee', regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>e^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual)
      }
    )
  ),
  s({trig = '([^%a])ff', regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      [[<>\frac{<>}{<>}]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2)
      },
      { condition = tex_utils.in_mathzone }
    )
  ),
  s({trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType="autosnippet"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        t("0")
      }
    )
  ),
  s({trig = "h1", dscr="Top-level section"},
    fmta(
      [[\section*{<>}]],
      { i(1) }
    ),
    {condition = line_begin} -- set confition in the 'opts table'
  ),
  s({trig = "h2", dscr="Sub-section"},
    fmta(
      [[\subsection*{<>}]],
      { i(1) }
    ),
    {condition = line_begin}
  ),
  s({trig = "h3", dscr="Sub-section"},
    fmta(
      [[\subsubsection*{<>}]],
      { i(1) }
    ),
    {condition = line_begin}
  ),
  s({trig = "sec", dscr="Top-level section"},
    fmta(
      [[\section{<>}]],
      { i(1) }
    ),
    {condition = line_begin} -- set confition in the 'opts table'
  ),
  s({trig = "ssec", dscr="Sub-section"},
    fmta(
      [[\subsection{<>}]],
      { i(1) }
    ),
    {condition = line_begin}
  ),
  s({trig = "sssec", dscr="Sub-section"},
    fmta(
      [[\subsubsection{<>}]],
      { i(1) }
    ),
    {condition = line_begin}
  ),
  s({trig="new", dscr="A generic new environment"},
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
  s({trig = "dd"},
    fmta(
      "\\draw [<>] ",
      {
        i(1, "params"),
      }
    ),
    { condition = tex_utils.in_tikz }
  ),
  s({trig = "doc", snippetType="autosnippet"},
    fmta(
      "\\documentclass{<>}",
      {
        i(1, "class"),
      }
    ),
    {condition = line_begin}
  ),
  s({trig = "pkg", snippetType="autosnippet"},
    fmta(
      "\\usepackage[<>]{<>}",
      {
        i(2, "options"),
        i(1, "package")
      }
    )
  ),

} 
