return {
  jsonls = {
    settings = {
      json = {
        schema = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16" },
  },
  ruby_ls = {
    cmd = { "ruby-lsp" },
  },
  terraformls = {
    cmd = { "terraform-ls" },
    arg = { "server" },
    filetypes = { "terraform", "tf", "terraform-vars" },
  },
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
  bashls = {
    filetypes = { "sh", "zsh" },
  },
  vimls = {
    filetypes = { "vim" },
  },
  tsserver = {
    commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize Imports",
      },
    },
  },
  gopls = {},
  -- solidity_ls_nomicfoundation = {},
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
  },
}
