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
map("n", "<C-Right>", ":vertical resize +1<CR>", opts) -- Increase width
map("n", "<C-Left>", ":vertical resize -1<CR>", opts)  -- Decrease width
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
