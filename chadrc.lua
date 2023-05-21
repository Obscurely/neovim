local M = {}

-- vim options
M.options = {
  user = function()
    require "custom.options"
  end,
}

-- UI related customization
M.ui = {
  theme = "onedark",
  statusline = {
    separator_style = "round",
  },
}

-- mappings aka key-binds
M.mappings = require "custom.mappings"

-- load plugins
M.plugins = "custom.plugins"

return M
