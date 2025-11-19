return {
  "nvim-mini/mini.nvim",
  config = function ()
    require'mini.trailspace'.setup()
    require'mini.splitjoin'.setup()
    require'mini.diff'.setup()
  end
}
