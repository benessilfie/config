return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      on_open = function(term)
        vim.opt_local.spell = false
      end,
      size = function(term)
        if term.direction == 'horizontal' then
          return 25
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    },
  },
}
