-- local M = {}

-- -- Run Git blame for a specific line
-- M.get_blame = function(filename, line)
--   local cmd = string.format("git blame -L %d,%d -- %s", line, line, filename)
--   local handle = io.popen(cmd, "r")
--   if handle then
--     local result = handle:read("*a")
--     handle:close()
--     return result
--   end
--   return nil
-- end

local M = {}

-- Function to run a shell command and return output
M.run_cmd = function(cmd)
  local result = vim.fn.systemlist(cmd)

  -- vim.fn.systemlist() returns a table; Check if Git failed
  local exit_code = vim.v.shell_error
  if exit_code ~= 0 then
      return nil
  end

  return table.concat(result, "\n")
end

-- Get Git commit info for the current file and line
M.get_blame = function(filename, line)
    local cmd = string.format("git blame -L %d,%d -- %s", line, line, filename)
    local blame_info = M.run_cmd(cmd)

    if blame_info then
        local commit_hash = blame_info:match("^(%w+)") -- Extract commit hash
        local commit_info = blame_info:match("%((.-)%s%d+%)") -- Extract author & date

        --local commit_hash = blame_info:match("^%w+")
        --local commit_info = blame_info:match("%(.-%) (.-)%s")
        return commit_hash, commit_info
    end
    return nil, nil
end

M.get_github_permalink = function()
    -- Get current file and line number
    local file_path = vim.fn.expand("%") -- Relative path from repo root
    local line = vim.fn.line(".") -- Current line number

    -- Get Git remote URL
    local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
    if not remote_url or remote_url == "" then
        print("Error: Not a Git repository or no remote found.")
        return
    end

    -- Convert SSH or HTTPS remote URL to GitHub web URL
    remote_url = remote_url:gsub("%.git$", "") -- Remove .git extension
    remote_url = remote_url:gsub("git@github.com:", "https://github.com/") -- Convert SSH to HTTPS

    -- Get the current branch or commit hash
    local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
    if branch == "HEAD" then
        branch = vim.fn.systemlist("git rev-parse HEAD")[1] -- Use commit hash if detached
    end

    -- local permalink
    -- if file_path == "README.md" then
    --     -- Use raw.githubusercontent.com for README.md
    --     local repo_path = remote_url:gsub("https://github.com/", "")
    --     permalink = string.format("https://raw.githubusercontent.com/%s/%s/%s", repo_path, branch, file_path)
    -- else
    --     -- Normal GitHub permalink
    --     permalink = string.format("%s/blob/%s/%s#L%d", remote_url, branch, file_path, line)
    -- end

    -- Construct GitHub permalink
    local permalink = string.format("%s/blob/%s/%s#L%d", remote_url, branch, file_path, line)

    -- Copy to clipboard
    vim.fn.setreg("+", permalink) -- Copy to system clipboard
    print("GitHub Permalink copied: " .. permalink)
end


return M



