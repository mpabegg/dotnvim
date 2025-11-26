-- Which-key
Add { source = 'https://github.com/folke/which-key.nvim' }
Later(function()
  local wk = require 'which-key'
  wk.setup { preset = 'classic' }
  wk.add {
    { '<leader>f', group = 'find/file' },
    { '<leader>g', group = 'git' },
    { '<leader>s', group = 'search' },
    { '<leader>b', group = 'buffer' },
    { '<leader>w', group = 'window' },
    { '<leader>h', group = 'help' },
    { '<leader>a', group = 'ai' },
    { '<leader>u', group = 'ui' },
  }
end)
