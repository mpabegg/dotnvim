-- Colorizer
XAdd { { source = 'norcalli/nvim-colorizer.lua' } }
XLater(function()
  require('colorizer').setup()
end)
