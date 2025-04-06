require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
--

-- Resize File Explorer (NvimTree/NeoTree)


local opts = { noremap = true, silent = true }
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })

-- Function to resize Neo-tree window
function Resize_neotree(amount)
  -- Iterate over all windows to find Neo-tree
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match("neo%-tree") then
      -- Resize the Neo-tree window
      vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + amount)
      break
    end
  end
end

-- Mapping to increase window width
map('n', '<C-Right>', ':lua Resize_neotree(1)<CR>', { noremap = true, silent = true })
-- Mapping to decrease window width
map('n', '<C-Left>', ':lua Resize_neotree(-1)<CR>', { noremap = true, silent = true })
