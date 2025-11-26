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
