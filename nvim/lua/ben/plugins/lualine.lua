return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local config = require("lualine")
    config.setup({
      style = "default",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "diff", "python_env" },
        lualine_x = { "diagnostics", "lsp", "spaces", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      options = {
        theme = 'auto',
        component_separators = { right = '', left = '' },
        section_separators = { right = '', left = '' },
      }
    })
  end
}
