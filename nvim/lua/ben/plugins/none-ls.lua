return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.sqlfmt,
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
      },
    })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
  end,
}
