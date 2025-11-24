if true then
  return {}
end

local icons = require 'mpa.icons'
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    source = false,
    header = '',
    prefix = '',
  },
}

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = 1, float = true }
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = -1, float = true }
end)
