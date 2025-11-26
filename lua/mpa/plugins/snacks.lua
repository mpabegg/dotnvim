-- Snacks
Add {
  source = 'folke/snacks.nvim',
}
Now(function()
  require('snacks').setup {
    picker = {
      actions = {
        sidekick_send = function(...)
          return require('sidekick.cli.picker.snacks').send(...)
        end,
      },
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = true,
      trash = true,
    },
    bigfile = { enabled = true },
    indent = { enabled = true },
  }

  -- Snacks: Top level maps
  vim.keymap.set('n', '<leader>0', function()
    -- Check if Snacks is available
    if not Snacks or not Snacks.explorer then
      vim.notify('Snacks explorer is not available', vim.log.levels.WARN)
      return
    end

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) then
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')

        if filetype == 'snacks_picker_list' then
          explorer_win_id = win
          vim.api.nvim_set_current_win(win)
          return
        end
      end
    end

    Snacks.explorer()
  end, { desc = 'Focus Snacks Explorer' })

  vim.keymap.set('n', '<leader><leader>', function()
    Snacks.picker.smart()
  end, { desc = 'Smart Find' })
  vim.keymap.set('n', '<localleader><localleader>', function()
    Snacks.picker.buffers()
  end, { desc = 'Find Buffer' })
  vim.keymap.set('n', '<leader>/', function()
    Snacks.picker.grep()
  end, { desc = 'Grep' })
  vim.keymap.set('n', '<leader>:', function()
    Snacks.picker.command_history()
  end, { desc = 'Command History' })
  vim.keymap.set('n', '<leader>n', function()
    Snacks.picker.notifications()
  end, { desc = 'Notification History' })
  vim.keymap.set('n', '<leader>e', function()
    Snacks.explorer()
  end, { desc = 'File Explorer' })
  vim.keymap.set({ 'n', 'x' }, '<leader>*', function()
    Snacks.picker.grep_word()
  end, { desc = 'Visual selection or word' })
  vim.keymap.set('n', '<leader>.', function()
    Snacks.scratch()
  end, { desc = 'Toggle Scratch Buffer' })
  vim.keymap.set('n', '<leader>S', function()
    Snacks.scratch.select()
  end, { desc = 'Select Scratch Buffer' })
  vim.keymap.set('n', '<leader>n', function()
    Snacks.notifier.show_history()
  end, { desc = 'Notification History' })
  vim.keymap.set('n', '<leader>w', '<CMD>w<CR>', { desc = 'Save file' })
  Snacks.toggle.zoom():map '<leader>z'

  -- Snacks: find/file
  vim.keymap.set('n', '<leader>fc', function()
    Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
  end, { desc = 'Find Config File' })
  vim.keymap.set('n', '<leader>ff', function()
    Snacks.picker.files()
  end, { desc = 'Find Files' })
  vim.keymap.set('n', '<leader>fg', function()
    Snacks.picker.git_files()
  end, { desc = 'Find Git Files' })
  vim.keymap.set('n', '<leader>fr', function()
    Snacks.picker.recent()
  end, { desc = 'Recent' })
  vim.keymap.set('n', '<leader>ft', function()
    Snacks.explorer()
  end, { desc = 'File Tree' })
  vim.keymap.set('n', '<leader>fm', function() end, { desc = 'File Manager' })
  vim.keymap.set('n', '<leader>fs', '<CMD>w<CR>', { desc = 'Save file' })

  -- Snacks: buffer
  vim.keymap.set('n', '<leader>bd', function()
    Snacks.bufdelete()
  end, { desc = 'Delete Buffer' })
  vim.keymap.set('n', '<S-l>', '<CMD>bnext<CR>', { desc = 'Next buffer' })
  vim.keymap.set('n', '<S-h>', '<CMD>bprevious<CR>', { desc = 'Previous buffer' })

  -- Snacks: window
  vim.keymap.set('n', '<leader>wv', '<CMD>vsplit<CR>', { desc = 'Split window vertically' })
  vim.keymap.set('n', '<leader>ws', '<CMD>split<CR>', { desc = 'Split window horizontally' })
  vim.keymap.set('n', '<leader>wd', '<CMD>close<CR>', { desc = 'Close current split' })
  vim.keymap.set('n', '<leader>wc', '<CMD>close<CR>', { desc = 'Close current split' })

  -- Snacks: git
  vim.keymap.set('n', '<leader>gg', require('neogit').open, { desc = 'NeoGit' })
  vim.keymap.set('n', '<leader>gb', function()
    Snacks.picker.git_branches()
  end, { desc = 'Git Branches' })
  vim.keymap.set('n', '<leader>gl', function()
    Snacks.picker.git_log()
  end, { desc = 'Git Log' })
  vim.keymap.set('n', '<leader>gL', function()
    Snacks.picker.git_log_line()
  end, { desc = 'Git Log Line' })
  vim.keymap.set('n', '<leader>gs', function()
    Snacks.picker.git_status()
  end, { desc = 'Git Status' })
  vim.keymap.set('n', '<leader>gS', function()
    Snacks.picker.git_stash()
  end, { desc = 'Git Stash' })
  vim.keymap.set('n', '<leader>gd', function()
    Snacks.picker.git_diff()
  end, { desc = 'Git Diff (Hunks)' })
  vim.keymap.set('n', '<leader>gf', function()
    Snacks.picker.git_log_file()
  end, { desc = 'Git Log File' })

  -- Snacks: search
  vim.keymap.set('n', '<leader>sb', function()
    Snacks.picker.lines()
  end, { desc = 'Buffer Lines' })
  vim.keymap.set('n', '<leader>sB', function()
    Snacks.picker.grep_buffers()
  end, { desc = 'Grep Open Buffers' })
  vim.keymap.set('n', '<leader>sr', function()
    Snacks.picker.registers()
  end, { desc = 'Registers' })
  vim.keymap.set('n', '<leader>s/', function()
    Snacks.picker.search_history()
  end, { desc = 'Search History' })
  vim.keymap.set('n', '<leader>sa', function()
    Snacks.picker.autocmds()
  end, { desc = 'Autocmds' })
  vim.keymap.set('n', '<leader>sc', function()
    Snacks.picker.command_history()
  end, { desc = 'Command History' })
  vim.keymap.set('n', '<leader>sC', function()
    Snacks.picker.commands()
  end, { desc = 'Commands' })
  vim.keymap.set('n', '<leader>sd', function()
    Snacks.picker.diagnostics()
  end, { desc = 'Diagnostics' })
  vim.keymap.set('n', '<leader>sD', function()
    Snacks.picker.diagnostics_buffer()
  end, { desc = 'Buffer Diagnostics' })
  vim.keymap.set('n', '<leader>sH', function()
    Snacks.picker.highlights()
  end, { desc = 'Highlights' })
  vim.keymap.set('n', '<leader>si', function()
    Snacks.picker.icons()
  end, { desc = 'Icons' })
  vim.keymap.set('n', '<leader>sj', function()
    Snacks.picker.jumps()
  end, { desc = 'Jumps' })
  vim.keymap.set('n', '<leader>sl', function()
    Snacks.picker.loclist()
  end, { desc = 'Location List' })
  vim.keymap.set('n', '<leader>sm', function()
    Snacks.picker.marks()
  end, { desc = 'Marks' })
  vim.keymap.set('n', '<leader>sM', function()
    Snacks.picker.man()
  end, { desc = 'Man Pages' })
  vim.keymap.set('n', '<leader>sp', function()
    Snacks.picker.lazy()
  end, { desc = 'Search for Plugin Spec' })
  vim.keymap.set('n', '<leader>sq', function()
    Snacks.picker.qflist()
  end, { desc = 'Quickfix List' })
  vim.keymap.set('n', '<leader>sR', function()
    Snacks.picker.resume()
  end, { desc = 'Resume' })
  vim.keymap.set('n', '<leader>su', function()
    Snacks.picker.undo()
  end, { desc = 'Undo History' })

  -- Snacks: utility
  vim.keymap.set('n', '<leader>uC', function()
    Snacks.picker.colorschemes()
  end, { desc = 'Colorschemes' })

  -- Snacks: help
  vim.keymap.set('n', '<leader>hh', function()
    Snacks.picker.help()
  end, { desc = 'Help Pages' })
  vim.keymap.set('n', '<leader>hk', function()
    Snacks.picker.keymaps()
  end, { desc = 'Keymaps' })

  -- Snacks: LSP
  vim.keymap.set('n', 'gd', function()
    Snacks.picker.lsp_definitions()
  end, { desc = 'Goto Definition' })
  vim.keymap.set('n', 'gD', function()
    Snacks.picker.lsp_declarations()
  end, { desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gr', function()
    Snacks.picker.lsp_references()
  end, { nowait = true, desc = 'References' })
  vim.keymap.set('n', 'gI', function()
    Snacks.picker.lsp_implementations()
  end, { desc = 'Goto Implementation' })
  vim.keymap.set('n', 'gy', function()
    Snacks.picker.lsp_type_definitions()
  end, { desc = 'Goto T[y]pe Definition' })
  vim.keymap.set('n', 'gai', function()
    Snacks.picker.lsp_incoming_calls()
  end, { desc = 'C[a]lls Incoming' })
  vim.keymap.set('n', 'gao', function()
    Snacks.picker.lsp_outgoing_calls()
  end, { desc = 'C[a]lls Outgoing' })
  vim.keymap.set('n', '<leader>ss', function()
    Snacks.picker.lsp_symbols()
  end, { desc = 'LSP Symbols' })
  vim.keymap.set('n', '<leader>sS', function()
    Snacks.picker.lsp_workspace_symbols()
  end, { desc = 'LSP Workspace Symbols' })

  -- Snacks: other
  vim.keymap.set('n', '<leader>un', function()
    Snacks.notifier.hide()
  end, { desc = 'Dismiss All Notifications' })
  vim.keymap.set({ 'n', 't' }, ']]', function()
    Snacks.words.jump(vim.v.count1)
  end, { desc = 'Next Reference' })
  vim.keymap.set({ 'n', 't' }, '[[', function()
    Snacks.words.jump(-vim.v.count1)
  end, { desc = 'Prev Reference' })
end)
