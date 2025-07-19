-- Java JDTLS configuration
-- Setup Tab and Shift Width
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

-- Setup Workspace
local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

-- Determine OS
local os_config = 'linux'
if vim.fn.has 'mac' == 1 then
  os_config = 'mac'
elseif vim.fn.has 'win32' == 1 then
  os_config = 'win'
end

-- Setup Capabilities (updated for your setup)
local capabilities = require('blink.cmp').get_lsp_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Setup Testing and Debugging
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. 'packages/java-test/extension/server/*.jar'), '\n'))
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. 'packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'), '\n'))

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. os_config,
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  capabilities = capabilities,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-22',
            path = '~/.sdkman/candidates/java/22.0.1-open',
          },
          -- Add more Java versions as needed
          -- {
          --   name = "JavaSE-11",
          --   path = "~/.sdkman/candidates/java/11.0.17-tem",
          -- },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false, -- We'll use conform.nvim for formatting
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
      filteredTypes = {
        'com.sun.*',
        'io.micrometer.shaded.*',
        'java.awt.*',
        'jdk.*',
        'sun.*',
      },
      importOrder = {
        'java',
        'javax',
        'com',
        'org',
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
    },
    extendedClientCapabilities = extendedClientCapabilities,
  },
  init_options = {
    bundles = bundles,
  },
}

-- Custom on_attach function
config['on_attach'] = function(client, bufnr)
  -- Use your core LSP on_attach
  require('core.lsp').on_attach { buf = bufnr, data = { client_id = client.id } }

  -- JDTLS specific setup
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require('jdtls').setup_dap { hotcodereplace = 'auto' }

  -- Setup DAP configurations
  local status_ok, jdtls_dap = pcall(require, 'jdtls.dap')
  if status_ok then
    jdtls_dap.setup_dap_main_class_configs()
  end

  -- Java-specific keymaps
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Java: ' .. desc })
  end

  local vmap = function(keys, func, desc)
    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = 'Java: ' .. desc })
  end

  -- Normal mode Java commands
  map('<leader>Co', function()
    require('jdtls').organize_imports()
  end, 'Organize Imports')
  map('<leader>Cv', function()
    require('jdtls').extract_variable()
  end, 'Extract Variable')
  map('<leader>Cc', function()
    require('jdtls').extract_constant()
  end, 'Extract Constant')
  map('<leader>Ct', function()
    require('jdtls').test_nearest_method()
  end, 'Test Method')
  map('<leader>CT', function()
    require('jdtls').test_class()
  end, 'Test Class')
  map('<leader>Cu', '<cmd>JdtUpdateConfig<cr>', 'Update Config')

  -- Visual mode Java commands
  vmap('<leader>Cv', function()
    require('jdtls').extract_variable(true)
  end, 'Extract Variable')
  vmap('<leader>Cc', function()
    require('jdtls').extract_constant(true)
  end, 'Extract Constant')
  vmap('<leader>Cm', function()
    require('jdtls').extract_method(true)
  end, 'Extract Method')
end

-- Auto-refresh codelens on save
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.java' },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

-- Start or attach JDTLS
require('jdtls').start_or_attach(config)
