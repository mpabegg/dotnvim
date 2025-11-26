-- Blink (Completion)
Add {
  source = 'saghen/blink.cmp',
  depends = {
    'rafamadriz/friendly-snippets',
    'folke/lazydev.nvim',
  },
}
Later(function()
  require('blink.cmp').setup {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'normal' },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  }
end)
