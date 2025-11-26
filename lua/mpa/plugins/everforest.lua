-- Colorscheme: everforest
Add {
  source = 'neanias/everforest-nvim',
}
XNow(function()
  require('everforest').setup {
    background = 'soft',
    dim_inactive_windows = true,
  }
  vim.cmd.colorscheme [[everforest]]
end)
