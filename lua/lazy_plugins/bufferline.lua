return {
  'akinsho/bufferline.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  config = function()
    local icons = require 'mpa.icons'
    require('bufferline').setup {
      options = {
        close_command = require('mini.bufremove').delete,
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = '',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'snacks_layout_box',
          },
        },
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = ''
            local highlight = ''
            if e == 'error' then
              sym = icons.diagnostics.error
              highlight = '%#DiagnosticError#'
            elseif e == 'warning' then
              sym = icons.diagnostics.warn
              highlight = '%#DiagnosticWarn#'
            elseif e == 'info' then
              sym = icons.diagnostics.info
              highlight = '%#DiagnosticInfo#'
            elseif e == 'hint' then
              sym = icons.diagnostics.hint
              highlight = '%#DiagnosticHint#'
            end
            s = s .. highlight .. n .. sym .. '%*'
          end
          return s
        end,

        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, {
                text = ' ' .. require('mpa.icons').diagnostics.error .. error,
                link = 'DiagnosticError',
              })
            end

            if warning ~= 0 then
              table.insert(result, {
                text = ' ' .. require('mpa.icons').diagnostics.warn .. warning,
                link = 'DiagnosticWarn',
              })
            end

            if hint ~= 0 then
              table.insert(result, {
                text = ' ' .. require('mpa.icons').diagnostics.hint .. hint,
                link = 'DiagnosticHint',
              })
            end

            if info ~= 0 then
              table.insert(result, {
                text = ' ' .. require('mpa.icons').diagnostics.info .. info,
                link = 'DiagnosticInfo',
              })
            end
            return result
          end,
        },
      },
    }
  end,
}
