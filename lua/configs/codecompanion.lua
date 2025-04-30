local codecompanion = require "codecompanion"

local M = {}

M.setup = function()
  codecompanion.setup {
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
    },

    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "cmd:gpg --decrypt ~/.anthropic/api.key.gpg 2>/dev/null",
          },
          schema = {
            model = {
              default = "claude-3-7-sonnet-20250219",
            },
            extended_output = {
              default = false,
            },
            extended_thinking = {
              default = false,
            },
          },
        })
      end,
    },

    display = {
      action_palette = {
        provider = "telescope", -- default|telescope|mini_pick
      },
    },
  }
end

return M
