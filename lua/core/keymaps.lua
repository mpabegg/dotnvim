-- core/keymaps.lua - Keybindings configuration
local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymaps
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Clear search highlighting
keymap("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlighting" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Keep search terms centered
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Split windows
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>sc", ":close<CR>", { desc = "Close current split" })
