local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients { bufnr = 0 }
  if #buf_clients == 0 then
    return nil
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  local null_ls_s, null_ls = pcall(require, 'null-ls')
  if null_ls_s then
    local sources = null_ls.get_sources()
    for _, source in ipairs(sources) do
      if source._validated then
        for ft_name, ft_active in pairs(source.filetypes) do
          if ft_name == buf_ft and ft_active then
            table.insert(buf_client_names, source.name)
          end
        end
      end
    end
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
    enabled = true,
    config = function()
      local icons = require 'mpa.icons'

      require('lualine').setup {
        options = {
          component_separators = { left = '║', right = '║' },
          section_separators = { left = '║', right = '║' },
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
          lualine_a = {
            { 'mode' },
            {
              function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == '' then
                  return ''
                else
                  return 'recording @' .. recording_register
                end
              end,
            },
          },
          lualine_b = { { 'branch', color = { gui = 'italic' } } },
          lualine_c = { { 'diagnostics', sources = { 'nvim_workspace_diagnostic' }, symbols = icons.diagnostics } },
          lualine_x = { { require('lazy.status').updates, cond = require('lazy.status').has_updates } },
          lualine_y = {
            {
              get_attached_clients,
              cond = function()
                return get_attached_clients() ~= nil
              end,
            },
          },
          lualine_z = {
            { 'location', separator = '', padding = { right = 1, left = 0 } },
            { 'progress', padding = { left = 0, right = 1 } },
          },
        },
        extensions = { 'neo-tree' },
      }
    end,
  },
}
