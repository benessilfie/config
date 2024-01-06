local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Move selected line / block of text in visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Fast saving
map("n", "<Leader>w", ":write!<CR>", opts)
map("n", "<Leader>q", ":q!<CR>", opts)

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- copy everything between { and } including the brackets
-- p puts text after the cursor,
-- P puts text before the cursor.
map("n", "YY", "va{Vy", opts)

-- Move line on the screen rather than by line in the file
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Exit on jk
map("i", "jk", "<ESC>", opts)
map("v", "jk", "<ESC>", opts)

-- Move to start/end of line
map({ "n", "x", "o" }, "H", "^", opts)
map({ "n", "x", "o" }, "L", "g_", opts)

-- Move outside of parens in insert mode
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)

-- Navigate buffers
map("n", "<Right>", ":bnext<CR>", opts)
map("n", "<Left>", ":bprevious<CR>", opts)

-- Panes resizing
map("n", "+", ":vertical resize +5<CR>")
map("n", "_", ":vertical resize -5<CR>")
map("n", "=", ":resize +5<CR>")
map("n", "-", ":resize -5<CR>")

-- panes management
map("n", "<Leader>pv", ":vsplit<CR>", opts)
map("n", "<Leader>ph", ":split<CR>", opts)
map("n", "<Leader>px", ":close<CR>", opts)

-- Map enter to ciw in normal mode
map("n", "<CR>", "ciw", opts)
map("n", "<BS>", "ci", opts)

map("n", "n", "nzzv", opts)
map("n", "N", "Nzzv", opts)
map("n", "*", "*zzv", opts)
map("n", "#", "#zzv", opts)
map("n", "g*", "g*zz", opts)
map("n", "g#", "g#zz", opts)

-- map ; to resume last search
-- map("n", ";", "<cmd>Telescope resume<cr>", opts)

-- search current buffer
map("n", "<C-s>", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- search modified files
map("n", "<Leader>m", ":Telescope git_status<CR>", opts)

-- Split line with X
map("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { silent = true })

-- Select all
map("n", "<C-a>", "ggVG", opts)

-- write file in current directory
-- :w %:h/<new-file-name>
map("n", "<C-n>", ":w %:h/", opts)

-- ToggleTerm mapping_options
function _G.set_terminal_keymaps()
  map("t", "<Esc>", [[<C-\><C-n>]], opts)
  map("t", "jk", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
  map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
  map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
  map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
-- ToggleTerm

-- delete forward
-- w{number}dw
-- delete backward
-- w{number}db

map("n", "<C-P>", ':lua require("config.utils").toggle_go_test()<CR>', opts)
