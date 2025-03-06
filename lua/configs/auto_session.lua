local auto_session = require("auto-session")

auto_session.setup({
    log_level = "error",
    auto_restore_enabled = true,
    auto_save_enabled = true,
    pre_save_cmds = { "NvimTreeClose" },  -- Optional, close NvimTree before saving
    cwd_change_handling = {
        restore_upcoming_session = true,
    }
})

-- Optional keymaps for manually saving and loading sessions
vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>sl", "<cmd>SessionLoad<CR>", { desc = "Load session" })
