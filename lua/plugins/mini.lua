vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
}, { confirm = false })

require'mini.trailspace'.setup()
require'mini.splitjoin'.setup()
require'mini.bufremove'.setup()
vim.keymap.set('n', '<leader>bd',  require('mini.bufremove').delete , { desc = 'Delete Buffer' })
