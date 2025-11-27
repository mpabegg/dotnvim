vim.pack.add({ 'https://github.com/nvim-mini/mini.deps' }, { confirm = false })
require('mini.deps').setup({})

-- Helper: add one or many plugin specs
local function add_specs(specs)
  local t = type(specs)

  if t == 'table' then
    -- List of specs: { {...}, {...}, ... }
    if specs[1] ~= nil then
      for _, spec in ipairs(specs) do
        MiniDeps.add(spec)
      end
    else
      -- Single spec table: { source = "...", ... }
      MiniDeps.add(specs)
    end
  elseif t == 'string' then
    -- Shorthand: "user/repo"
    MiniDeps.add({ source = specs })
  else
    error(('Add(): invalid spec of type %s'):format(t))
  end
end

Add = add_specs
XAdd = function(_) end
Now = MiniDeps.now -- keep original semantics
XNow = function(_) end
Later = MiniDeps.later -- keep original semantics
XLater = function(_) end
