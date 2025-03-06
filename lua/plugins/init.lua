return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "markdown", "rust", "css"
  		},
      highlight = { enable = true 
      }
    },
  },

{
  'mrcjkb/rustaceanvim',
  version = '^5', -- Recommended
  lazy = false, -- This plugin is already lazy
},

{
    "rmagatti/auto-session",
    lazy=false,
    config = function()
        require("configs.auto_session")
    end,
},



}
