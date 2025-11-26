-- ============================================================================
-- Coding (Code Intelligence & Manipulation)
-- ============================================================================

-- Mini.splitjoin
Add { source = 'nvim-mini/mini.splitjoin' }
Later(function()
  require('mini.splitjoin').setup()
end)

-- Treesitter
Add { source = 'nvim-treesitter/nvim-treesitter', hooks = {
  post_checkout = function()
    vim.cmd [[TSUpdate]]
  end,
} }
Later(function()
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    fold = { enable = true },
  }
end)

-- Surround
Add {
  { source = 'kylechui/nvim-surround' },
  { source = 'NStefan002/visual-surround.nvim' },
}
Later(function()
  require('nvim-surround').setup()
  require('visual-surround').setup()
end)

-- Sidekick
Add { { source = 'folke/sidekick.nvim' } }
Later(function()
  require('sidekick').setup {
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
    },
  }

  vim.keymap.set('n', '<leader>aa', require('sidekick.cli').toggle, { desc = 'Sidekick Toggle CLI' })
  vim.keymap.set('n', '<leader>ac', function()
    require('sidekick.cli').toggle { name = 'cursor', focus = true }
  end, { desc = 'Sidekick Toggle Cursor' })
  vim.keymap.set('n', '<leader>ao', function()
    require('sidekick.cli').toggle { name = 'opencode', focus = true }
  end, { desc = 'Sidekick Toggle OpenCode' })
  vim.keymap.set({ 'n', 'x' }, '<leader>ap', function()
    require('sidekick.cli').prompt()
  end, { desc = 'Sidekick Select Prompt' })
end)

-- Blink (Completion)
Add {
  source = 'saghen/blink.cmp',
  depends = {
    'rafamadriz/friendly-snippets',
    'folke/lazydev.nvim',
  },
}
Later(function()
  require('blink.cmp').setup {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'normal' },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    fuzzy = { implementation = 'lua' },
    signature = { enabled = true },
  }
end)

-- LSP
Add {
  source = 'neovim/nvim-lspconfig',
  depends = {
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
  },
}

Later(function()
  require('lazydev').setup {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }

  require('mason').setup()
  require('mason-tool-installer').setup {}

  local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
  local ufo_ok, _ = pcall(require, 'ufo')
  if ufo_ok then
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
  end

  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'Later', 'Add', 'Now' },
        },
      },
    },
  })

  -- Helper function to find umbrella project root
  -- Prioritizes git root, then topmost Gemfile
  local function find_umbrella_root(fname)
    local path = vim.fs.dirname(fname)

    -- First, try to find git root (most reliable for umbrella projects)
    local git_root = vim.fs.find('.git', { path = path, upward = true, type = 'directory' })[1]
    if git_root then
      return vim.fs.dirname(git_root)
    end

    -- Fall back to finding topmost Gemfile by walking up the tree
    local current = path
    local topmost_gemfile = nil
    while current ~= '/' and current ~= '' do
      local gemfile = vim.fs.joinpath(current, 'Gemfile')
      if vim.fn.filereadable(gemfile) == 1 then
        topmost_gemfile = current
      end
      local parent = vim.fs.dirname(current)
      if parent == current then
        break
      end
      current = parent
    end

    if topmost_gemfile then
      return topmost_gemfile
    end

    -- Fallback: use CWD if it contains a Gemfile
    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(vim.fs.joinpath(cwd, 'Gemfile')) == 1 then
      return cwd
    end

    -- Fallback to current file's directory
    return path
  end

  vim.lsp.config('ruby_lsp', {
    root_dir = function(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local root = find_umbrella_root(fname)
      if root then
        on_dir(root)
      end
    end,
    on_new_config = function(new_config, new_root_dir)
      if vim.fn.filereadable(vim.fs.joinpath(new_root_dir, 'bin', 'rubocop')) == 1 then
        new_config.init_options = new_config.init_options or {}
        new_config.init_options.formatter = 'none'
        new_config.init_options.enabledFeatures = new_config.init_options.enabledFeatures or {}
      end
    end,
  })

  -- vtsls (TypeScript/JavaScript LSP) - formatting disabled
  vim.lsp.config('vtsls', {
    settings = {
      vtsls = {
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        inlayHints = {
          parameterNames = { enabled = 'all' },
          variableTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = 'all' },
          variableTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
    },
    init_options = {
      publishDiagnostics = true,
    },
    on_new_config = function(new_config, _)
      -- Explicitly disable formatting for vtsls
      new_config.capabilities = new_config.capabilities or {}
      new_config.capabilities.documentFormattingProvider = false
      new_config.capabilities.documentRangeFormattingProvider = false
    end,
  })

  vim.lsp.enable { 'lua_ls', 'ruby_lsp', 'vtsls' }
end)

-- Formatting & Linting (none-ls)
Add {
  source = 'nvimtools/none-ls.nvim',
  depends = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
}
Later(function()
  local null_ls = require 'null-ls'
  local formatting = null_ls.builtins.formatting

  local sources = {
    formatting.stylua,
    formatting.prettier.with { prefer_local = 'node_modules/.bin' },
  }

  -- ESLint from extras
  local ok_fmt, eslint_fmt = pcall(require, 'none-ls.formatting.eslint')
  if ok_fmt then
    table.insert(sources, eslint_fmt.with { prefer_local = 'node_modules/.bin' })
  end

  local ok_diag, eslint_diag = pcall(require, 'none-ls.diagnostics.eslint')

  if ok_diag then
    table.insert(sources, eslint_diag.with { prefer_local = 'node_modules/.bin' })
  end

  null_ls.setup {
    sources = sources,
    on_attach = function(client, bufnr)
      if client:supports_method 'textDocument/formatting' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('NoneLsFormatting', { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format {
              bufnr = bufnr,
              async = false,
              filter = function(c)
                return c.name == 'null-ls'
              end,
            }
          end,
        })
      end
    end,
  }
end)
