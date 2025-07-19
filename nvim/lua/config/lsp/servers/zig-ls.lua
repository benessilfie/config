-- Zig Language Server configuration
return {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_dir = require('lspconfig.util').root_pattern("zls.json", "build.zig", ".git"),
}
