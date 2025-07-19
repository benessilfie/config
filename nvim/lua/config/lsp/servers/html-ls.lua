-- HTML Language Server configuration
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = {
    "html",
    "blade",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  },
  root_dir = require('lspconfig.util').root_pattern("index.html", ".git"),
  init_options = { provideFormatter = true },
}
