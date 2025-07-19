local autocmd = vim.api.nvim_create_autocmd

-- don't auto comment new line
autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

-- Highlight on yank
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- wrap words "softly" (no carriage return) in mail buffer
autocmd('Filetype', {
  pattern = 'mail',
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = '80'
  end,
})

-- Enable spell checking for certain file types
autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.txt', '*.md', '*.tex' },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = 'en'
  end,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command 'autocmd VimResized * wincmd ='

-- Remove unused imports on save
autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('ts_imports', { clear = true }),
  pattern = { '*.tsx,*.ts' },
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        -- only = { 'source.removeUnused.ts', 'source.addMissingImports.ts' },
        diagnostics = {},
      },
    }
  end,
})

-- ALL PHP autocmds
-- Define an autocmd group for the blade workaround
local augroup = vim.api.nvim_create_augroup('lsp_blade_workaround', { clear = true })

-- Autocommand to temporarily change 'blade' filetype to 'php' when opening for LSP server activation
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroup,
  pattern = '*.blade.php',
  callback = function()
    vim.bo.filetype = 'php'
  end,
})

-- Additional autocommand to switch back to 'blade' after LSP has attached
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = '*.blade.php',
  callback = function(args)
    vim.schedule(function()
      -- Check if the attached client is 'intelephense'
      for _, client in ipairs(vim.lsp.get_clients { bufnr = args.buf }) do
        if client.name == 'intelephense' then
          -- Use modern API instead of deprecated functions
          vim.bo[args.buf].filetype = 'blade'
          vim.bo[args.buf].syntax = 'blade'
          break
        end
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
