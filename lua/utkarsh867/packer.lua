--loclist, Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-telescope/telescope-live-grep-args.nvim" }
    }
  }
  -- use({ 'rose-pine/neovim', as = 'rose-pine', config = function()
  -- 	vim.cmd('colorscheme rose-pine')
  -- end})
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use("nvim-treesitter/nvim-treesitter-context");
  use 'nvim-treesitter/playground'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use({
    'folke/trouble.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons' }
    },
    config = function()
      require("trouble").setup {
        icons = false,
        mode = "document_diagnostics"
      }
    end
  })
  use { 'williamboman/mason.nvim' }           -- Optional
  use { 'williamboman/mason-lspconfig.nvim' } -- Optional

  use { 'L3MON4D3/LuaSnip' }                  -- Required
  use { 'rafamadriz/friendly-snippets' }      -- Optional
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- remote highlights after search :noh
  use 'jesseleite/vim-noh'
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  }
end)
