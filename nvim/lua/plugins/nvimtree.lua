return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- vim.opt.termguicolors = true

    require('nvim-tree').setup {

      -- Custom keymaps only
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom h/l navigation
        vim.keymap.set('n', 'l', function()
          local node = api.tree.get_node_under_cursor()
          if node.nodes ~= nil then
            api.node.open.edit()
          else
            api.node.open.edit()
          end
        end, opts 'Open')

        vim.keymap.set('n', 'h', function()
          local node = api.tree.get_node_under_cursor()
          if node.nodes ~= nil and node.open then
            api.node.open.edit()
          else
            api.node.navigate.parent_close()
          end
        end, opts 'Close Directory')
      end,

      -- Auto-select current file when opening nvim-tree
      update_focused_file = {
        enable = true,
        update_root = false,
      },

      -- Only essential visual customizations
      view = {
        width = 30,
        side = 'left',
      },

      renderer = {
        root_folder_label = ':t',
      },
    }
  end,
}
