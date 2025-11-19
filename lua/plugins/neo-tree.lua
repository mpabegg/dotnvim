vim.pack.add({
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/s1n7ax/nvim-window-picker' },
}, { confirm = false })
local icons = require('mpa.icons')
require'neo-tree'.setup(
{
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
  }
)

 vim.keymap.set('n', "<leader>ft", "<cmd>Neotree toggle<cr>", { desc = "NeoTree" })
 vim.keymap.set('n', '<leader>fr', '<cmd>Neotree reveal_file=%<cr>', {  desc = 'Reveal Current File on Neotree' })
 vim.keymap.set('n', '<leader>0', vim.cmd.Neotree,{ desc = 'Focus on Neotree' })
