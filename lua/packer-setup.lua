-- Bootstrap `packer` if it's not installed yet
-- This will take care of installing `packer` on new installations
local ensure_packer = function()
  local fun = vim.fn
  local install_path = fun.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fun.empty(fun.glob(install_path)) > 0 then
    fun.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

vim.g.flc_is_packer_bootstrapped = ensure_packer()

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy' },

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use { 'https://github.com/editorconfig/editorconfig-vim' }

  -- file navigator
  use {
    'https://github.com/nvim-neo-tree/neo-tree.nvim',
      branch = "v3.x",
      requires = {
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'https://github.com/MunifTanjim/nui.nvim',
      }
  }

  use {
    'https://github.com/willothy/nvim-cokeline',
    requires = {
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if vim.g.flc_is_packer_bootstrapped then
    require('packer').sync()
  end
end)
