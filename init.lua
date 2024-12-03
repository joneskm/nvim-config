vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

local lspconfig = require('lspconfig')
lspconfig.asm_lsp.setup({
    cmd = { "asm-lsp" },  -- Make sure the asm-lsp binary is in your PATH
    filetypes = { "asm", "nasm", "masm", "gas" },  -- File types for which the server should be enabled
   root_dir = function(fname)
        return require('lspconfig.util').root_pattern(".asm-lsp-root", ".git", "Makefile")(fname)
            or require('lspconfig.util').path.dirname(fname)
    end,
    settings = {
        asm = {
            -- Add any specific settings for asm-lsp here
        }
    }
})

lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      assist = { importGranularity = "module", importPrefix = "by_self" },
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true },
    }
  },
    on_attach = function(client, bufnr)
    -- Enable format on save if the server supports formatting
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
        buffer = bufnr,
        callback = function()
          -- Trigger formatting
         
          vim.lsp.buf.format({ async = false })  -- Synchronous formatting
          -- vim.lsp.buf.formatting_sync(nil, 1000)
        end,
      })
    end
  end,

})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
