-- Laravel utilities and custom commands
-- Add this to your after/plugin/ directory or in your main config

local M = {}

-- Check if we're in a Laravel project
function M.is_laravel_project()
  return vim.fn.filereadable 'artisan' == 1 and vim.fn.filereadable 'composer.json' == 1
end

-- Get Laravel project root
function M.get_laravel_root()
  local function find_root(path)
    local artisan_path = path .. '/artisan'
    local composer_path = path .. '/composer.json'

    if vim.fn.filereadable(artisan_path) == 1 and vim.fn.filereadable(composer_path) == 1 then
      return path
    end

    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return nil
    end

    return find_root(parent)
  end

  return find_root(vim.fn.getcwd())
end

-- Laravel project detection notification
function M.setup_laravel_detection()
  local laravel_group = vim.api.nvim_create_augroup('LaravelDetection', { clear = true })

  vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    group = laravel_group,
    callback = function()
      if M.is_laravel_project() then
        -- Show Laravel project detected notification
        if pcall(require, 'snacks') then
          require('snacks').notify('🔥 Laravel project detected!', {
            title = 'Laravel.nvim',
            level = 'info',
            timeout = 3000,
          })
        else
          vim.notify('🔥 Laravel project detected!', vim.log.levels.INFO, { title = 'Laravel.nvim' })
        end

        -- Auto-enable dump capture
        vim.defer_fn(function()
          vim.cmd 'silent! LaravelDumpsEnable'
        end, 1000)
      end
    end,
  })
end

-- Enhanced Laravel commands
function M.setup_commands()
  -- Quick Laravel file navigation
  vim.api.nvim_create_user_command('LaravelController', function(opts)
    local controller = opts.args ~= '' and opts.args or vim.fn.input 'Controller name: '
    if controller ~= '' then
      local file_path = 'app/Http/Controllers/' .. controller .. '.php'
      vim.cmd('edit ' .. file_path)
    end
  end, {
    nargs = '?',
    desc = 'Open Laravel controller',
    complete = function()
      local controllers = {}
      local glob_pattern = 'app/Http/Controllers/**/*.php'
      local files = vim.fn.glob(glob_pattern, false, true)

      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        table.insert(controllers, name)
      end

      return controllers
    end,
  })

  vim.api.nvim_create_user_command('LaravelModel', function(opts)
    local model = opts.args ~= '' and opts.args or vim.fn.input 'Model name: '
    if model ~= '' then
      local file_path = 'app/Models/' .. model .. '.php'
      vim.cmd('edit ' .. file_path)
    end
  end, {
    nargs = '?',
    desc = 'Open Laravel model',
    complete = function()
      local models = {}
      local files = vim.fn.glob('app/Models/**/*.php', false, true)

      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        table.insert(models, name)
      end

      return models
    end,
  })

  vim.api.nvim_create_user_command('LaravelMigration', function(opts)
    if opts.args ~= '' then
      local files = vim.fn.glob('database/migrations/*' .. opts.args .. '*.php', false, true)
      if #files > 0 then
        vim.cmd('edit ' .. files[1])
      else
        print('No migration found containing: ' .. opts.args)
      end
    else
      -- List all migrations
      local files = vim.fn.glob('database/migrations/*.php', false, true)
      if #files > 0 then
        vim.ui.select(files, {
          prompt = 'Select migration:',
          format_item = function(item)
            return vim.fn.fnamemodify(item, ':t')
          end,
        }, function(choice)
          if choice then
            vim.cmd('edit ' .. choice)
          end
        end)
      else
        print 'No migrations found'
      end
    end
  end, {
    nargs = '?',
    desc = 'Open Laravel migration',
  })

  vim.api.nvim_create_user_command('LaravelConfig', function(opts)
    local config_file = opts.args ~= '' and opts.args or vim.fn.input 'Config file: '
    if config_file ~= '' then
      local file_path = 'config/' .. config_file .. '.php'
      vim.cmd('edit ' .. file_path)
    end
  end, {
    nargs = '?',
    desc = 'Open Laravel config file',
    complete = function()
      local configs = {}
      local files = vim.fn.glob('config/*.php', false, true)

      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        table.insert(configs, name)
      end

      return configs
    end,
  })

  -- Laravel Tinker integration
  vim.api.nvim_create_user_command('LaravelTinker', function()
    local cmd = M.is_laravel_project() and 'php artisan tinker' or 'tinker'
    vim.cmd('terminal ' .. cmd)
  end, { desc = 'Open Laravel Tinker' })

  -- Laravel log viewer
  vim.api.nvim_create_user_command('LaravelLog', function()
    local log_file = 'storage/logs/laravel.log'
    if vim.fn.filereadable(log_file) == 1 then
      vim.cmd('tabnew ' .. log_file)
      -- Auto-reload the file
      vim.cmd 'set autoread'
      vim.cmd 'autocmd FocusGained,BufEnter <buffer> checktime'
    else
      print('Laravel log file not found: ' .. log_file)
    end
  end, { desc = 'Open Laravel log file' })

  -- Laravel routes with grep
  vim.api.nvim_create_user_command('LaravelRouteGrep', function(opts)
    local pattern = opts.args ~= '' and opts.args or vim.fn.input 'Search routes for: '
    if pattern ~= '' then
      vim.cmd('Artisan route:list --name=' .. pattern)
    end
  end, { nargs = '?', desc = 'Search Laravel routes' })

  -- Quick env file access
  vim.api.nvim_create_user_command('LaravelEnv', function()
    local env_files = { '.env', '.env.local', '.env.example' }
    local available_files = {}

    for _, file in ipairs(env_files) do
      if vim.fn.filereadable(file) == 1 then
        table.insert(available_files, file)
      end
    end

    if #available_files == 1 then
      vim.cmd('edit ' .. available_files[1])
    elseif #available_files > 1 then
      vim.ui.select(available_files, {
        prompt = 'Select env file:',
      }, function(choice)
        if choice then
          vim.cmd('edit ' .. choice)
        end
      end)
    else
      print 'No .env files found'
    end
  end, { desc = 'Open Laravel .env file' })
