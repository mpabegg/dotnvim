vim.pack.add({ "https://github.com/folke/lazy.nvim" })
require("lazy").setup({
  { import = "plugins" },
},
  {
    -- Lazy.nvim configuration options
    checker = {
      enabled = true,
      notify = false,
    },
    install = { colorscheme = { "catppuccin-frappe" } },
    change_detection = {
      notify = false,
    },
    ui = {
      border = "rounded",
    },
  })
