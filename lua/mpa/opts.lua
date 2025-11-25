vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.colorcolumn = '120'
vim.o.laststatus = 3
vim.o.wrap = false
vim.opt.list = true
vim.opt.winborder = 'rounded'
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.scrolloff = 8
vim.o.autochdir = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.showcmd = true
vim.o.cmdheight = 1
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath 'data' .. '/undodir'
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.o.mouse = 'a'
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.opt.formatoptions:remove { 'c', 'r', 'o' }
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

function Statuscolumn()
  return package.loaded.snacks and require('snacks.statuscolumn').get() or ''
end
vim.opt.statuscolumn = [[%!v:lua.Statuscolumn()]]
