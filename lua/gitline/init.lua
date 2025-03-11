local git = require("gitline.git")

local M = {}

-- Highlight group for virtual text
vim.api.nvim_set_hl(0, "GitLineVirtual", { fg = "#888888", italic = true })

-- Namespace for the extmark (so it updates instead of stacking)
local ns_id = vim.api.nvim_create_namespace("gitline")

M.show_commit_info = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == "" then return end  -- Skip if buffer is empty

  local line = vim.api.nvim_win_get_cursor(0)[1] -- Get current line number
  local commit_hash, commit_info = git.get_blame(filename, line)

  -- Clear previous virtual text
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  if commit_hash and commit_info then
    -- Extract commit hash (first word)
    --local commit_hash = result:match("^(%w+)")

    -- Extract text inside parentheses
    --local commit_info = result:match("%((.-)%s%d+%)")
    --local commit_hash = blame_info:match("^%w+")
    --local commit_msg = blame_info:match("%(.-%) (.-)%s")

    local text = string.format(" [%s] %s", commit_hash, commit_info)
    
    -- Add virtual text only for the current line
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, line - 1, -1, {
      virt_text = { { text, "GitLineVirtual" } },
      virt_text_pos = "eol",
    })
  end
end

M.get_github_permalink = function()
  git.get_github_permalink()
end

-- Auto-update when moving the cursor
vim.api.nvim_create_autocmd({"CursorMoved", "CursorHold"}, {
  callback = function()
    M.show_commit_info()
  end,
})

return M
