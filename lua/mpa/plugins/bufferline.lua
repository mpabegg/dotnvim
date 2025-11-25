return {
  'akinsho/bufferline.nvim',
  enabled = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = function()
    require('bufferline').setup {
      options = {
        close_command = require('mini.bufremove').delete,
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = '',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'snacks_layout_box',
          },
        },
        diagnostics = false,
      },
    }
  end,
}
