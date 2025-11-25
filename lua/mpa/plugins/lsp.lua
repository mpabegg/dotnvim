return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
    {
      'SmiteshP/nvim-navic',
      opts = {
        highlight = false,
        separator = '  ',
        depth_limit = 5,
        lsp = {
          auto_attach = true,
        },
      },
    },
  },
  config = function()
    local function on_attach(client, buffer)
      -- Use Snacks for LSP list operations
      vim.keymap.set('n', 'gd', function()
        Snacks.picker.lsp_definitions()
      end, { desc = 'Go to Definition', buffer = buffer })

      vim.keymap.set('n', 'gr', function()
        Snacks.picker.lsp_references()
      end, { desc = 'Find References', buffer = buffer })

      vim.keymap.set('n', 'gI', function()
        Snacks.picker.lsp_implementations()
      end, { desc = 'Go to Implementation', buffer = buffer })

      vim.keymap.set('n', 'gy', function()
        Snacks.picker.lsp_type_definitions()
      end, { desc = 'Go to Type Definition', buffer = buffer })

      -- Format buffer
      vim.keymap.set('n', '<localleader>f', function()
        vim.lsp.buf.format { async = true }
      end, { desc = 'Format Buffer', buffer = buffer })

      -- LSP operations (l prefix)
      vim.keymap.set('n', '<leader>ls', function()
        Snacks.picker.lsp_symbols()
      end, { desc = 'Document Symbols', buffer = buffer })

      -- Disable formatting for vtsls/tsserver to allow conform (eslint) to handle it
      if client.name == 'vtsls' or client.name == 'tsserver' or client.name == 'ts_ls' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end

    require('mason').setup()
    require('lazydev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local servers = {
      vtsls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim', 'Snacks' } },
          },
        },
      },
    }

    local mason_tools = {
      'ruby-lsp',
      'vtsls',
      'rubocop',
      'prettier',
      'eslint_d',
      'lua_ls',
      'stylua',
    }

    require('mason-tool-installer').setup {
      ensure_installed = mason_tools,
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server_config = servers[server_name] or {}
          server_config.capabilities = capabilities
          server_config.on_attach = on_attach

          -- Use the new Nvim 0.11+ LSP API
          vim.lsp.config(server_name, server_config)
          vim.lsp.enable(server_name)
        end,
      },
    }

    -- Manual Server Support
    local mason_servers = require('mason-lspconfig').get_installed_servers()
    local all_servers = vim.tbl_keys(servers)

    for _, server_name in ipairs(all_servers) do
      local is_mason = false
      for _, m_server in ipairs(mason_servers) do
        if m_server == server_name then
          is_mason = true
          break
        end
      end

      if not is_mason then
        local config = servers[server_name] or {}
        config.capabilities = capabilities
        config.on_attach = on_attach

        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end
    end
  end,
}
