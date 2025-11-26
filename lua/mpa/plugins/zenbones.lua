-- Colorscheme: zenbones
Add {
  source = 'zenbones-theme/zenbones.nvim',
  depends = { 'rktjmp/lush.nvim' },
}
XNow(function()
  vim.cmd.colorscheme [[zenwritten]]
end)
