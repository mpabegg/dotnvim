return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'catppuccin-frappe'
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'warm',
      }
      require('onedark').load()
    end,
  },
}
