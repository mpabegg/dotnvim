# dotnvim

My personal Neovim configuration, built with Lua and lazy.nvim.

## Features

- **Modern Lua Configuration**: Clean and modular setup using Lua
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management
- **Color Scheme**: Tokyo Night theme with customization options
- **Fuzzy Finder**: Telescope for file searching and navigation
- **File Explorer**: nvim-tree for browsing project files
- **Syntax Highlighting**: Treesitter for advanced syntax highlighting
- **Git Integration**: Gitsigns for git status and navigation
- **Status Line**: Beautiful lualine status bar
- **Auto-pairs**: Automatically close brackets and quotes
- **Commenting**: Easy code commenting with Comment.nvim
- **Indentation Guides**: Visual indentation markers

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)
- ripgrep (for Telescope live grep)
- A C compiler (for Telescope fzf-native and Treesitter)

## Installation

1. **Backup your existing Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/mpabegg/dotnvim.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   Lazy.nvim will automatically install all plugins on first launch.

## Structure

```
~/.config/nvim/
├── init.lua                  # Main configuration entry point
├── lua/
│   ├── core/
│   │   ├── options.lua       # Neovim options
│   │   ├── keymaps.lua       # Keybindings
│   │   ├── autocmds.lua      # Autocommands
│   │   └── lazy.lua          # Plugin manager setup
│   └── plugins/
│       ├── colorscheme.lua   # Color scheme
│       ├── treesitter.lua    # Syntax highlighting
│       ├── telescope.lua     # Fuzzy finder
│       ├── lualine.lua       # Status line
│       ├── nvim-tree.lua     # File explorer
│       ├── gitsigns.lua      # Git integration
│       ├── autopairs.lua     # Auto-close pairs
│       ├── comment.lua       # Commenting
│       └── indent-blankline.lua  # Indentation guides
└── .gitignore
```

## Key Mappings

Leader key is set to `<Space>`.

### General
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>x` - Save and quit
- `<Esc>` - Clear search highlighting

### Window Navigation
- `<C-h>` - Move to left window
- `<C-j>` - Move to lower window
- `<C-k>` - Move to upper window
- `<C-l>` - Move to right window

### Window Splits
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>sc` - Close current split

### Buffer Management
- `<S-l>` - Next buffer
- `<S-h>` - Previous buffer
- `<leader>bd` - Delete buffer

### File Explorer
- `<leader>e` - Toggle nvim-tree

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files

### Git
- `]c` - Next git hunk
- `[c` - Previous git hunk
- `<leader>gs` - Stage hunk
- `<leader>gr` - Reset hunk
- `<leader>gp` - Preview hunk
- `<leader>gb` - Blame line

## Customization

To customize the configuration:

1. Edit core settings in `lua/core/`
2. Add or modify plugins in `lua/plugins/`
3. Each plugin is in its own file for easy management

## Plugin Management

Lazy.nvim commands:
- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Install, update, and clean plugins
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins

## License

This configuration is free to use and modify for personal use.