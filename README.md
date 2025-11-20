# dotnvim

This is a modular Neovim configuration (mpa) organized under `lua/`. It focuses on a small set of well-integrated plugins and ergonomic keymaps.

## Installation
- Clone into your config dir: `git clone <repo> ~/.config/nvim`
- Requires Neovim >= 0.9. Install `stylua`, `luacheck`, and `busted` if you plan to run lint/format/tests.
- Plugins use native `vim.pack` entries; open Neovim and allow it to install plugins on first run.

## Quick checks / Developer commands
- Format: `stylua .` (uses `.stylua.toml`) — check with `stylua --check .`
- Lint: `luacheck .`
- Quick config load check: `nvim --headless -c 'luafile init.lua' -c 'qa!'`
- Tests: `busted` (if specs exist); single-file: `busted spec/my_spec.lua`; single-line: `busted spec/my_spec.lua:42`

## Custom Keymaps
Leader keys:
- `mapleader = ' '` (space)
- `maplocalleader = ','` (comma)

General:
- `<localleader>x` (n, v) — `:so` — Run Selection
- `<leader>fs` (n) — `:w` — Save file
- `<leader>qq` (n) — `:q` — Quit
- `<leader>qx` (n) — `:x` — Save and quit
- `<C-S-Up>` (n) — `:resize +2` — Increase window height
- `<C-S-Down>` (n) — `:resize -2` — Decrease window height
- `<C-S-Left>` (n) — `:vertical resize -2` — Decrease window width
- `<C-S-Right>` (n) — `:vertical resize +2` — Increase window width
- `<S-l>` (n) — `:bnext` — Next buffer
- `<S-h>` (n) — `:bprevious` — Previous buffer
- `<leader>bd` (n) — `:bdelete` — Delete buffer
- `<Esc>` (n) — `:noh` — Clear search highlighting
- `<leader>wv` (n) — `:vsplit` — Split window vertically
- `<leader>ws` (n) — `:split` — Split window horizontally
- `<leader>wd` (n) — `:close` — Close current split

Visual / Text movement:
- `<` (v) — `<gv` — Indent left
- `>` (v) — `>gv` — Indent right
- `J` (v) — `:m '>+1<CR>gv=gv` — Move selected block down
- `K` (v) — `:m '<-2<CR>gv=gv` — Move selected block up

Navigation niceties:
- `<C-d>` (n) — `<C-d>zz` — Scroll down and center
- `<C-u>` (n) — `<C-u>zz` — Scroll up and center
- `n` (n) — `nzzzv` — Next search result and center
- `N` (n) — `Nzzzv` — Prev search result and center

Diagnostics:
- `gl` (n) — Show diagnostic float
- `[d` (n) — Diagnostic jump (next)
- `]d` (n) — Diagnostic jump (prev)

Filetype / buffer helpers:
- `q` (n, buffer-local) — Close help/qf/lspinfo/man/checkhealth windows

Which-key:
- `<leader>?` (n) — Show buffer-local which-key popup

Snacks (finder):
- `<leader>ff` (n) — Find File (Snacks)
- `<leader>bb` (n) — Buffers (Snacks)
- `<leader>hk` (n) — Keymaps (Snacks)
- `<leader>hh` (n) — Help (Snacks)
- `<leader>sq` (n) — Quickfix (Snacks)
- `<leader>sl` (n) — Resume Picker (Snacks)
- `<leader>/` (n) — Search Project (Snacks)
- `<leader>*` (n) — Grep Word (Snacks)

Persistence (sessions):
- `<leader>qs` (n) — Restore Session
- `<leader>qS` (n) — Select Session
- `<leader>ql` (n) — Restore Last Session
- `<leader>qd` (n) — Don't Save Current Session

Neo-tree (file explorer):
- `<leader>ft` (n) — Toggle NeoTree
- `<leader>fr` (n) — Reveal current file in NeoTree
- `<leader>0` (n) — Focus NeoTree

Neogit:
- `<leader>gs` (n) — Open Neogit

Opencode:
- `<leader>oa` (n, x) — Opencode: Ask
- `<leader>ox` (n, x) — Opencode: Execute action
- `<leader>ot` (n, t) — Opencode: Toggle
- `<leader>op` (n, x) — Opencode: Add to prompt
- `<leader>ou` (n) — Opencode: half page up
- `<leader>od` (n) — Opencode: half page down
- `+` (n) — Increment (legacy; maps to `<C-a>`)
- `-` (n) — Decrement (legacy; maps to `<C-x>`)

**Notes & Recommendations**
- Duplicate mapping: `<leader>bd` defined both in `lua/mpa/keymaps.lua` and `lua/plugins/mini.lua`; consider removing one.
- `undodir` is set in `lua/mpa/opts.lua` but directory may not exist by default; consider creating it on startup.
- Use `pcall(require, ...)` for plugin configs to avoid startup failures from a single broken module.

Contributions welcome — open an issue or PR for changes.