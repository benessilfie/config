return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    neoscroll = require('neoscroll')
    neoscroll.setup({
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil,       -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
    })


    -- DEPRECATED: This is the old way of setting up the mappings------------------
    -- local t = {}
    -- -- Syntax: t[keys] = {function, {function arguments}}
    -- t['zk'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450' } }
    -- t['zj'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450' } }
    -- require('neoscroll.config').set_mappings(t)
    --------------------------------------------------------------------------------

    local keymap = {
      ["zk"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
      ["zj"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
    }

    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end
}
