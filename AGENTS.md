Repository Agent Guidelines

**Build / Lint / Test**
- Format: `stylua .` (uses `.stylua.toml`) and check with `stylua --check .`
- Lint: `luacheck .` (install via luarocks or system package manager)
- Run tests: `busted` (or `luatest`) to run all tests; run a single test file with `busted spec/my_spec.lua`
- Run a single test at a specific line: `busted spec/my_spec.lua:42` or use pattern filter `busted -g "pattern"`
- Quick config check: `nvim --headless -c 'luafile init.lua' -c 'qa!'` to surface load-time errors

**Code Style & Conventions**
- Formatting: enforce `stylua` (project `.stylua.toml` present)
- Modules: `local M = {}`; export functions on `M`; `return M` at end
- Imports: use `local mod = require('mpa.foo')`; cache requires in locals
- Naming: file/module names use `snake_case` (e.g. `autocmds.lua`); prefer `snake_case` for functions and variables; UPPER_SNAKE for constants
- Types / annotations: use EmmyLua annotations (`---@param`, `---@return`) for public APIs
- Scope: prefer `local` for all variables; avoid globals except `vim.g` when intentionally needed
- Error handling: prefer returning `nil, err`; use `pcall` for protected API calls; use `vim.notify(err, vim.log.levels.ERROR)` for user-facing errors; avoid noisy `print` usage
- Validation: use `vim.validate` for public function argument checks

**Tests / Files**
- Place tests under `spec/` or `test/` folders
- Run formatting and lint before committing

**Cursor / Copilot rules**
- No `.cursor` or Copilot instruction files found in the repository root (no additional rules detected)

Keep changes minimal and consistent with existing module patterns. Ask before adding new tooling or changing file naming conventions.