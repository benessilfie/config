return {
  { "christoomey/vim-tmux-navigator" },
  { "wakatime/vim-wakatime" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
  },
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    config = function()
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }
      -- keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
      keymap("n", "Q", ":lua require('bufdelete').bufdelete(0, false)<cr>", opts)
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
      vim.g.gitblame_enabled = 0
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      })
    end,
  },
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
    config = function(_, _)
      require("mini.comment").setup()

      require("nvim-treesitter.configs").setup({
        enable_autocmd = false,
      })
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "stevearc/dressing.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function()
      require("dressing").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    enabled = false,
    config = function()
      require("fidget").setup({
        window = { blend = 0 },
      })
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require("glance").setup({
        theme = {
          enable = true,
          mode = "auto",
        },
        border = {
          enable = true,
          top_char = "─",
          bottom_char = "─",
        },
      })
    end,
    keys = {
      { "gD", "<CMD>Glance definitions<CR>",      desc = "Glance definitions" },
      { "gR", "<CMD>Glance references<CR>",       desc = "Glance references" },
      { "gY", "<CMD>Glance type_definitions<CR>", desc = "Glance type_definitions" },
      { "gM", "<CMD>Glance implementations<CR>",  desc = "Glance implementations" },
    },
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        stop_eof = true,
        easing_function = "sine",
        hide_cursor = true,
        -- respect_scrolloff = true,
        cursor_scrolls_alone = true,
        -- performance_mode = false
      })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        -- https://github.com/kylechui/nvim-surround
      })
    end,
  },
  "tpope/vim-sleuth",
  {
    "bennypowers/splitjoin.nvim",
    keys = {
      {
        "gJ",
        function()
          require("splitjoin").join()
        end,
        desc = "Join the object under cursor",
      },
      {
        "gS",
        function()
          require("splitjoin").split()
        end,
        desc = "Split the object under cursor",
      },
    },
  },
  "folke/neodev.nvim",
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "derektata/lorem.nvim",
    config = function()
      local lorem = require("lorem")
      lorem.setup({
        sentenceLength = "mixedShort",
        comma = 1,
      })
    end,
  },
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },
  "editorconfig/editorconfig-vim",
  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    "LunarVim/breadcrumbs.nvim",
    config = function()
      require("breadcrumbs").setup()
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local icons = require("config.icons")
      require("nvim-navic").setup({
        highlight = true,
        lsp = {
          auto_attach = true,
          preference = { "typescript-tools" },
        },
        click = true,
        separator = " " .. icons.ui.ChevronRight .. " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = " ",
          Interface = " ",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = " ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
      })
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
}
