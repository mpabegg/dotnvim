-- core/autocmds.lua - Autocommands configuration
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings group
local general = augroup("General", { clear = true })

-- Highlight yanked text
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- Restore cursor position when opening a file
autocmd("BufReadPost", {
  group = general,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position",
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = general,
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Auto-resize splits",
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = general,
  pattern = { "help", "qf", "lspinfo", "man", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close with q",
})
