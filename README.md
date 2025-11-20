# dotnvim

This is a modular Neovim configuration (mpa) organized under `lua/`. It focuses on a small set of well-integrated plugins and ergonomic keymaps.

## Installation
- Clone into your config dir: `git clone <repo> ~/.config/nvim`
- Requires Neovim >= 0.9. Install `stylua`, `luacheck`, and `busted` if you plan to run lint/format/tests.
- Plugins use native `vim.pack` entries; open Neovim and allow it to install plugins on first run.

## Plugins overview
- Core: `folke/lazy.nvim` for plugin management via `vim.pack`.
- UI: `nvim-lualine/lualine.nvim`, `akinsho/bufferline.nvim`, `nvim-neo-tree/neo-tree.nvim`, `nvim-tree/nvim-web-devicons`.
- Editing: `nvim-treesitter/nvim-treesitter`, `nvim-mini/mini.nvim` (trailspace, bufremove, etc.), `stevearc/conform.nvim` for formatting.
- LSP & completion: LSP setup under `lua/lazy_plugins/lsp.lua` plus `saghen/blink.cmp` for completion and `kevinhwang91/nvim-ufo` for folding.
- Workflow helpers: `folke/which-key.nvim`, `folke/snacks.nvim` (picker), `folke/persistence.nvim` (sessions), `NeogitOrg/neogit`, `aserowy/tmux.nvim`, and `NickvanDyke/opencode.nvim`.

## Quick checks / Developer commands
- Format: `stylua .` (uses `.stylua.toml`) — check with `stylua --check .`
- Lint: `luacheck .`
- Quick config load check: `nvim --headless -c 'luafile init.lua' -c 'qa!'`
- Tests: `busted` (if specs exist); single-file: `busted spec/my_spec.lua`; single-line: `busted spec/my_spec.lua:42`

## Custom Keymaps

Leader keys:
- `mapleader = ' '` (space)
- `maplocalleader = ','` (comma)

| Category    | Mode(s)      | Mapping         | Description                                      |
| ----------- | ------------ | --------------- | ------------------------------------------------ |
| General     | n, v         | `<localleader>x`| Run selection (`:so`)                            |
| General     | n            | `<leader>fs`    | Save file                                        |
| General     | n            | `<leader>qq`    | Quit                                             |
| General     | n            | `<leader>qx`    | Save and quit                                    |
| General     | n            | `<Esc>`         | Clear search highlighting                        |
| Windows     | n            | `<C-S-Up>`      | Increase window height                           |
| Windows     | n            | `<C-S-Down>`    | Decrease window height                           |
| Windows     | n            | `<C-S-Left>`    | Decrease window width                            |
| Windows     | n            | `<C-S-Right>`   | Increase window width                            |
| Windows     | n            | `<leader>wv`    | Split window vertically                          |
| Windows     | n            | `<leader>ws`    | Split window horizontally                        |
| Windows     | n            | `<leader>wd`    | Close current split                              |
| Buffers     | n            | `<S-l>`         | Next buffer                                      |
| Buffers     | n            | `<S-h>`         | Previous buffer                                  |
| Buffers     | n            | `<leader>bd`    | Delete buffer                                    |
| Visual      | v            | `<`             | Indent left                                      |
| Visual      | v            | `>`             | Indent right                                     |
| Visual      | v            | `J`             | Move selection down                              |
| Visual      | v            | `K`             | Move selection up                                |
| Navigation  | n            | `<C-d>`         | Scroll down and center                           |
| Navigation  | n            | `<C-u>`         | Scroll up and center                             |
| Navigation  | n            | `n`             | Next search result and center                    |
| Navigation  | n            | `N`             | Previous search result and center                |
| Diagnostics | n            | `gl`            | Show diagnostic float                            |
| Diagnostics | n            | `[d`            | Jump to next diagnostic                          |
| Diagnostics | n            | `]d`            | Jump to previous diagnostic                      |
| Filetype    | buffer-local n| `q`            | Close help/qf/lspinfo/man/checkhealth windows   |
| Which-key   | n            | `<leader>?`     | Show buffer-local which-key popup               |
| Snacks      | n            | `<leader>ff`    | Find file (Snacks picker)                        |
| Snacks      | n            | `<leader>bb`    | Buffers (Snacks picker)                          |
| Snacks      | n            | `<leader>hk`    | Keymaps (Snacks picker)                          |
| Snacks      | n            | `<leader>hh`    | Help (Snacks picker)                             |
| Snacks      | n            | `<leader>sq`    | Quickfix (Snacks picker)                         |
| Snacks      | n            | `<leader>sl`    | Resume last Snacks picker                        |
| Snacks      | n            | `<leader>/`     | Search project (Snacks grep)                     |
| Snacks      | n            | `<leader>*`     | Grep word under cursor (Snacks)                  |
| Sessions    | n            | `<leader>qs`    | Restore session                                  |
| Sessions    | n            | `<leader>qS`    | Select session                                   |
| Sessions    | n            | `<leader>ql`    | Restore last session                             |
| Sessions    | n            | `<leader>qd`    | Stop saving current session                      |
| Neo-tree    | n            | `<leader>ft`    | Toggle Neo-tree                                  |
| Neo-tree    | n            | `<leader>fr`    | Reveal current file in Neo-tree                  |
| Neo-tree    | n            | `<leader>0`     | Focus Neo-tree window                            |
| Git (Neogit)| n            | `<leader>gs`    | Open Neogit                                      |
| Opencode    | n, x         | `<leader>oa`    | Opencode: Ask                                    |
| Opencode    | n, x         | `<leader>ox`    | Opencode: Execute action                         |
| Opencode    | n, t         | `<leader>ot`    | Opencode: Toggle                                 |
| Opencode    | n, x         | `<leader>op`    | Opencode: Add to prompt                          |
| Opencode    | n            | `<leader>ou`    | Opencode: half page up                           |
| Opencode    | n            | `<leader>od`    | Opencode: half page down                         |

**Notes & Recommendations**
- Duplicate mapping: `<leader>bd` defined both in `lua/mpa/keymaps.lua` and `lua/lazy_plugins/mini.lua`; consider removing one.
- `undodir` is set in `lua/mpa/opts.lua` but directory may not exist by default; consider creating it on startup.
- Use `pcall(require, ...)` for plugin configs to avoid startup failures from a single broken module.
