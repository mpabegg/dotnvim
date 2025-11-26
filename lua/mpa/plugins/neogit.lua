Add {
  source = 'NeogitOrg/neogit',
  dependes = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
}
Later(function()
  local neogit = require 'neogit'
  neogit.setup {
    -- "ascii"   is the graph the git CLI generates
    -- "unicode" is the graph like https://github.com/rbong/vim-flog
    -- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
    graph_style = 'unicode',
    integrations = {
      snacks = true,
    },
  }
end)
