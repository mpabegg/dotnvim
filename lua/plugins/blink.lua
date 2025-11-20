vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
}, { confirm = false })

require("blink.cmp").setup({
  fuzzy = { prebuilt_binaries = { force_version = "v1.8.0" } },
  sources = {
    default = { "lsp", "path", "snippets", "lazydev" },
    providers = {
      lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },
  signature = { enabled = true },
  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
})
