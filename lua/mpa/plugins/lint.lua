return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- 1. Define a custom linter for your bin stub
    -- We clone the default rubocop definition to keep the parser logic
    -- but override the command.
    lint.linters.rubocop_bin = assert(vim.deepcopy(lint.linters.rubocop))
    lint.linters.rubocop_bin.cmd = 'bin/rubocop'
    -- Ensure arguments match what bin/rubocop expects (usually standard rubocop args)
    lint.linters.rubocop_bin.args = {
      '--server', -- Speed up subsequent runs
      '--format',
      'json',
      '--force-exclusion',
      '--stdin',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    -- 2. Logic to choose the correct linter
    -- If bin/rubocop exists, use the custom one. Otherwise, default.
    local rubocop_linter = 'rubocop'
    if vim.fn.filereadable 'bin/rubocop' == 1 then
      rubocop_linter = 'rubocop_bin'
    end

    lint.linters_by_ft = {
      ruby = { rubocop_linter },
      -- Add javascript/typescript linters here if needed
    }

    -- 3. Create the Autocommand to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
