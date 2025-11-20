local icons = require("mpa.icons")
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

-- ─────────────────────────────────────────────────────────────────────────────
-- LSP / null-ls clients (same idea as your lualine get_attached_clients)
-- ─────────────────────────────────────────────────────────────────────────────
local function get_attached_clients()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return nil
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" and client.name ~= "none-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- Optional: support null-ls / none-ls style sources
  local ok_null, null_ls = pcall(require, "null-ls")
  if not ok_null then
    ok_null, null_ls = pcall(require, "none-ls")
  end

  if ok_null then
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

  local unique = {}
  for _, name in ipairs(buf_client_names) do
    local dup = false
    for _, seen in ipairs(unique) do
      if name == seen then
        dup = true
        break
      end
    end
    if not dup then
      table.insert(unique, name)
    end
  end

  if #unique == 0 then
    return nil
  end

  return string.format("[%s]", table.concat(unique, ", "))
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Custom diagnostics section using icons.diagnostics
-- expects icons.diagnostics = { error = "...", warn = "...", info = "...", hint = "..." }
-- ─────────────────────────────────────────────────────────────────────────────
local function section_diagnostics_custom(trunc_width)
  local ms = require("mini.statusline")
  if ms.is_truncated(trunc_width or 75) then
    return ""
  end

  local sev = vim.diagnostic.severity
  local counts = {
    error = #vim.diagnostic.get(0, { severity = sev.ERROR }),
    warn = #vim.diagnostic.get(0, { severity = sev.WARN }),
    info = #vim.diagnostic.get(0, { severity = sev.INFO }),
    hint = #vim.diagnostic.get(0, { severity = sev.HINT }),
  }

  if counts.error == 0 and counts.warn == 0 and counts.info == 0 and counts.hint == 0 then
    return ""
  end

  local parts = {}
  if counts.error > 0 and icons.diagnostics and icons.diagnostics.error then
    table.insert(parts, icons.diagnostics.error .. counts.error)
  end
  if counts.warn > 0 and icons.diagnostics and icons.diagnostics.warn then
    table.insert(parts, icons.diagnostics.warn .. counts.warn)
  end
  if counts.info > 0 and icons.diagnostics and icons.diagnostics.info then
    table.insert(parts, icons.diagnostics.info .. counts.info)
  end
  if counts.hint > 0 and icons.diagnostics and icons.diagnostics.hint then
    table.insert(parts, icons.diagnostics.hint .. counts.hint)
  end

  return table.concat(parts, " ")
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Custom git section using icons.git
-- expects icons.git = { added = "...", modified = "...", removed = "..." }
-- uses gitsigns for branch + diff info
-- ─────────────────────────────────────────────────────────────────────────────
local function section_git_custom(trunc_width)
  local ms = require("mini.statusline")
  if ms.is_truncated(trunc_width or 75) then
    return ""
  end

  local gsd = vim.b.gitsigns_status_dict
  if not gsd or not gsd.head or gsd.head == "" then
    return ""
  end

  local parts = {}

  -- branch (use the same branch glyph lualine uses by default)
  table.insert(parts, " " .. gsd.head)

  local added = gsd.added or 0
  local changed = gsd.changed or 0
  local removed = gsd.removed or 0
  local git_icons = icons.git or {}

  if added > 0 and git_icons.added then
    table.insert(parts, git_icons.added .. added)
  end
  if changed > 0 and (git_icons.modified or git_icons.changed) then
    local icon = git_icons.modified or git_icons.changed
    table.insert(parts, icon .. changed)
  end
  if removed > 0 and git_icons.removed then
    table.insert(parts, git_icons.removed .. removed)
  end

  return table.concat(parts, " ")
end

-- ─────────────────────────────────────────────────────────────────────────────
-- mini.statusline setup, plugging in the custom sections
-- ─────────────────────────────────────────────────────────────────────────────
require("mini.statusline").setup({
  use_icons = true,
  set_vim_settings = false,
  content = {
    active = function()
      local ms = require("mini.statusline")

      -- file icon only (like lualine "filetype", icon_only = true)
      local icon = ""
      if devicons_ok then
        local filename = vim.api.nvim_buf_get_name(0)
        if filename ~= "" then
          local name = vim.fn.fnamemodify(filename, ":t")
          icon = (devicons.get_icon(name, nil, { default = true }) or "") .. " "
        end
      end

      local lsp_segment = get_attached_clients() or ""

      local filename = ms.section_filename({ trunc_width = 140 })
      local diags = section_diagnostics_custom(75)
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local location = "%2l:%-2v"

      return ms.combine_groups({
        -- left
        { hl = "MiniStatuslineDevinfo", strings = { icon, lsp_segment } },
        { hl = "MiniStatuslineFilename", strings = { " ", filename } },

        "%=",

        -- right
        { hl = "MiniStatuslineDiagnostic", strings = { diags ~= "" and diags or "" } },
        { hl = "MiniStatuslineGit", strings = { git ~= "" and (" " .. git) or "" } },
        { hl = "MiniStatuslineFileinfo", strings = { location } },
      })
    end,
  },
})

-- Optional: italic git section like your lualine branch
vim.api.nvim_set_hl(0, "MiniStatuslineGit", { italic = true, link = "MiniStatuslineDevinfo" })
