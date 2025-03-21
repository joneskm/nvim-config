local git = require("gitline.git")

local M = {}

-- Highlight group for virtual text
vim.api.nvim_set_hl(0, "GitLineVirtual", { fg = "#444444", italic = true})

-- Namespace for the extmark (so it updates instead of stacking)
local ns_id = vim.api.nvim_create_namespace("gitline")

local last_line = 0 -- Store last processed line
local in_visual_mode = false
M.show_commit_info = function()
 if in_visual_mode then
        return
    end 
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == "" then return end  -- Skip if buffer is empty

  local line = vim.api.nvim_win_get_cursor(0)[1] -- Get current line number
  
  -- Prevent running if we're still on the same line
  if line == last_line then
    return
end
last_line = line -- Update last line
  
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

M.hide_commit_info = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1) -- Clears virtual text
end

M.get_github_permalink = function()
  git.get_github_permalink()
end

-- Auto-update when moving the cursor
vim.api.nvim_create_autocmd({ "CursorHold"}, {
  callback = function()
    M.show_commit_info()
  end,
})

-- Hide commit info when entering Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
      M.hide_commit_info()
  end,
})

-- Show commit info again when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
      -- we need to make sure we show commit info even if we haven't changed lines
      last_line=0
      M.show_commit_info()
  end,
})

-- Hide commit info when entering Visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:[vV]*", -- Triggers when entering any Visual mode (v, V, or Ctrl-V)
    callback = function()
      in_visual_mode = true
      M.hide_commit_info()
    end,
})

-- Show commit info again when leaving Visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "[vV]:*", -- Triggers when leaving Visual mode
    callback = function()
      -- we need to make sure we show commit info even if we haven't changed lines
      last_line=0
      in_visual_mode=false
      M.show_commit_info()  
  end,
})


return M
