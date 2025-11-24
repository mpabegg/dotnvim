-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set({ 'n', 'v' }, '<localleader>x', '<CMD>so<CR>', { desc = 'Run Selection' })

-- File operations (f prefix)
vim.keymap.set('n', '<leader>fs', '<CMD>w<CR>', { desc = 'Save file' })

-- Quit operations (q prefix)
vim.keymap.set('n', '<leader>qq', '<CMD>q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>qw', '<CMD>x<CR>', { desc = 'Write and quit' })

-- Resize windows
vim.keymap.set('n', '<C-S-Up>', '<CMD>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Down>', '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Left>', '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-S-Right>', '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', '<CMD>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<CMD>bprevious<CR>', { desc = 'Previous buffer' })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', '<CMD>noh<CR>', { desc = 'Clear search highlighting', silent = true })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move text up and down in visual mode
-- Note: This overrides default J/K behavior (which extends selection in visual mode)
vim.keymap.set('v', 'J', "<CMD>m '>+1<CR>gv=gv", { desc = 'Move text down' })
vim.keymap.set('v', 'K', "<CMD>m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })

-- Keep search terms centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Window operations (w prefix)
vim.keymap.set('n', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>ws', '<CMD>split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wc', '<CMD>close<CR>', { desc = 'Close current split' })

vim.keymap.set('n', 'K', function()
  local ufo_ok, ufo = pcall(require, 'ufo')
  if ufo_ok then
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  else
    vim.lsp.buf.hover()
  end
end)
