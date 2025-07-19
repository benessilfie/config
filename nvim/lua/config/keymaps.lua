local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Keep cursor centered when scrolling
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- Disable command-line window (accidentally triggered by q:)
map('n', 'q:', '<nop>')
map('n', 'Q', '<nop>')

-- Github Copilot
map('i', '<D-l>', 'copilot#Accept("")', { expr = true, replace_keycodes = false, silent = true })
map('i', '<D-n>', '<Plug>(copilot-next)')
map('i', '<D-p>', '<Plug>(copilot-previous)')
map('i', '<D-d>', '<Plug>(copilot-dismiss)')
map('i', '<D-s>', '<Plug>(copilot-suggest)')
-- map('i', '<A-a>', '<Plug>(copilot-accept-word)')key
-- map('i', '<A-a>', '<Plug>(copilot-accept-line)')

-- Toggle Terminal
map('n', 'tt', ':ToggleTerm direction=horizontal<CR>', opts)
map('t', 'jk', '<C-\\><C-n>', opts)

-- Markdown Preview
map('n', '<Leader>mp', ':MarkdownPreview<CR>', opts)
map('n', '<Leader>mc', ':MarkdownPreviewStop<CR>', opts)

-- Move selected line / block of text in visual mode
map('v', '<D-j>', ":m '>+1<CR>gv=gv", opts)
map('v', '<D-k>', ":m '<-2<CR>gv=gv", opts)

-- Remap for dealing with visual line wraps
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- paste over currently selected text without yanking it
map('v', 'p', '"_dp')
map('v', 'P', '"_dP')

-- copy everything between { and } including the brackets
map('n', 'YY', 'va{Vy', opts)

-- Move line on the screen rather than by line in the file
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- Exit on jk
map('i', 'jk', '<ESC>', opts)
map('v', 'jk', '<ESC>', opts)

-- Move to start/end of line
map({ 'n', 'x', 'o' }, 'H', '^', opts)
map({ 'n', 'x', 'o' }, 'L', 'g_', opts)

-- Move outside of parentheses in insert mode
map('i', '<C-h>', '<Left>', opts)
map('i', '<C-l>', '<Right>', opts)
map('i', '<C-j>', '<Down>', opts)
map('i', '<C-k>', '<Up>', opts)

-- Panes resizing
map('n', '+', ':vertical resize +5<CR>')
map('n', '_', ':vertical resize -5<CR>')
map('n', '=', ':resize +5<CR>')
map('n', '-', ':resize -5<CR>')

-- panes management
map('n', '<Leader>pv', ':vsplit<CR>', opts)
map('n', '<Leader>ph', ':split<CR>', opts)
map('n', '<Leader>px', ':close<CR>', opts)

-- Map enter to ciw in normal mode
map('n', '<CR>', 'ciw', opts)
map('n', '<BS>', 'ci', opts)

-- search current buffer
map('n', '<C-s>', ':Telescope current_buffer_fuzzy_find<CR>', opts)

-- Select all
map('n', '<C-a>', 'ggVG', opts)

-- write file in current directory
-- :w %:h/<new-file-name>
map('n', '<C-n>', ':w %:h/', opts)

-- Core leader mappings for which-key organization
map('n', '<leader>c', function()
  local buf_count = #vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if buf_count > 1 then
    local current_buf = vim.api.nvim_get_current_buf()

    -- Switch to next buffer in current window
    vim.cmd 'bnext'
    if vim.api.nvim_get_current_buf() == current_buf then
      vim.cmd 'bprev'
    end

    -- Force delete the buffer from all windows but keep windows open
    vim.cmd('bwipeout! ' .. current_buf)
  else
    vim.cmd 'quit'
  end
end, { desc = 'Close Buffer' })

-- map('n', '<leader>c', '<cmd>bdelete<CR>', { desc = 'Close Buffer' })
map('n', '<leader>h', '<cmd>nohlsearch<CR>', { desc = 'No Highlight' })
map('n', '<leader>q', '<cmd>confirm q<CR>', { desc = 'Quit' })
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })

-- Add this to your keymaps
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<cr>', { desc = 'Find current file in explorer' })
