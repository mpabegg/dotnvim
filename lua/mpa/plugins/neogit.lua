Add({
  source = 'NeogitOrg/neogit',
  dependes = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
})
Later(function()
  local neogit = require('neogit')
  neogit.setup({
    graph_style = 'unicode',
    integrations = { snacks = true },
  })

  vim.keymap.set('n', '<leader>gg', require('neogit').open, { desc = 'NeoGit' })
end)
