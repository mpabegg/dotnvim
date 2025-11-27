Add({ { source = 'folke/sidekick.nvim' } })
Later(function()
  require('sidekick').setup({
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
    },
  })

  vim.keymap.set('n', '<leader>aa', require('sidekick.cli').toggle, { desc = 'Sidekick Toggle CLI' })
  vim.keymap.set(
    'n',
    '<leader>ac',
    function() require('sidekick.cli').toggle({ name = 'cursor', focus = true }) end,
    { desc = 'Sidekick Toggle Cursor' }
  )
  vim.keymap.set(
    'n',
    '<leader>ao',
    function() require('sidekick.cli').toggle({ name = 'opencode', focus = true }) end,
    { desc = 'Sidekick Toggle OpenCode' }
  )

  vim.keymap.set(
    { 'n', 'x' },
    '<leader>ap',
    function() require('sidekick.cli').prompt() end,
    { desc = 'Sidekick Select Prompt' }
  )
  vim.keymap.set('n', '<leader>ad', function() require('sidekick.cli').close() end, { desc = 'Detach a CLI Session' })
  vim.keymap.set(
    { 'n', 'x' },
    '<leader>at',
    function() require('sidekick.cli').send({ msg = '{this}' }) end,
    { desc = 'Send This' }
  )
  vim.keymap.set(
    'n',
    '<leader>af',
    function() require('sidekick.cli').send({ msg = '{file}' }) end,
    { desc = 'Send File' }
  )
  vim.keymap.set(
    'x',
    '<leader>av',
    function() require('sidekick.cli').send({ msg = '{selection}' }) end,
    { desc = 'Send Visual Selection' }
  )
end)