end

-- Laravel project status in statusline
function M.laravel_status()
  if not M.is_laravel_project() then
    return ''
  end

  local status_parts = {}

  -- Laravel version detection
  local composer_lock = vim.fn.readfile('composer.lock', '', 1)
  if #composer_lock > 0 then
    local composer_data = vim.fn.json_decode(table.concat(composer_lock))
    if composer_data and composer_data.packages then
      for _, package in ipairs(composer_data.packages) do
        if package.name == 'laravel/framework' then
          table.insert(status_parts, '🔥L' .. string.match(package.version, '^v?(%d+%.%d+)'))
          break
        end
      end
    end
  end

  -- Sail detection
  if vim.fn.filereadable 'docker-compose.yml' == 1 and vim.fn.executable 'vendor/bin/sail' == 1 then
    table.insert(status_parts, '⛵')
  end

  -- Dump capture status
  local ok, laravel = pcall(require, 'laravel')
  if ok then
    -- This would need to be implemented in Laravel.nvim
    -- table.insert(status_parts, laravel.dumps.is_enabled() and '📡' or '📴')
  end

  return #status_parts > 0 and table.concat(status_parts, ' ') or '🔥'
end

-- Telescope integration for Laravel
function M.setup_telescope_integration()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return
  end

  -- Laravel controllers picker
  vim.api.nvim_create_user_command('LaravelTelescope', function(opts)
    local action = opts.args or 'controllers'

    if action == 'controllers' then
      require('telescope.builtin').find_files {
        prompt_title = 'Laravel Controllers',
        cwd = 'app/Http/Controllers',
        find_command = { 'find', '.', '-name', '*.php', '-type', 'f' },
      }
    elseif action == 'models' then
      require('telescope.builtin').find_files {
        prompt_title = 'Laravel Models',
        cwd = 'app/Models',
        find_command = { 'find', '.', '-name', '*.php', '-type', 'f' },
      }
    elseif action == 'views' then
      require('telescope.builtin').find_files {
        prompt_title = 'Laravel Views',
        cwd = 'resources/views',
        find_command = { 'find', '.', '-name', '*.php', '-type', 'f' },
      }
    elseif action == 'migrations' then
      require('telescope.builtin').find_files {
        prompt_title = 'Laravel Migrations',
        cwd = 'database/migrations',
        find_command = { 'find', '.', '-name', '*.php', '-type', 'f' },
      }
    end
  end, {
    nargs = '?',
    desc = 'Laravel Telescope picker',
    complete = function()
      return { 'controllers', 'models', 'views', 'migrations' }
    end,
  })
end

