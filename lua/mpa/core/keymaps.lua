-- ============================================================================
-- Keymaps
-- ============================================================================

-- General keymaps
vim.keymap.set({ 'n', 'v' }, '<localleader>x', '<CMD>so<CR>', { desc = 'Run Selection' })

-- Window resizing
vim.keymap.set('n', '<C-S-Up>', '<CMD>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Down>', '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Left>', '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-S-Right>', '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Search
vim.keymap.set('n', '<Esc>', '<CMD>noh<CR>', { desc = 'Clear search highlighting', silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- Visual mode
vim.keymap.set({ 'v', 'x' }, '<', '<gv', { desc = 'Indent left' })
vim.keymap.set({ 'v', 'x' }, '>', '>gv', { desc = 'Indent right' })
vim.keymap.set('v', 'J', "<CMD>m '>+1<CR>gv=gv", { desc = 'Move text down' })
vim.keymap.set('v', 'K', "<CMD>m '<-2<CR>gv=gv", { desc = 'Move text up' })

-- Scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })

-- LSP (Core)
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover()
end)

-- Diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = 1, float = true }
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = -1, float = true }
end)
