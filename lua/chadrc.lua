-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- Modified version of https://github.com/NvChad/ui/blob/27f449be42b360cbb9f133aa8853017d277f0c49/lua/nvchad/tabufline/modules.lua#L37
-- with "NvimTree" replaced with "neo-tree"
local function getNvimTreeWidth()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == "neo-tree" then
      return vim.api.nvim_win_get_width(win)
    end
  end
  return 0
end


local sep_style = "default"
local utils = require "nvchad.stl.utils"

local sep_icons = utils.separators
local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = separators["right"]

M.ui = {
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    bufwidth = 21,
    modules = {
      treeOffset = function()
        local w = getNvimTreeWidth()
        return w == 0 and "" or "%#NeoTreeNormal#" .. string.rep(" ", w + 1) .. "%#NeoTreeWinSeparator#" .. ""
      end,
    },
  },
  statusline = {
    enabled = true,
    modules = {
      -- A modification of the ui plugin to include the percentage into the file
      -- and the total number of lines, original:
      -- https://github.com/NvChad/ui/blob/27f449be42b360cbb9f133aa8853017d277f0c49/lua/nvchad/stl/default.lua#L54
      cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %l/%L %v %p %%",

      --- A modification of the ui plugin to include the file path, original:
      --- https://github.com/NvChad/ui/blob/27f449be42b360cbb9f133aa8853017d277f0c49/lua/nvchad/stl/default.lua#L27-L31
      file = function()
        local x = utils.file()
        -- this is where we deviate from the ui plugin, we use the vim api to get the relative path
        -- not just the filename returned by the utils.file() function
        local name = " " .. vim.fn.expand("%:~:.") .. (sep_style == "default" and " " or "")
        return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
      end
    }
  },
}

return M
