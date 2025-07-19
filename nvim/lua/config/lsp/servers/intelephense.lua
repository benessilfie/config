-- PHP Intelephense Language Server configuration
return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  root_dir = require('lspconfig.util').root_pattern("composer.json", ".git"),
}
