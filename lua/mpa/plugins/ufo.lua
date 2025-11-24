return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'nvim-treesitter/nvim-treesitter',
  },
  event = 'VeryLazy',
  config = function()
    local opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
      preview = {
        win_config = {
          border = 'none',
          winhighlight = 'Normal:NormalFloat',
          winblend = 0,
        },
      },
    }

    require('ufo').setup(opts)
  end,
}
