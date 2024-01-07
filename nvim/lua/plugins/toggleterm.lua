return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 16,
      direction = "horizontal",
      open_mapping = [[<c-\>]],
      autochdir = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      -- shade_filetypes = {},
      -- persist_size = false,
      -- close_on_exit = true,
      -- shell = vim.o.shell,
      -- float_opts = {
      --   border = "curved",
      --   winblend = 0,
      --   highlights = {
      --     border = "Normal",
      --     background = "Normal",
      --   },
      -- },
    })
  end,
}
