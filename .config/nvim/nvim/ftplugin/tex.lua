--[[ -- Use `am` and `im` for the inline math text object ]]
--[[ omap am <Plug>(vimtex-a$) ]]
--[[ xmap am <Plug>(vimtex-a$) ]]
--[[ omap im <Plug>(vimtex-i$) ]]
--[[ xmap im <Plug>(vimtex-i$) ]]
--[[]]
--[[ -- Use `ai` and `ii` for the item text object ]]
--[[ omap ai <Plug>(vimtex-am) ]]
--[[ xmap ai <Plug>(vimtex-am) ]]
--[[ omap ii <Plug>(vimtex-im) ]]
--[[ xmap ii <Plug>(vimtex-im) ]]

-- set default vimtex view to zathura
-- duplicate found on ../lua/user/options.lua
vim.g.vimtex_view_method = 'zathura_simple'

-- Set delimiters
vim.cmd 
[[
  let g:vimtex_delim_toggle_mod_list = [
    \ ['\left', '\right'],
    \ ['\big', '\big'],
    \]
]]

-- keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<leader>wc', '<Cmd>VimtexCountWords<CR>', opts)
 
keymap('n', '<localleader>c', '<Cmd>update<CR><Cmd>VimtexCompileSS<CR>', opts)

keymap('n', '<localleader>v', '<plug>(vimtex-view)', opts) 


