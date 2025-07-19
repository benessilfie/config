return {
  -- Autotags
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  -- useful when there are embedded languages in certain types of files (e.g. Vue or React)
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },


  -- Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },

  -- editor config support
  {
    "editorconfig/editorconfig-vim",
  },


  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },

  {
    "fladson/vim-kitty",
    "MunifTanjim/nui.nvim",
  },
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 6,
      -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
      position = "bottom-right",
    },

    keys = {
      {
        "<leader>ut",
        function()
          vim.cmd("ShowkeysToggle")
        end,
        desc = "Show key presses",
      },
    },
  },
}
