local has_binstub = (vim.fn.filereadable(vim.fn.getcwd() .. '/bin/rubocop') == 1)
local function project_rubocop()
  return has_binstub and 'bin/rubocop' or 'rubocop'
end

return {
  'stevearc/conform.nvim',
  enabled = true,
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      formatters = {
        rubocop = {
          cmd = project_rubocop(),
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }

    vim.keymap.set('n', '<localleader>f', function()
      require('conform').format()
    end)
  end,
}
