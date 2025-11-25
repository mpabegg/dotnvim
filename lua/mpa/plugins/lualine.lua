local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients { bufnr = 0 }
  if #buf_clients == 0 then
    return nil
  end

  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end

  local unique_client_names = {}
  for _, client_name_target in ipairs(buf_client_names) do
    local is_duplicate = false
    for _, client_name_compare in ipairs(unique_client_names) do
      if client_name_target == client_name_compare then
        is_duplicate = true
      end
    end
    if not is_duplicate then
      table.insert(unique_client_names, client_name_target)
    end
  end

  local client_names_str = table.concat(unique_client_names, '  ')
  local language_servers = string.format('  %s', client_names_str)

  return language_servers
end

return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local icons = require 'mpa.icons'
      require('lualine').setup {
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = {
            statusline = { 'neo-tree' },
            winbar = { 'neo-tree' },
          },
        },
        winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filetype',
              icon_only = true,
              separator = '',
              padding = { left = 1, right = 0 },
            },
            {
              'filename',
              path = 1,
              file_status = true,
              newfile_status = true,
              symbols = {
                modified = icons.file.modified,
                readonly = icons.file.readonly,
              },
              separator = '',
            },
            {
              'navic',
              separator = '',
            },
          },
          lualine_x = {
            { 'diagnostics', symbols = icons.diagnostics },
          },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {
            {
              'filename',
              file_status = true,
              newfile_status = true,
              path = 0,

              symbols = {
                modified = icons.file.modified,
                readonly = icons.file.readonly,
              },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              function()
                local cwd = vim.fn.getcwd()
                local home = vim.fn.expand '~'
                if string.find(cwd, home, 1, true) == 1 then
                  return string.gsub(cwd, home, '~', 1)
                else
                  return cwd
                end
              end,
              separator = '',
            },
            { 'branch', color = { gui = 'italic' } },
          },
          lualine_c = { { 'diagnostics', sources = { 'nvim_workspace_diagnostic' }, symbols = icons.diagnostics } },
          lualine_x = {
            { require('lazy.status').updates, cond = require('lazy.status').has_updates },
            {
              function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == '' then
                  return ''
                else
                  return ' ' .. recording_register
                end
              end,
            },
          },
          lualine_y = {
            {
              get_attached_clients,
              cond = function()
                return get_attached_clients() ~= nil
              end,
            },
          },
          lualine_z = {
            { 'location' },
          },
        },
        extensions = { 'neo-tree' },
      }
    end,
  },
}
