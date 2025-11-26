-- Formatting & Linting (none-ls)
Add {
  source = 'nvimtools/none-ls.nvim',
  depends = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
}
Later(function()
  local null_ls = require 'null-ls'
  local formatting = null_ls.builtins.formatting

  local sources = {
    formatting.stylua,
    formatting.prettier.with { prefer_local = 'node_modules/.bin' },
  }

  -- ESLint from extras
  local ok_fmt, eslint_fmt = pcall(require, 'none-ls.formatting.eslint')
  if ok_fmt then
    table.insert(sources, eslint_fmt.with { prefer_local = 'node_modules/.bin' })
  end

  local ok_diag, eslint_diag = pcall(require, 'none-ls.diagnostics.eslint')

  if ok_diag then
    table.insert(sources, eslint_diag.with { prefer_local = 'node_modules/.bin' })
  end

  null_ls.setup {
    sources = sources,
    on_attach = function(client, bufnr)
      if client:supports_method 'textDocument/formatting' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('NoneLsFormatting', { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              async = false,
              filter = function(c)
                return c.name == 'null-ls'
              end,
            }
          end,
        })
      end
    end,
  }
end)
