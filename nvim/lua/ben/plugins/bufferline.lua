return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        --   mode = "tabs", -- buffers | tabs
        numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both"
        style_preset = bufferline.style_preset.default,
        close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        max_name_length = 18,
        show_tab_indicators = true,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true,  -- whether or not tab names should be truncated
        --   tab_size = 18,
        diagnostics = "nvim_lsp",
        --   diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or ""
          return " " .. icon
        end,
        offsets = {
          {
            filetype = "Neotree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
            padding = 1
          },
        },
      }
    })
  end,
}
