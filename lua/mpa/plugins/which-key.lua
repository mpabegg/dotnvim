local vim = vim

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'
    wk.setup()

    -- Register which-key groups for mnemonic prefix discovery (new spec format)
    wk.add {
      { '<leader>a', group = 'ai/assistant' },
      { '<leader>b', group = 'buffer' },
      { '<leader>f', group = 'file' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'help' },
      { '<leader>l', group = 'lsp' },
      { '<leader>o', group = 'other/open' },
      { '<leader>q', group = 'quit/quickfix' },
      { '<leader>s', group = 'search' },
      { '<leader>u', group = 'ui/utilities' },
      { '<leader>w', group = 'window' },
    }

    -- Help operations (h prefix)
    vim.keymap.set('n', '<leader>h?', function()
      wk.show { global = false }
    end, { desc = 'Buffer Local Keymaps (which-key)' })
  end,
}
