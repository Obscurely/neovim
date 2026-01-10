local minuet = require "minuet"

local M = {}

M.setup = function()
  local api_key = vim.fn.system("gpg --decrypt ~/.gemini/api.key.gpg 2>/dev/null"):gsub("%s+", "")

  minuet.setup {
    virtualtext = {
      auto_trigger_ft = {},
      keymap = {
        -- accept whole completion
        accept = "<A-A>",
        -- accept one line
        accept_line = "<C-a>",
      },
    },
    provider = "gemini",
    provider_options = {
      gemini = {
        model = "gemini-2.0-flash",
        stream = true,
        api_key = function()
          return api_key
        end,
      },
    },
  }
end

return M
