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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    require("mason-lspconfig").setup({
      handlers = {
        function(server)
          require("lspconfig")[server].setup({
            capabilities = capabilities,
          })
        end,
      },
    })

    require("lazydev").setup()
    require("mason-tool-installer").setup({
      ensure_installed = { "lua_ls", "stylua" },
    })
  end,
}
