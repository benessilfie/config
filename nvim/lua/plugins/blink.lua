return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',

      -- Custom keymaps for better snippet navigation
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_next()
          end
        end,
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_backward()
          else
            return cmp.select_prev()
          end
        end,
        'fallback',
      },
    },

    appearance = {
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = false,
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300, -- Faster for Laravel completions
        window = {
          border = nil,
          scrollbar = false,
        },
      },
      menu = {
        border = nil,
        scrolloff = 1,
        scrollbar = false,
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
            { 'source_name' },
          },
        },
      },
    },

    sources = {
      default = { 'laravel', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        laravel = {
          name = 'laravel',
          module = 'laravel.blink_source',
          enabled = function()
            -- Enable Laravel completions for PHP, Blade, and when in Laravel projects
            local ft = vim.bo.filetype
            local is_laravel_file = ft == 'php' or ft == 'blade'
            local is_laravel_project = vim.fn.filereadable 'artisan' == 1 and vim.fn.filereadable 'composer.json' == 1

            -- Also enable for other files in Laravel projects (like JS, Vue, etc.)
            return is_laravel_file or is_laravel_project
          end,
          score_offset = 1000, -- Highest priority for Laravel completions
          min_keyword_length = 1,
          -- Configure Laravel-specific completion behavior
          transform_items = function(_, items)
            -- Add Laravel-specific icons and formatting
            for _, item in ipairs(items) do
              if item.source_name == 'laravel' then
                -- Add Laravel icon to Laravel completions
                if item.kind == require('blink.cmp.types').CompletionItemKind.Function then
                  item.label = '🔥 ' .. item.label
                elseif item.kind == require('blink.cmp.types').CompletionItemKind.File then
                  item.label = '📁 ' .. item.label
                elseif item.kind == require('blink.cmp.types').CompletionItemKind.Variable then
                  item.label = '⚙️ ' .. item.label
                end
              end
            end
            return items
          end,
        },
      },
    },

    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  },
}
