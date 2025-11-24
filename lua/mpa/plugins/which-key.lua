local vim = vim

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'
    wk.setup()

    vim.keymap.set('n', '<leader>?', function()
      wk.show { global = false }
    end, { desc = 'Buffer Local Keymaps (which-key)' })
  end,
}
