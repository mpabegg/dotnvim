Add({
  { source = 'catppuccin/nvim' },
  { source = 'neanias/everforest-nvim' },
  { source = 'zenbones-theme/zenbones.nvim', depends = { 'rktjmp/lush.nvim' } },
})

Now(function()
  require('everforest').setup({
    background = 'soft',
    dim_inactive_windows = true,
  })
  require('catppuccin').setup({
    flavour = 'frappe', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    dim_inactive = {
      enabled = true,
    },
  })
  -- vim.cmd.colorscheme('catppuccin')
  -- vim.cmd.colorscheme('zenwritten')
  vim.cmd.colorscheme('everforest')
end)
