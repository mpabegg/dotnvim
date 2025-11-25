local rubocop_cmd = function()
  if vim.fn.filereadable 'bin/rubocop' == 1 then
    return 'bin/rubocop'
  else
    return 'rubocop'
  end
end

return {
  cmd = { rubocop_cmd(), '--lsp' },
  root_markers = { '.git' },
}
