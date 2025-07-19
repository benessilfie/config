-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 400, -- 400ms second delay - adjust to your preference
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = require('config.icons').which_key,
    },

    -- Document existing key chains with proper organization
    spec = {
      -- Keep your sensible defaults for main groups
      { '<leader>b', group = 'Buffers' },
      { '<leader>d', group = 'Debug' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>l', group = 'LSP' },
      { '<leader>m', group = 'Markdown' },
      { '<leader>p', group = 'Panes' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>u', group = 'UI' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>h', group = 'Git Hunk', mode = { 'v' } },

      -- For the rest, we'll organize them as we identify them
      -- Send me screenshots of the other groups and I'll help organize them properly
    },
  },
}
