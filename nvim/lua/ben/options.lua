-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set colorscheme (order is important here)
vim.o.background = 'dark'

-- Set scrolloff to 5 lines - Scrolloff will keep n lines above and below the cursor
vim.o.scrolloff = 8

-- Set tab width
vim.o.tabstop = 2

-- Set shift width
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- line wrapping
vim.o.wrap = true

-- cursorline
vim.o.cursorline = true

-- backspace settings
vim.o.backspace = "indent,eol,start"

-- split window settings
vim.o.splitright = true
vim.o.splitbelow = true

-- vim.o.iskeyword:append("-") -- treat dash separated words as a word text object"
