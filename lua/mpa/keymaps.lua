local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- General keymaps
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- Resize windows
keymap("n", "<C-S-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-S-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-S-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-S-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

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
keymap("n", "<leader>wv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>ws", ":split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>wd", ":close<CR>", { desc = "Close current split" })
