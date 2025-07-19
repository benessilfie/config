return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Helper function for LSP status
    local function lsp_status()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if #clients == 0 then
        return 'No LSP'
      end

      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return table.concat(names, ', ')
    end

    require('lualine').setup {
      options = {
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha', 'starter' },
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1) -- Show only first character
            end,
          },
        },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
          {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          },
        },
        lualine_c = {
          {
            'filename',
            path = 0, -- 0: just filename, 1: relative path, 2: absolute path
            shorting_target = 40,
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
            },
          },
        },
        lualine_x = {
          {
            lsp_status,
            -- icon = ' LSP:',
            -- color = { fg = '#ffffff', gui = 'bold' },
          },
          -- 'encoding',
          {
            'fileformat',
            symbols = {
              unix = '', -- or 'LF'
              dos = '', -- or 'CRLF'
              mac = '', -- or 'CR'
            },
          },
          'filetype',
        },
        lualine_y = {
          'progress',
          {
            'searchcount',
            maxcount = 999,
            timeout = 500,
          },
        },
        lualine_z = {
          'location',
          {
            function()
              return os.date '%R' -- Show current time
            end,
            color = { fg = '#ffffff', gui = 'bold' },
          },
        },
      },
    }
  end,
}
