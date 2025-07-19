-- Bufferline - VSCode-like tabs for open buffers
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  keys = {
    { '<leader>bb', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous' },
    { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = 'Next' },
    { '<leader>bd', '<cmd>BufferLineSortByDirectory<cr>', desc = 'Sort by directory' },
    { '<leader>be', '<cmd>BufferLinePickClose<cr>', desc = 'Pick which buffer to close' },
    { '<leader>bs', '<cmd>Telescope buffers<cr>', desc = 'Search' },
    {

      '<leader>bf',

      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,

      desc = 'Format',
    },
    { '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close all to the left' },
    { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Jump' },
    { '<leader>bl', '<cmd>BufferLineCloseRight<cr>', desc = 'Close all to the right' },
    { '<leader>bw', '<cmd>noautocmd w<cr>', desc = 'Save without formatting (noautocmd)' },

    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Toggle Pin' },
    { '<leader>bm', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Others' },
  },
  opts = {
    options = {
      mode = 'buffers',
      style_preset = 'default',
      themable = false,
      numbers = 'none',
      close_command = 'bdelete! %d',
      right_mouse_command = 'bdelete! %d',
      left_mouse_command = 'buffer %d',
      middle_mouse_command = nil,

      indicator = {
        icon = '▎',
        style = 'icon',
      },

      buffer_close_icon = '×',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',

      max_name_length = 30,
      max_prefix_length = 30,
      truncate_names = true,
      tab_size = 21,
      diagnostics = 'nvim_lsp',
      diagnostics_update_in_insert = false,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- Hide unnamed/empty buffers
        local buf_name = vim.fn.bufname(buf_number)
        local buf_ft = vim.bo[buf_number].filetype

        -- Filter out empty/unnamed buffers
        if buf_name == '' or buf_name == '[No Name]' then
          return false
        end

        -- Filter out specific filetypes you don't want to see
        local excluded_filetypes = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'alpha',
          'lir',
          'Outline',
          'spectre_panel',
          'toggleterm',
        }

        for _, ft in ipairs(excluded_filetypes) do
          if buf_ft == ft then
            return false
          end
        end

        return true
      end,

      offsets = {
        {
          filetype = 'NvimTree',
          -- text = '󰙅  File Explorer',
          separator = true,
          text_align = 'left',
        },
      },

      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      move_wraps_at_ends = false,
      separator_style = 'thin',
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
      sort_by = 'insert_after_current',
    },
  },
}
