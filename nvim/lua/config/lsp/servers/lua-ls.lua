return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = require('lspconfig.util').root_pattern(
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git'
  ),
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = {
          "vim",
          "Snacks",
        },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
    },
  },
  -- Capabilities will be merged with global capabilities
  capabilities = {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  },
}
