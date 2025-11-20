vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
}, { confirm = false })

require("snacks").setup({
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
  -- Explorer is off by default; you can turn it on later if you like.
  explorer = {
    enabled = false,
    -- Example if you want to experiment later:
    -- tree = true,
    -- hidden = true,
    -- layout = { preset = "sidebar" },
    -- win = {
    --   keys = {
    --     ["h"] = "collapse",
    --     ["l"] = "edit",
    --     ["s"] = "split",
    --     ["v"] = "vsplit",
    --   },
    -- },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files({ hidden = true })
end, { desc = "Find File (Snacks)" })
vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers (Snacks)" })
vim.keymap.set("n", "<leader>hk", function()
  Snacks.picker.keymaps()
end, { desc = "Keymaps (Snacks)" })
vim.keymap.set("n", "<leader>hh", function()
  Snacks.picker.help()
end, { desc = "Help (Snacks)" })
vim.keymap.set("n", "<leader>sq", function()
  Snacks.picker.qflist()
end, { desc = "Quickfix (Snacks)" })
vim.keymap.set("n", "<leader>sl", function()
  Snacks.picker.resume()
end, { desc = "Resume Picker (Snacks)" })
vim.keymap.set("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Search Project (Snacks)" })
vim.keymap.set("n", "<leader>*", function()
  Snacks.picker.grep_word()
end, { desc = "Grep Word (Snacks)" })
