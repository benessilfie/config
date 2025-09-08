return {
  {
    'adibhanna/laravel.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/snacks.nvim', -- Optional: for enhanced UI
    },
    event = { 'VimEnter' },
    keys = {
      { '<leader>la', ':Artisan<cr>', desc = 'Laravel Artisan' },
      { '<leader>lc', ':Composer<cr>', desc = 'Composer' },
      { '<leader>lr', ':LaravelRoute<cr>', desc = 'Laravel Routes' },
      { '<leader>lm', ':LaravelMake<cr>', desc = 'Laravel Make' },
      { '<leader>ls', ':LaravelStatus<cr>', desc = 'Laravel Status' },
      -- Dump viewer keymaps
      { '<leader>Ld', ':LaravelDumps<cr>', desc = 'Open Laravel Dump Viewer' },
      { '<leader>LDe', ':LaravelDumpsEnable<cr>', desc = 'Enable Dump Capture' },
      { '<leader>LDd', ':LaravelDumpsDisable<cr>', desc = 'Disable Dump Capture' },
      { '<leader>LDt', ':LaravelDumpsToggle<cr>', desc = 'Toggle Dump Capture' },
      { '<leader>LDc', ':LaravelDumpsClear<cr>', desc = 'Clear Dumps' },
      -- Composer management
      { '<leader>lcr', ':ComposerRequire<cr>', desc = 'Composer Require Package' },
      { '<leader>lcrm', ':ComposerRemove<cr>', desc = 'Composer Remove Package' },
      { '<leader>lcd', ':ComposerDependencies<cr>', desc = 'Show Dependencies' },
      -- Laravel Sail
      { '<leader>lsu', ':SailUp<cr>', desc = 'Sail Up' },
      { '<leader>lsd', ':SailDown<cr>', desc = 'Sail Down' },
      { '<leader>lsr', ':SailRestart<cr>', desc = 'Sail Restart' },
      { '<leader>lst', ':SailTest<cr>', desc = 'Sail Test' },
      { '<leader>lss', ':SailShell<cr>', desc = 'Sail Shell' },
      -- IDE Helper
      { '<leader>lih', ':LaravelIdeHelperCheck<cr>', desc = 'Check IDE Helper' },
      { '<leader>lig', ':LaravelIdeHelper all<cr>', desc = 'Generate IDE Helper Files' },
      { '<leader>lic', ':LaravelIdeHelperClean<cr>', desc = 'Clean IDE Helper Files' },
    },
    config = function()
      require('laravel').setup {
        notifications = true,
        debug = true,
        keymaps = true,
        sail = {
          enabled = true,
          auto_detect = true,
        },
      }

      require('config.lsp.utils.laravel-utils').setup()
    end,
  },

  {
    'adibhanna/phprefactoring.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    keys = {
      { '<leader>rr', ':PhpRefactor<cr>', desc = 'PHP Refactor', mode = { 'n', 'v' } },
      { '<leader>re', ':PhpExtractMethod<cr>', desc = 'Extract Method', mode = 'v' },
      { '<leader>rv', ':PhpExtractVariable<cr>', desc = 'Extract Variable', mode = 'v' },
    },
    config = function()
      require('phprefactoring').setup()
    end,
  },
}
