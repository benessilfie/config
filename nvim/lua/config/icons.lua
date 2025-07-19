-- Icon configurations used across plugins
local M = {}

-- Lazy.nvim UI icons
M.lazy = vim.g.have_nerd_font and {} or {
  cmd = '⌘',
  config = '🛠',
  event = '📅',
  ft = '📂',
  init = '⚙',
  keys = '🗝',
  plugin = '🔌',
  runtime = '💻',
  require = '🌙',
  source = '📄',
  start = '🚀',
  task = '📌',
  lazy = '💤 ',
}

-- Which-key icons
M.which_key = vim.g.have_nerd_font and {} or {
  Up = '<Up> ',
  Down = '<Down> ',
  Left = '<Left> ',
  Right = '<Right> ',
  C = '<C-…> ',
  M = '<M-…> ',
  D = '<D-…> ',
  S = '<S-…> ',
  CR = '<CR> ',
  Esc = '<Esc> ',
  ScrollWheelDown = '<ScrollWheelDown> ',
  ScrollWheelUp = '<ScrollWheelUp> ',
  NL = '<NL> ',
  BS = '<BS> ',
  Space = '<Space> ',
  Tab = '<Tab> ',
  F1 = '<F1>',
  F2 = '<F2>',
  F3 = '<F3>',
  F4 = '<F4>',
  F5 = '<F5>',
  F6 = '<F6>',
  F7 = '<F7>',
  F8 = '<F8>',
  F9 = '<F9>',
  F10 = '<F10>',
  F11 = '<F11>',
  F12 = '<F12>',
}

-- Git signs
M.gitsigns = {
  add = { text = '+' },
  change = { text = '~' },
  delete = { text = '_' },
  topdelete = { text = '‾' },
  changedelete = { text = '~' },
}

-- Diagnostic signs
M.diagnostics = vim.g.have_nerd_font and {
  text = {
    [vim.diagnostic.severity.ERROR] = '󰅚 ',
    [vim.diagnostic.severity.WARN] = '󰀪 ',
    [vim.diagnostic.severity.INFO] = '󰋽 ',
    [vim.diagnostic.severity.HINT] = '󰌶 ',
  },
} or {}

return M
