vim.pack.add({
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
local icons = require('mpa.icons')
require('bufferline').setup({
  options = {
    close_command = require'mini.bufremove'.delete,
    show_buffer_close_icons =  false,
    offsets = {
      {
        filetype = "neo-tree",
        text = "",
        highlight = "Directory",
        text_align = "left",
      },
    },
    separator_style = "slant",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _) local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and icons.diagnostics.error
        or (e == "warning" and icons.diagnostics.warn or icons.diagnostics.info)
        s = s .. n .. sym
      end
      return s
    end,
  }
})
