local vim = vim

return {
  'folke/snacks.nvim',
  lazy = false,
  keys = {
    {
      '<leader>uC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
  },
  config = function()
    require('snacks').setup {
      picker = {
        win = {
          input = {
            keys = {
              ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            },
          },
        },
      },
      explorer = {
        enabled = false,
        replace_netrw = true,
        trash = true,
      },
    }

    vim.keymap.set('n', '<leader>ff', function()
      Snacks.picker.files { hidden = true }
    end, { desc = 'Find File (Snacks)' })
    vim.keymap.set('n', '<leader>bb', function()
      Snacks.picker.buffers()
    end, { desc = 'Buffers (Snacks)' })
    vim.keymap.set('n', '<leader>,', function()
      Snacks.picker.buffers()
    end, { desc = 'Buffers (Snacks)' })
    vim.keymap.set('n', '<leader>hk', function()
      Snacks.picker.keymaps()
    end, { desc = 'Keymaps (Snacks)' })
    vim.keymap.set('n', '<leader>hh', function()
      Snacks.picker.help()
    end, { desc = 'Help (Snacks)' })
    vim.keymap.set('n', '<leader>sq', function()
      Snacks.picker.qflist()
    end, { desc = 'Quickfix (Snacks)' })
    vim.keymap.set('n', '<leader>sl', function()
      Snacks.picker.resume()
    end, { desc = 'Resume Picker (Snacks)' })
    vim.keymap.set('n', '<leader>/', function()
      Snacks.picker.grep()
    end, { desc = 'Search Project (Snacks)' })
    vim.keymap.set('n', '<leader>*', function()
      Snacks.picker.grep_word()
    end, { desc = 'Grep Word (Snacks)' })

    Snacks.toggle.zoom():map('<leader>wm'):map '<leader>z'
  end,
}
