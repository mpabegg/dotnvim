vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
}, { confirm = false })

local icons = require("mpa.icons")
require("neogit").setup({
  signs = {
    -- { CLOSED, OPENED }
    section = { icons.ui.carret_right, icons.ui.carret_down },
    item = { icons.ui.carret_right, icons.ui.carret_down },
  },
})

vim.keymap.set("n", "<leader>gs", require("neogit").open, { desc = "Open Neogit" })
