-- Rust Analyzer Language Server configuration
return {
  cmd = { "rust-analyzer" },
  root_dir = require('lspconfig.util').root_pattern("Cargo.lock"),
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
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
