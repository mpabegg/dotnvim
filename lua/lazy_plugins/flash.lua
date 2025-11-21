return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  ---@type Flash.Config
  opts = {},
  keys = {
    {
      'f',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'F',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump { search = { forward = false, wrap = false, multi_window = false } }
      end,
      desc = 'Flash Backward',
    },
    {
      'gs',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'gr',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'gR',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
