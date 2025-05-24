return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    git_status = {
      symbols = {
        added     = "✚",
        modified  = "",
        deleted   = "✖",
        renamed   = "➜",
        untracked = "",
        ignored   = "◌",
        unstaged  = "󰄱",
        staged    = "✓",
        conflict  = "",
      },
    },
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true, -- optional: do not collapse other folders when expanding
      },
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
      },
      renderers = {
        file = {
          { "icon" },
          { "name",       use_git_status_colors = false },
          { "diagnostics" },
          { "git_status" },
        },
        directory = {
          { "icon" },
          { "name",       use_git_status_colors = false },
          { "diagnostics" },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      symbols = {
        error = "",
        warn  = "",
        info  = "",
        hint  = "",

      },

    },
  }
}
