return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettier' },
        lua = { 'stylua' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 3000, -- Rubocop can be slow on large files
      },
    }
  end,
}
