-- Colorscheme: catppuccin
Add {
  source = 'catppuccin/nvim',
}
Now(function()
  require('catppuccin').setup {
    flavour = 'frappe', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'frappe',
    },
    dim_inactive = {
      enabled = true,
    },
  }
  vim.cmd.colorscheme 'catppuccin'
end)
