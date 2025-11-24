local vim = vim

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  -- event = 'VeryLazy',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  cmd = {
    'Neotree',
  },
  keys = {
    -- File operations (f prefix)
    { '<leader>ft', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    { '<leader>fr', '<cmd>Neotree reveal_file=%<cr>', desc = 'Reveal Current File on Neotree' },
    { '<leader>0', vim.cmd.Neotree, desc = 'Focus on Neotree' },
  },
  config = function()
    local icons = require 'mpa.icons'
    require('neo-tree').setup {
      window = {
        auto_expand_width = true,
        mappings = {
          ['h'] = 'close_node',
          ['l'] = 'open',
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
          ['<Space>'] = 'none',
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      default_component_configs = {
        diagnostics = { symbols = icons.diagnostics },
      },
    }
  end,
}
