return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        ruby = { 'rubocop' },
        eruby = { 'erb_format' }, -- Optional: if you use erb-formatter
        javascript = { 'prettier' },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 3000, -- Rubocop can be slow on large files
      },
      formatters = {
        rubocop = {
          -- Custom logic to choose the binary
          command = function()
            if vim.fn.filereadable 'bin/rubocop' == 1 then
              return 'bin/rubocop'
            else
              return 'bundle'
            end
          end,
          -- Custom arguments based on the binary used
          args = function()
            local base_args = { '--server', '--auto-correct-all', '--stdin', '$FILENAME' }
            if vim.fn.filereadable 'bin/rubocop' == 1 then
              return base_args
            else
              -- If using bundle, we need to prepend "exec rubocop"
              local bundle_args = { 'exec', 'rubocop' }
              for _, v in ipairs(base_args) do
                table.insert(bundle_args, v)
              end
              return bundle_args
            end
          end,
        },
      },
    }
  end,
}
