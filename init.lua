-- init.lua - Main Neovim configuration entry point
-- Load core configuration modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Setup plugin manager (lazy.nvim)
require("core.lazy")
