--loclist, Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		requires = {
      {'nvim-lua/plenary.nvim'},
      { "nvim-telescope/telescope-live-grep-args.nvim" }
    }
	}
	-- use({ 'rose-pine/neovim', as = 'rose-pine', config = function()
	-- 	vim.cmd('colorscheme rose-pine')
	-- end})
  use { "catppuccin/nvim", as = "catppuccin"}
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
      {'nvim-tree/nvim-web-devicons'}
    },
    config = function()
      require("trouble").setup {
        icons = false,
        mode = "document_diagnostics"
      }
    end
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.formatting.rustfmt,
          require("null-ls").builtins.formatting.black,
          require("null-ls").builtins.formatting.isort
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({async = false})
              end,
            })
          end
        end,
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	}
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
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
end)
