local vim = vim

return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  lazy = false,
  config = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = 'tmux',
        tmux = {
          options = '-h',
        },
      },
    }
    vim.o.autoread = true

    -- Other/Open operations (o prefix)
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Opencode: Ask' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
      require('opencode').select()
    end, { desc = 'Opencode: Execute action' })
    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      require('opencode').toggle()
    end, { desc = 'Opencode: Toggle' })
    vim.keymap.set({ 'n', 'x' }, '<leader>op', function()
      require('opencode').prompt '@this'
    end, { desc = 'Opencode: Add to prompt' })
    vim.keymap.set('n', '<leader>ou', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Opencode: half page up' })
    vim.keymap.set('n', '<leader>od', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Opencode: half page down' })
  end,
}
