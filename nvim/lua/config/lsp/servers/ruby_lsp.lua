-- Ruby LSP Language Server configuration
return {
  cmd = { vim.fn.expand '~/.asdf/shims/ruby-lsp' },
  filetypes = { 'ruby' },
  root_dir = require('lspconfig.util').root_pattern('Gemfile', '.ruby-version', '.tool-versions', '.git'),
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
    addonSettings = {
      ['Ruby LSP Rails'] = {
        enablePendingMigrationsPrompt = true,
      },
    },
    enabledfeatures = {
      'documenthighlights',
      'documentsymbols',
      'foldingranges',
      'selectionranges',
      'semantichighlighting',
      'formatting',
      'diagnostics',
      'completion',
      'hover',
      'signaturehelp',
    },
  },
  settings = {
    rubyLsp = {
      formatter = 'standard',
      linters = { 'standard' },
    },
  },
}
