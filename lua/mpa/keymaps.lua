-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set({ 'n', 'v' }, '<localleader>x', ':so<CR>', { desc = 'Run Selection' })

-- General keymaps
vim.keymap.set('n', '<leader>fs', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>qq', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>qx', ':x<CR>', { desc = 'Save and quit' })

-- Resize windows
vim.keymap.set('n', '<C-S-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-S-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = 'Clear search highlighting' })

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move text up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Keep cursor centered when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })

-- Keep search terms centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Split windows
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>ws', ':split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wd', ':close<CR>', { desc = 'Close current split' })
