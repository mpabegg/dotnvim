local icons = require('mpa.icons')
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  keys = {
    { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    { '<leader>fr', '<cmd>Neotree reveal_file=%<cr>',  desc = 'Reveal Current File on Neotree' },
    { '<leader>0', vim.cmd.Neotree,  desc = 'Focus on Neotree' },
  },
  opts = {
    window = {
      auto_expand_width = true, -- expand the window when file exceeds the window width. does not work with position = "float"
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
      diagnostics = { symbols = icons.diagnostics, },
    },
  },
}
