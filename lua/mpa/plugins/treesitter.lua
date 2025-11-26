-- Treesitter
Add {
  source = 'nvim-treesitter/nvim-treesitter',
  hooks = {
    post_checkout = function()
      vim.cmd [[TSUpdate]]
    end,
  },
}
Later(function()
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    fold = { enable = true },
  }
end)
