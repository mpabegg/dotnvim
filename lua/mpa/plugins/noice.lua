-- Noice
Add {
  source = 'folke/noice.nvim',
  depends = { 'MunifTanjim/nui.nvim' },
}
Later(function()
  require('noice').setup()
end)
