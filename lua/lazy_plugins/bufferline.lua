return {
  'akinsho/bufferline.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = function()
    local icons = require 'mpa.icons'
    require('bufferline').setup {
      options = {
        close_command = require('mini.bufremove').delete,
        always_show_bufferline = false,
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
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and icons.diagnostics.error or (e == 'warning' and icons.diagnostics.warn or icons.diagnostics.info)
            s = s .. n .. sym
          end
          return s
        end,
      },
    }
  end,
}
