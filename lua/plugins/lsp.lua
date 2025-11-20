vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/folke/lazydev.nvim' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
}, { confirm = false })

require('fidget').setup({})
require('mason').setup()
require('mason-lspconfig').setup()
require('lazydev').setup()
require('mason-tool-installer').setup({
  ensure_installed = { 'lua_ls', 'stylua' },
})
