return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme'catppuccin-frappe'
    end
  },
  {
    "zenbones-theme/zenbones.nvim",
    lazy = false,
    dependencies = "rktjmp/lush.nvim",
    priority = 1000,
    config = function ()
      vim.g.zenbones_compat = 1
    end
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'soft'
    end
  },
  {
    "shaunsingh/nord.nvim",
    priority = 1000, -- Ensure it loads first
    lazy = false,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = 'warm'
    }
  }
}
