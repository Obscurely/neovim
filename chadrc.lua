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
}

-- mappings aka key-binds
M.mappings = require "custom.mappings"

-- load plugins
local userPlugins = require "custom.plugins"

M.plugins = userPlugins

return M
