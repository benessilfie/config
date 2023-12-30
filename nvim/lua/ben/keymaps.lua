vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- use jk to exit insert mode
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("v", "jk", "<Esc>", { silent = true })

-- move outside of brackets in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })

-- window management
vim.keymap.set("n", "<leader>pv", "<C-w>v", { silent = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ph", "<C-w>s", { silent = true, desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>px", ":close<CR>", { silent = true, desc = "Close window" })

-- General Keymaps
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>h", ":noh<CR>", { desc = "No Highlight" })
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer" })

-- Buffer Keymaps
vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>", { desc = "Pin buffer" })
vim.keymap.set("n", "<leader>bj", ":BufferLinePick<CR>", { desc = "Jump to buffer" })
vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", { desc = "Close all buffers to the right" })
vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", { desc = "Close all buffers to the left" })
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { silent = true, desc = "Close buffer" })

-- Plugin Keymaps
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true, desc = "LazyGit" })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
