local vim = vim

return {
  'nvim-mini/mini.nvim',
  event = 'VeryLazy',
  config = function()
    require('mini.trailspace').setup()
    require('mini.splitjoin').setup()
    require('mini.bufremove').setup()
    require('mini.icons').setup()
    require('mini.diff').setup()
    require('mini.indentscope').setup()

    -- Buffer operations (b prefix)
    vim.keymap.set('n', '<leader>bd', require('mini.bufremove').delete, { desc = 'Delete Buffer' })
  end,
}
