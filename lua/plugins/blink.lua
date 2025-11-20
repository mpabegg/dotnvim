vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
}, { confirm = false })

require("blink.cmp").setup({ fuzzy = { prebuilt_binaries = { force_version = "v1.8.0" } } })
