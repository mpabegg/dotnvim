-- ============================================================================
-- Editor (Editing Utilities & Navigation)
-- ============================================================================

-- Mini.trailspace
Add { source = 'nvim-mini/mini.trailspace' }
Later(function()
  require('mini.trailspace').setup()
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('General', { clear = false }),
    pattern = '*',
    callback = function()
      require('mini.trailspace').trim()
      require('mini.trailspace').trim_last_lines()
    end,
    desc = 'Remove trailing whitespace on save',
  })
end)

-- Tmux navigation
Add 'alexghergh/nvim-tmux-navigation'
Later(function()
  require('nvim-tmux-navigation').setup {
    disable_when_zoomed = true,
    keybindings = {
      left = '<C-h>',
      down = '<C-j>',
      up = '<C-k>',
      right = '<C-l>',
    },
  }
end)

-- Which-key
Add { source = 'https://github.com/folke/which-key.nvim' }
Later(function()
  local wk = require 'which-key'
  wk.setup { preset = 'classic' }
  wk.add {
    { '<leader>f', group = 'find/file' },
    { '<leader>g', group = 'git' },
    { '<leader>s', group = 'search' },
    { '<leader>b', group = 'buffer' },
    { '<leader>w', group = 'window' },
    { '<leader>h', group = 'help' },
    { '<leader>a', group = 'ai' },
  }
end)

-- UFO (Folding)
Add {
  source = 'kevinhwang91/nvim-ufo',
  depends = { 'kevinhwang91/promise-async' },
}
Later(function()
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  require('ufo').setup {
    provider_selector = function(bufnr, filetype, buftype)
      local clients = vim.lsp.get_clients { bufnr = bufnr }
      for _, client in ipairs(clients) do
        if client.server_capabilities.foldingRangeProvider then
          return { 'lsp', 'indent' }
        end
      end
      return { 'treesitter', 'indent' }
    end,
  }
end)
