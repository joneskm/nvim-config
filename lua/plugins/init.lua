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
    "simrat39/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig", -- Required for LSP
    },
    ft = { "rust" }, -- Load when editing Rust files
    config = function()
      require("rust-tools").setup({
        tools = { -- rust-tools settings
          inlay_hints = {
            auto = true, -- Automatically enable inlay hints
            show_parameter_hints = true, -- Show hints for function parameters
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        server = { -- rust-analyzer LSP settings
          on_attach = function(_, bufnr)
            -- Add key mappings or other on_attach settings
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          end,
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
            },
          },
        },
      })
    end,
  },
}


