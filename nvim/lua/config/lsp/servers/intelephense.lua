-- PHP Intelephense Language Server configuration optimized for Laravel
return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php', 'blade' },
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'artisan'),

  settings = {
    intelephense = {
      -- Improve performance
      maxMemory = 1024,

      -- Laravel-specific configuration
      stubs = {
        'apache',
        'bcmath',
        'bz2',
        'calendar',
        'com_dotnet',
        'Core',
        'ctype',
        'curl',
        'date',
        'dba',
        'dom',
        'enchant',
        'exif',
        'FFI',
        'fileinfo',
        'filter',
        'fpm',
        'ftp',
        'gd',
        'gettext',
        'gmp',
        'hash',
        'iconv',
        'imap',
        'intl',
        'json',
        'ldap',
        'libxml',
        'mbstring',
        'meta',
        'mysqli',
        'oci8',
        'odbc',
        'openssl',
        'pcntl',
        'pcre',
        'PDO',
        'pdo_ibm',
        'pdo_mysql',
        'pdo_pgsql',
        'pdo_sqlite',
        'pgsql',
        'Phar',
        'posix',
        'pspell',
        'readline',
        'Reflection',
        'session',
        'shmop',
        'SimpleXML',
        'snmp',
        'soap',
        'sockets',
        'sodium',
        'SPL',
        'sqlite3',
        'standard',
        'superglobals',
        'sysvmsg',
        'sysvsem',
        'sysvshm',
        'tidy',
        'tokenizer',
        'xml',
        'xmlreader',
        'xmlrpc',
        'xmlwriter',
        'xsl',
        'Zend OPcache',
        'zip',
        'zlib',
        -- Laravel-specific stubs
        'laravel',
      },

      -- File associations for Laravel
      files = {
        associations = {
          '*.php',
          '*.phtml',
          '*.blade.php', -- Laravel Blade templates
        },
        exclude = {
          '**/node_modules/**',
          '**/vendor/**/{Test,test,Tests,tests}/**/*',
          '**/.git/**',
          '**/storage/framework/cache/**',
          '**/storage/framework/sessions/**',
          '**/storage/framework/views/**',
          '**/storage/logs/**',
        },
        maxSize = 10000000, -- 10MB
      },

      -- Diagnostics configuration
      diagnostics = {
        enable = true,
        run = 'onType',
        embeddedLanguages = true,
        undefinedSymbols = true,
        undefinedFunctions = true,
        undefinedConstants = true,
        undefinedClassConstants = true,
        undefinedMethods = true,
        undefinedProperties = true,
        undefinedTypes = true,
        duplicateSymbols = true,
      },

      -- Completion configuration
      completion = {
        insertUseDeclaration = true,
        fullyQualifyGlobalConstantsAndFunctions = false,
        triggerParameterHints = true,
        maxItems = 100,
      },

      -- Format configuration
      format = {
        enable = true,
        braces = 'psr12',
      },

      -- Environment (helps with Laravel facades and helpers)
      environment = {
        documentRoot = '/',
        includePaths = {
          '/',
        },
      },

      -- Runtime configuration for Laravel
      runtime = {
        version = '8.2', -- Adjust to your PHP version
      },

      -- Rename configuration
      rename = {
        exclude = {
          '**/vendor/**',
          '**/node_modules/**',
        },
      },

      -- References configuration
      references = {
        exclude = {
          '**/vendor/**',
          '**/node_modules/**',
        },
      },
    },
  },

  -- Laravel-specific initialization options
  init_options = {
    -- This helps with Laravel's dynamic nature
    clearCache = false,
    licenceKey = nil, -- Add your license key if you have Intelephense Premium
  },

  -- Custom on_attach for Laravel projects
  on_attach = function(client, bufnr)
    -- Call the standard on_attach function
    require('core.lsp').on_attach { buf = bufnr, data = { client_id = client.id } }

    -- Laravel-specific key mappings
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'Laravel LSP: ' .. desc })
    end

    --------------Go to Definition and Navigation----------------
    -- Laravel-specific navigation (fallback to LSP if Laravel.nvim fails)
    map('gd', function()
      local ok = pcall(vim.cmd, 'LaravelGoto')
      if not ok then
        -- Laravel failed, use filtered LSP navigation
        local params = vim.lsp.util.make_position_params()

        vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
          if err or not result or vim.tbl_isempty(result) then
            require('telescope.builtin').lsp_definitions()
            return
          end

          -- Filter out IDE helper files
          local filtered_results = {}
          for _, location in ipairs(result) do
            local uri = location.uri or location.targetUri
            local filepath = vim.uri_to_fname(uri)

            if not (filepath:match '_ide_helper%.php$' or filepath:match '_ide_helper_models%.php$') then
              table.insert(filtered_results, location)
            end
          end

          if #filtered_results == 1 then
            vim.lsp.util.show_document(filtered_results[1], 'utf-8', { focus = true })
          elseif #filtered_results > 1 then
            -- Use Telescope for multiple results
            local locations = vim.lsp.util.locations_to_items(filtered_results, 'utf-8')
            vim.fn.setqflist({}, 'r', { title = 'Definitions', items = locations })
            require('telescope.builtin').quickfix()
          else
            vim.notify('No relevant definitions found', vim.log.levels.WARN)
          end
        end)
      end
    end, 'Go to Definition (Laravel-aware with filtering)')
    ------------------------- ------------------------------------------------

    -- Override hover to show Laravel-specific information
    map('K', function()
      -- Try Laravel-specific hover first, fallback to LSP
      local ok, _ = pcall(vim.cmd, 'LaravelHover')
      if not ok then
        vim.lsp.buf.hover()
      end
    end, 'Hover (Laravel-aware)')
  end,

  -- Capabilities (will be merged with blink.cmp capabilities)
  capabilities = {
    -- Enable additional capabilities for Laravel
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = { 'documentation', 'detail', 'additionalTextEdits' },
          },
        },
      },
    },
  },
}
