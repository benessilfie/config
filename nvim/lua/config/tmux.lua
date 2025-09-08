--  Toggle tmux statusline
vim.fn.system 'tmux set-option status off'

vim.cmd [[
  augroup Nvim
    autocmd!
    autocmd VimLeavePre * silent !tmux set-option status on
  augroup END
]]
