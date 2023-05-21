local M = {}

-- vim options
M.options = {
  user = function()
    require "custom.options"
  end,
}

-- UI related customizaion
M.ui = {
  theme = "onedark",
  cmp = {
    lspkind_text = true,
    icons = true,
    style = "atom",
    selected_item_bg = "colored",
  },
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  nvdash = {
    load_on_startup = true,
  },
}

-- mappings aka key-binds
M.mappings = require "custom.mappings"

-- load plugins
M.plugins = "custom.plugins"

return M
