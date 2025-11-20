local vim = vim

local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return nil
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local null_ls_s, null_ls = pcall(require, "null-ls")
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

  local client_names_str = table.concat(unique_client_names, ", ")
  local language_servers = string.format("[%s]", client_names_str)

  return language_servers
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local icons = require("mpa.icons")

    local function maximize_status()
      return vim.t.maximized and "   " or ""
    end

    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = {
          {
            "filetype",
            colored = false,
          },
          {
            get_attached_clients,
            cond = function()
              return get_attached_clients() ~= nil
            end,
          },
        },
        lualine_b = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = icons.file.modified,
              readonly = "",
              unnamed = "",
            },
          },
        },
        lualine_c = {
          { maximize_status },
          { "diagnostics", symbols = icons.diagnostics },
        },
        lualine_x = {
          { "diff", symbols = icons.git },
        },
        lualine_y = {
          { "branch", color = { gui = "italic" } },
        },
        lualine_z = { { "location" } },
      },
      extensions = { "neo-tree" },
    })
  end,
}
