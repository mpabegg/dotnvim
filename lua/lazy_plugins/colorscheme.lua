return {
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        -- add the config here
      }
    end,
  },
  { 'ellisonleao/gruvbox.nvim', config = true },
  { 'neanias/everforest-nvim' },
  {
    -- testing
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme [[catppuccin-frappe]]
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = true,
  },
}
