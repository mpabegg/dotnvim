vim.pack.add({
  { src = "https://github.com/NickvanDyke/opencode.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
})

vim.g.opencode_opts = {
  provider = {
    enabled = "tmux", -- Default if inside a `tmux` session.
    tmux = {
      options = "-h", -- Options to pass to `tmux split-window`.
    },
  },
}
-- Required for `opts.auto_reload`.
vim.o.autoread = true

-- Opencode keymaps (migrated to `<leader>o` prefix)
-- Prefix: `<leader>o` (opencode)
vim.keymap.set({ "n", "x" }, "<leader>oa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Opencode: Ask" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function()
  require("opencode").select()
end, { desc = "Opencode: Execute action" })
vim.keymap.set({ "n", "t" }, "<leader>ot", function()
  require("opencode").toggle()
end, { desc = "Opencode: Toggle" })
vim.keymap.set({ "n", "x" }, "<leader>op", function()
  require("opencode").prompt("@this")
end, { desc = "Opencode: Add to prompt" })
vim.keymap.set("n", "<leader>ou", function()
  require("opencode").command("session.half.page.up")
end, { desc = "Opencode: half page up" })
vim.keymap.set("n", "<leader>od", function()
  require("opencode").command("session.half.page.down")
end, { desc = "Opencode: half page down" })
-- Legacy convenience: keep '+' and '-' mapped to the default increment/decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
