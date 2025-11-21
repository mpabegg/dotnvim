return {
  {
    'stevearc/oil.nvim',
    opts = {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = false,
      -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
      delete_to_trash = true,
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-r>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
    },
    keys = {
      {
        '<leader>fm',
        function()
          require('oil').open()
        end,
        desc = 'Oil',
      },
    },
    lazy = false,
  },
  {
    'A7Lavinraj/fyler.nvim',
    enabled = false,
    dependencies = { 'nvim-mini/mini.icons' },
    branch = 'stable',
    opts = {},
  },
}
