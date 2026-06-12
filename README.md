# Neovim from (almost) scratch

This is a Neovim reconfiguration, meaning I'm dropping years of configurations
I've been carrying around. I'll be using
[nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), to have
a sane and cute starting point.

I'm following TJ Devries' video [Effective Neovim: Instant
IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)

## Requirements

- Neovim 0.11 or later
- `git`
- `make`
- `gcc`
- Node.js and `npm`

## Installation

1. Clone this repository into `~/.config/nvim`.
2. Launch Neovim once. Packer will bootstrap itself and install all plugins.
   You will see a message saying plugins are being installed; wait until it
   finishes, **then quit Neovim**.
3. Launch Neovim again. On this run the full configuration loads, Mason
   installs the configured LSP servers, and Tree-sitter installs the configured
   parsers.

## Features

### LSP and completion

| Plugin | Description |
|--------|-------------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quick-start configurations for built-in LSP client |
| [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | Portable package manager for LSP servers, DAP servers, linters and formatters |
| [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridges mason.nvim and lspconfig |
| [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress notifications in the corner |
| [folke/neodev.nvim](https://github.com/folke/neodev.nvim) | Helpers for Neovim Lua development |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP source for nvim-cmp |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | LuaSnip source for nvim-cmp |

### Syntax and navigation

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Incremental parsing for syntax highlighting and structural navigation |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects and motions powered by Tree-sitter |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder over lists |
| [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native C implementation of fzf algorithm for Telescope |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [willothy/nvim-cokeline](https://github.com/willothy/nvim-cokeline) | Buffer line with clickable close buttons |

### Git

| Plugin | Description |
|--------|-------------|
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) | Git wrapper |
| [tpope/vim-rhubarb](https://github.com/tpope/vim-rhubarb) | GitHub extension for fugitive |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git diff decorations in the sign column |

### Appearance and editing

| Plugin | Description |
|--------|-------------|
| [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim) | One Dark color scheme |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Fast and configurable status line |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides on blank lines |
| [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments with `gc` |
| [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth) | Auto-detect `tabstop` and `shiftwidth` |

### Package manager

| Plugin | Description |
|--------|-------------|
| [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) | Plugin manager |

## LSP servers

The following language servers are configured and automatically installed via
Mason:

- `lua_ls` — Lua (with Neovim globals recognized)
- `ts_ls` — TypeScript and JavaScript
- `denols` — Deno (attaches only when `deno.json` or `deno.jsonc` is present)
- `biome` — Biome formatter/linter (attaches only when `biome.json` is present)
- `eslint` — ESLint (attaches only when an ESLint flat config is present)

## Leader key

`<Space>` is the leader key.
