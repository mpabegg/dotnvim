return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "folke/lazydev.nvim",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup()
    require("lazydev").setup()
    require("mason-tool-installer").setup({
      ensure_installed = { "lua_ls", "stylua" },
    })
  end,
}
