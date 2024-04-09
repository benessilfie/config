return {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter", -- optional, can be "BufRead" or "InsertEnter"
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          suggestion = {
            auto_trigger = true,
            keymap = {
                        accept = "<A-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<A-j>",
                        prev = "<A-k>",
                        dismiss = "<C-e>",
                    },
          },
          filetypes = { markdown = true, }
        })                             -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  }