-- NEW: Enhanced Laravel navigation with IDE helper filtering
function M.setup_enhanced_navigation()
  -- Files/patterns to ignore in go-to-definition
  local ignore_patterns = {
    '_ide_helper%.php$', -- Laravel IDE Helper main file
    '_ide_helper_models%.php$', -- Laravel IDE Helper models file
    '%.phpstorm%.meta%.php$', -- PhpStorm meta files
    '/vendor/.*_ide_helper.*%.php$', -- Any IDE helper files in vendor
    '/vendor/.*/stubs/.*%.php$', -- Stub files
    'bootstrap/cache/.*%.php$', -- Laravel cache files
  }

  -- Check if a file should be ignored
  local function should_ignore_file(filepath)
    if not filepath then
      return false
    end

    for _, pattern in ipairs(ignore_patterns) do
      if filepath:match(pattern) then
        vim.notify('FILTERING OUT: ' .. filepath, vim.log.levels.WARN)
        return true
      end
    end

    return false
  end

  -- Smart Laravel-aware go-to-definition
  local function smart_goto_definition()
    -- First try Laravel.nvim navigation (for Laravel-specific patterns)
    local laravel_success = pcall(vim.cmd, 'LaravelGoto')

    if laravel_success then
      -- Laravel navigation succeeded, we're done
      return
    end

    -- Laravel navigation failed, use LSP with Telescope
    local params = vim.lsp.util.make_position_params()

    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
      if err then
        vim.notify('Error in go to definition: ' .. err.message, vim.log.levels.ERROR)
        return
      end

      if not result or vim.tbl_isempty(result) then
        vim.notify('No definition found', vim.log.levels.WARN)
        return
      end

      vim.notify('Got ' .. #result .. ' LSP results', vim.log.levels.INFO)

      -- Filter out ignored files
      local filtered_results = {}
      for _, location in ipairs(result) do
        local uri = location.uri or location.targetUri
        local filepath = vim.uri_to_fname(uri)

        if not should_ignore_file(filepath) then
          table.insert(filtered_results, location)
        end
      end

      if vim.tbl_isempty(filtered_results) then
        vim.notify('No relevant definitions found (IDE helper files filtered)', vim.log.levels.WARN)
        return
      end

      -- If only one result after filtering, jump directly
      if #filtered_results == 1 then
        vim.lsp.util.show_document(filtered_results[1], 'utf-8', { focus = true })
        return
      end

      -- Multiple results - use Telescope for nice UI
      local ok, telescope_builtin = pcall(require, 'telescope.builtin')
      if ok then
        -- Convert LSP locations to Telescope format and use telescope
        local locations = vim.lsp.util.locations_to_items(filtered_results, 'utf-8')

        -- Filter locations again to be extra sure
        local final_locations = {}
        for _, location in ipairs(locations) do
          if not should_ignore_file(location.filename) then
            table.insert(final_locations, location)
          end
        end

        if #final_locations > 1 then
          -- Use Telescope's quickfix list for multiple definitions
          vim.fn.setqflist({}, 'r', {
            title = 'LSP Definitions',
            items = final_locations,
          })

          telescope_builtin.quickfix {
            prompt_title = 'Go to Definition',
          }
        elseif #final_locations == 1 then
          -- Jump to single result
          vim.cmd('edit +' .. final_locations[1].lnum .. ' ' .. final_locations[1].filename)
        else
          vim.notify('No relevant definitions found', vim.log.levels.WARN)
        end
      else
        -- Fallback: use quickfix if Telescope not available
        local locations = vim.lsp.util.locations_to_items(filtered_results, 'utf-8')
        vim.fn.setqflist({}, 'r', {
          title = 'LSP Definitions',
          items = locations,
        })
        vim.cmd 'copen'
      end
    end)
  end

  -- Create autocommand for Laravel files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'php', 'blade' },
    callback = function(ev)
      local bufnr = ev.buf

      -- Override gd with smart navigation
      vim.keymap.set('n', 'gd', smart_goto_definition, {
        buffer = bufnr,
        desc = 'Laravel Smart Go to Definition',
      })
    end,
  })
end

-- Initialize all Laravel utilities
function M.setup()
  if not M.is_laravel_project() then
    return
  end

  M.setup_laravel_detection()
  M.setup_commands()
  M.setup_telescope_integration()
  M.setup_enhanced_navigation() -- ADD THIS LINE

  -- Add Laravel status to global statusline function
  _G.laravel_status = M.laravel_status
end

-- Auto-setup when in Laravel project
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  callback = function()
    M.setup()
  end,
})

return M
