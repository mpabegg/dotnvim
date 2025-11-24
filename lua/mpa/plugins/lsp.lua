return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
    'j-hui/fidget.nvim',
  },
  config = function()
    require('fidget').setup {}
    require('mason').setup()
    require('lazydev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local servers = {
      ruby_lsp = {
        root_dir = function(fname)
          -- Custom root dir for COBRA/Monorepo
          -- Look for .git directory to correctly handle COBRA/Monorepo structures
          -- Using vim.fs.root to find the .git directory
          return vim.fs.root(fname, { '.git' }) or vim.fs.dirname(fname)
        end,
      },
      vtsls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
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
      'stylua',
    }

    require('mason-tool-installer').setup {
      ensure_installed = mason_tools,
    }

    -- Global LspAttach autocommand to disable formatting for specific servers
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspAttachDisableFormatting', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
          return
        end

        -- Disable formatting for vtsls/tsserver to allow none-ls (eslint) to handle it
        if client.name == 'vtsls' or client.name == 'tsserver' or client.name == 'ts_ls' then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end,
    })

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server_config = servers[server_name] or {}
          server_config.capabilities = capabilities

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

        -- Use the new Nvim 0.11+ LSP API
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
      end
    end
  end,
}
