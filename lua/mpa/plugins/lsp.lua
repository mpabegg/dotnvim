-- LSP
Add({
  source = 'neovim/nvim-lspconfig',
  depends = {
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
  },
})

Later(function()
  require('lazydev').setup({
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  })

  require('mason').setup()
  require('mason-tool-installer').setup({})

  local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
  local ufo_ok, _ = pcall(require, 'ufo')
  if ufo_ok then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.enable({ 'lua_ls', 'ruby_lsp', 'vtsls' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      local buffer = event.buf

      local map = function(mode, lhs, rhs, opts)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('keep', opts or {}, { buffer = buffer }))
      end

      map('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
      map('n', 'gl', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
      map('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Previous diagnostic' })
      map('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Next diagnostic' })

      map('n', '<localleader>f', vim.lsp.buf.format, { desc = 'LSP Format' })

      -- Snacks LSP pickers (only set if Snacks is available)
      local snacks_ok, Snacks = pcall(require, 'snacks')
      if snacks_ok and Snacks then
        map('n', 'gd', Snacks.picker.lsp_definitions, { desc = 'Goto Definition' })
        map('n', 'gD', Snacks.picker.lsp_declarations, { desc = 'Goto Declaration' })
        map('n', 'gr', Snacks.picker.lsp_references, { nowait = true, desc = 'References' })
        map('n', 'gI', Snacks.picker.lsp_implementations, { desc = 'Goto Implementation' })
        map('n', 'gy', Snacks.picker.lsp_type_definitions, { desc = 'Goto T[y]pe Definition' })
        map('n', 'gai', Snacks.picker.lsp_incoming_calls, { desc = 'C[a]lls Incoming' })
        map('n', 'gao', Snacks.picker.lsp_outgoing_calls, { desc = 'C[a]lls Outgoing' })
        map('n', '<leader>ss', Snacks.picker.lsp_symbols, { desc = 'LSP Symbols' })
        map('n', '<leader>sS', Snacks.picker.lsp_workspace_symbols, { desc = 'LSP Workspace Symbols' })
      end
    end,
    desc = 'Set LSP keymaps on attach',
  })
end)
