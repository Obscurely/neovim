local M = {}

-- vim options
M.options = {
  user = function()
    require("custom.options")
  end
}

-- UI related customization
M.ui = {
  -- hl_override = {"custom.highlights"},
  theme = "onedark"
}

-- mappings aka key-binds
M.mappings = require "custom.mappings"

-- load plugins
local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

M.plugins = {
  user = userPlugins,
  override = {
    ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.plugin_configs.lspconfig"
    }
  }
}

return M
