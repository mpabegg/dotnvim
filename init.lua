require 'mpa.opts'
require 'mpa.keymaps'
require 'mpa.autocmds'
require 'mpa.diagnostics'

vim.pack.add { 'https://github.com/folke/lazy.nvim' }
require('lazy').setup {
  spec = { { import = 'lazy_plugins' } },
  install = { colorscheme = { 'catppuccin-frappe' } },
  checker = {
    enabled = true,
    frequency = 3600 * 24,
  },
  change_detection = { notify = false },
}
