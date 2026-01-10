local minuet = require "minuet"

local M = {}

M.setup = function()
  local api_key = vim.fn.system("gpg --decrypt ~/.gemini/api.key.gpg 2>/dev/null"):gsub("%s+", "")

  minuet.setup {
    virtualtext = {
      auto_trigger_ft = {},
      keymap = {
        -- disable mappings since I don't need them and only enable accept and next
        accept = "<C-a>",
        accept_line = nil,
        accept_n_lines = nil,
        prev = nil,
        next = "<C-x>",
        dismiss = nil,
      },
    },
    cmp = {
      enable_auto_complete = false,
    },
    blink = {
      enable_auto_complete = false,
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
