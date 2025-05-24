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
        "go",
        "gomod",
        "gowork",
        "gotmpl",
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
    lazy = false,   -- This plugin is already lazy
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("configs.auto_session")
    end,
  },

  {
    "nathangrigg/vim-beancount",
    ft = "beancount"
  },

  {
    "robitx/gp.nvim",
    lazy = false,
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
        openai_api_key = { "cat", vim.fn.expand("~/.config/openai_key") },
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  }

}
