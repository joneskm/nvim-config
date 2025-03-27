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
  cmd = { "asm-lsp" },                          -- Make sure the asm-lsp binary is in your PATH
  filetypes = { "asm", "nasm", "masm", "gas" }, -- File types for which the server should be enabled
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

-- lspconfig.rust_analyzer.setup({
--   settings = {
--     ["rust-analyzer"] = {
--       assist = { importGranularity = "module", importPrefix = "by_self" },
--       cargo = { loadOutDirsFromCheck = true },
--       procMacro = { enable = true },
--     }
--   },
--     on_attach = function(client, bufnr)
--     -- Enable format on save if the server supports formatting
--     if client.server_capabilities.documentFormattingProvider then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
--         buffer = bufnr,
--         callback = function()
--           -- Trigger formatting
--
--           vim.lsp.buf.format({ async = false })  -- Synchronous formatting
--           -- vim.lsp.buf.formatting_sync(nil, 1000)
--         end,
--       })
--     end
--   end,
--
-- })
--
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

vim.keymap.set("n", "<leader>a", function()
  vim.lsp.buf.code_action()
end, { desc = "Show quick fixes (code actions)" })

-- Add inlay hints when LSP attaches (for all languages)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

-- Auto format files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.lua" },
  callback = function()
    vim.lsp.buf.format({ async = false })

    -- Redraw existing diagnostics from all namespaces
    vim.diagnostic.hide(nil, 0)
    vim.diagnostic.show(nil, 0)
  end,
})

-- Auto format golang files on save - we use goimports rather than gopls because it fixes imports at the same time
-- Notice: this is done post save since the file must be written to disk before calling goimports
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    -- Run goimports and write the file manually
    vim.cmd("silent! !goimports -w %")
    -- Reload the buffer to reflect the new changes
    vim.cmd("edit!")
  end,
})

-- Set key binding for go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })


vim.opt.spell = true
vim.opt.spelllang = { "en" } -- Set to your desired language(s)


require("gitline").show_commit_info()

vim.api.nvim_create_user_command("GitHubLink", function()
  require("gitline").get_github_permalink()
end, {})

vim.api.nvim_create_user_command("CopyFilePath", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    print("No file path (maybe an empty buffer?)")
    return
  end
  vim.fn.setreg('+', path) -- copy to system clipboard
  print("Copied to clipboard: " .. path)
end, {})

vim.keymap.set("n", "<leader>cp", "<cmd>CopyFilePath<CR>", { desc = "Copy file path to clipboard" })
