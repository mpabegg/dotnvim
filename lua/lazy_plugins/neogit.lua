local vim = vim

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  config = function()
    local icons = require("mpa.icons")
    require("neogit").setup({
      signs = {
        section = { icons.ui.carret_right, icons.ui.carret_down },
        item = { icons.ui.carret_right, icons.ui.carret_down },
      },
    })

    vim.keymap.set("n", "<leader>gs", require("neogit").open, { desc = "Open Neogit" })
  end,
}
