local codecompanion = require "codecompanion"

local M = {}

M.setup = function()
  codecompanion.setup {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },

    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:gpg --decrypt ~/.anthropic/api.key.gpg 2>/dev/null",
            },
            schema = {
              model = {
                default = "claude-sonnet-4-5-20250929",
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
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:gpg --decrypt ~/.gemini/api.key.gpg 2>/dev/null",
            },
            schema = {
              model = {
                default = "gemini-3-pro-preview",
              },
              reasoning_effort = {
                enabled = true,
                default = "high",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen2.5-coder:3b",
              },
            },
          })
        end,
      },
    },

    display = {
      action_palette = {
        provider = "telescope",
      },
      chat = {
        fold_reasoning = true,
        show_reasoning = true,
      },
    },
  }
end

return M
