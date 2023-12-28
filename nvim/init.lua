vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('ben.keymaps')
require('ben.options')

require('ben.lazy-setup')
require('ben.lazy-plugins')
require('ben.lsp-setup')
require('ben.cmp-setup')
require('ben.telescope-setup')
require('ben.treesitter-setup')
require('ben.tmux-settings')
require('ben.settings')
