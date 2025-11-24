return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    -- Function to find project rubocop
    local function project_rubocop()
      if vim.fn.filereadable 'bin/rubocop' == 1 then
        return 'bin/rubocop'
      end
      return 'rubocop'
    end

    -- Function to find project eslint
    local function project_eslint()
      -- Prefer local eslint executable if available
      if vim.fn.filereadable 'node_modules/.bin/eslint' == 1 then
        return 'node_modules/.bin/eslint'
      end
      return 'eslint'
    end

    local sources = {
      null_ls.builtins.formatting.stylua,
      -- Prettier is built-in, so access it via builtins
      -- Enabled for all default supported filetypes (including js/ts)
      -- to handle general layout/formatting that eslint might not cover
      null_ls.builtins.formatting.prettier,

      -- eslint_d diagnostics
      require 'none-ls.diagnostics.eslint_d',

      -- Use plain eslint for formatting to ensure reliability and consistency with 'eslint --fix'
      -- We use none-ls-extras for this as it was removed from builtins
      require('none-ls.formatting.eslint').with {
        command = project_eslint(),
      },

      -- Rubocop formatting
      null_ls.builtins.formatting.rubocop.with {
        command = project_rubocop(),
      },
      -- Rubocop diagnostics
      null_ls.builtins.diagnostics.rubocop.with {
        command = project_rubocop(),
      },
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client:supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  -- Explicitly prevent vtsls/tsserver from formatting
                  -- This prevents it from undoing or fighting with eslint
                  return c.name ~= 'vtsls' and c.name ~= 'tsserver' and c.name ~= 'ts_ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
