local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    markdown = { "prettier", "injected" },
    toml = { "taplo" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    asm = { "nasmfmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  formatters = {
    nasmfmt = {
      command = "nasmfmt",
      args = { "$FILENAME" },
      stdin = false,
    },
  },

  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "rust" then
      return nil
    end

    return {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

return options
