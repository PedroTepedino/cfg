local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

luasnip.setup {

  -- Enable autotriggered snippets
  enable_autosnippets = true, 

  -- Use Tab (or some other key you  prefer) to trigger visual selection
  store_selection_keys = "<Tab>",

  -- Used to update repeated nodes on snippets 
  update_events = {"TextChanged", "TextChangedI"},
}

-- Keybinds

vim.cmd[[
  " Expand or jump in insert mode
  imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'

  " Jump forward through tabstops in visual mode
  smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

  " Jump backward through snippets tabstops with Shift-Tab  (for example)
  imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>' 
  smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>' 

  " Cycle forward through choice nodes with Control-f (for example)
  imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>' 
  smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>' 
]]


luasnip.filetype_extend("latex", {"tex"})
-- Load snippets

-- Load all snippets from the nvim/LuaSnip directory at startup
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
--- require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
