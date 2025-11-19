-- core/options.lua - Neovim options configuration
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Command line
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menuone,noselect"
